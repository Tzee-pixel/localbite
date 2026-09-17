import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  Image,
  TouchableOpacity,
  Linking,
  Dimensions,
  ActivityIndicator,
} from 'react-native';
import { useRoute, useNavigation } from '@react-navigation/native';
import {
  ArrowLeft,
  Bookmark,
  SpeakerHigh,
  MapPin,
  MapTrifold,
  ArrowRight,
  ArrowSquareOut,
  Star,
  Check,
  Lightbulb,
} from 'phosphor-react-native';
import { Audio } from 'expo-av';
import { useDish, useResolvedLocation } from '../lib/queries';
import { useLocation } from '../context/LocationContext';
import { isDishFavourite, toggleFavouriteDishId } from '../lib/favourites';
import TrustCards from '../components/TrustCards';
import { colors, typography, spacing, borderRadius, shadows } from '../theme';

import { getDishImageSources } from '../lib/dishImages';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

const ImpactText: React.FC<{ text: any; style?: any }> = ({ text, style }) => {
  if (!text) return null;
  const str = typeof text === 'string' ? text : String(text);
  if (!str.trim()) return null;

  const boldStyle = {
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700' as const,
    color: colors.ink,
  };

  const parseParts = (inputStr: string) => {
    if (!inputStr.includes('**')) {
      return inputStr;
    }
    const parts = inputStr.split('**');
    return parts.map((part, i) =>
      i % 2 === 1 ? (
        <Text key={`b-${i}`} style={[style, boldStyle]}>
          {part}
        </Text>
      ) : (
        part
      )
    );
  };

  if (str.includes('"')) {
    const quoteParts = str.split('"');
    return (
      <Text style={style}>
        {quoteParts.map((part, i) =>
          i % 2 === 1 ? (
            <Text key={`q-${i}`} style={[style, boldStyle]}>
              "{part}"
            </Text>
          ) : (
            parseParts(part)
          )
        )}
      </Text>
    );
  }

  if (str.includes('**')) {
    return <Text style={style}>{parseParts(str)}</Text>;
  }

  return <Text style={style}>{str}</Text>;
};

export function parseStructuredSections(rawData?: string[] | string | null): { title: string; description: string }[] {
  if (!rawData) return [];
  const entries = Array.isArray(rawData) ? rawData : [rawData];
  const results: { title: string; description: string }[] = [];

  entries.forEach((entry) => {
    if (!entry || typeof entry !== 'string') return;
    let clean = entry.trim();
    if (clean.startsWith('{') && clean.endsWith('}')) {
      clean = clean.slice(1, -1);
    }
    if (clean.startsWith('"') && clean.endsWith('"')) {
      clean = clean.slice(1, -1);
    }
    clean = clean.replace(/\\"/g, '"').replace(/\\n/g, '\n').trim();
    if (!clean || clean === '-' || clean.toLowerCase() === 'n/a') return;

    let blocks: string[] = [];
    if (clean.includes('|')) {
      blocks = clean.split('|').map((b) => b.trim()).filter(Boolean);
    } else if (/\r?\n\s*\r?\n/.test(clean)) {
      blocks = clean.split(/(?:\r?\n\s*){2,}/).map((b) => b.trim()).filter(Boolean);
    } else if (clean.includes(';')) {
      blocks = clean.split(';').map((b) => b.trim()).filter(Boolean);
    } else {
      const lines = clean.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
      if (lines.length >= 2 && lines.length % 2 === 0) {
        for (let i = 0; i < lines.length; i += 2) {
          blocks.push(`${lines[i]}\n${lines[i + 1]}`);
        }
      } else {
        blocks = [clean];
      }
    }

    blocks.forEach((block) => {
      let bClean = block.trim().replace(/^[\{\}\"\'\\]+/g, '').replace(/[\{\}\"\'\\]+$/g, '').trim();
      if (!bClean) return;

      if (bClean.includes(':')) {
        const [t, ...d] = bClean.split(':');
        const cleanTitle = t.replace(/^(?:step\s*)?0*\d+[\s\.\:\-\)\–]+\s*/i, '').trim();
        const desc = d.join(':').trim();
        if (cleanTitle) {
          results.push({ title: cleanTitle, description: desc });
        }
      } else {
        const blockLines = bClean.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
        if (blockLines.length >= 2) {
          const cleanTitle = blockLines[0].replace(/^(?:step\s*)?0*\d+[\s\.\:\-\)\–]+\s*/i, '').trim();
          const desc = blockLines.slice(1).join(' ').trim();
          if (cleanTitle) {
            results.push({ title: cleanTitle, description: desc });
          }
        } else if (blockLines.length === 1) {
          const line = blockLines[0];
          const match = line.match(/^(?:step\s*)?0*\d+[\s\.\:\-\)\–]+\s*([A-Za-z0-9\s\-\(\)\/\,\'\"]{3,40}?)\s+([A-Z].+)$/);
          if (match) {
            results.push({ title: match[1].trim(), description: match[2].trim() });
          } else {
            const cleanTitle = line.replace(/^(?:step\s*)?0*\d+[\s\.\:\-\)\–]+\s*/i, '').trim();
            if (cleanTitle) {
              results.push({ title: cleanTitle, description: '' });
            }
          }
        }
      }
    });
  });

  return results;
}

export function parseTagList(rawData?: any): string[] {
  if (!rawData) return [];
  const entries = Array.isArray(rawData) ? rawData : [rawData];
  const results: string[] = [];

  entries.forEach((entry) => {
    if (!entry) return;
    if (typeof entry !== 'string') {
      if (Array.isArray(entry)) {
        results.push(...parseTagList(entry));
      }
      return;
    }

    let clean = entry.trim();
    if (!clean || clean === '{}' || clean === '[]') return;

    // JSON array string: e.g. ["Vegetarian", "Halal"]
    if (clean.startsWith('[') && clean.endsWith(']')) {
      try {
        const parsed = JSON.parse(clean);
        if (Array.isArray(parsed)) {
          results.push(...parseTagList(parsed));
          return;
        }
      } catch {}
    }

    // Postgres array format: e.g. {"Vegetarian","Halal","Seasonal peak"}
    if (clean.startsWith('{') && clean.endsWith('}')) {
      const inner = clean.slice(1, -1).trim();
      if (!inner) return;
      const matches = inner.match(/(".*?"|[^",\s]+)(?=\s*,|\s*$)/g);
      if (matches && matches.length > 0) {
        matches.forEach((m) => {
          const item = m.replace(/^["']|["']$/g, '').trim();
          if (item) results.push(item);
        });
        return;
      }
      inner.split(',').forEach((p) => {
        const item = p.replace(/^["']|["']$/g, '').trim();
        if (item) results.push(item);
      });
      return;
    }

    // Handle any leftover braces or quotes
    if (clean.includes('{') || clean.includes('}')) {
      const stripped = clean.replace(/[{}]/g, '').trim();
      stripped.split(',').forEach((p) => {
        const item = p.replace(/^["']|["']$/g, '').trim();
        if (item) results.push(item);
      });
      return;
    }

    const item = clean.replace(/^["']|["']$/g, '').trim();
    if (item) results.push(item);
  });

  return Array.from(new Set(results.filter((t) => t && t.toLowerCase() !== 'local classic')));
}

export const DishDetailScreen: React.FC = () => {
  const route = useRoute<any>();
  const navigation = useNavigation<any>();
  const { dishId } = route.params || {};

  const { coords } = useLocation();
  const lat = coords?.latitude ?? 43.0618;
  const lng = coords?.longitude ?? 141.3545;
  const { data: resolvedLocation } = useResolvedLocation(lat, lng);

  const { data: dish, isLoading, isError } = useDish(dishId);

  // State & Carousel Auto-scroll
  const carouselRef = useRef<ScrollView>(null);
  const [activeImageIndex, setActiveImageIndex] = useState(0);
  const activeIndexRef = useRef(0);
  activeIndexRef.current = activeImageIndex;
  const isUserScrollingRef = useRef(false);

  const [isSaved, setIsSaved] = useState(false);
  const [isHistoryExpanded, setIsHistoryExpanded] = useState(false);

  const images = getDishImageSources(dish);

  // Auto-scroll hero image carousel every 3.5 seconds
  useEffect(() => {
    if (images.length <= 1) return;
    const slideWidth = SCREEN_WIDTH - spacing.lg * 2;
    const interval = setInterval(() => {
      if (isUserScrollingRef.current) return;
      const nextIndex = (activeIndexRef.current + 1) % images.length;
      carouselRef.current?.scrollTo({
        x: nextIndex * slideWidth,
        animated: true,
      });
      setActiveImageIndex(nextIndex);
    }, 3500);

    return () => clearInterval(interval);
  }, [images.length]);

  const handleBack = () => {
    if (navigation.canGoBack()) {
      navigation.goBack();
    } else {
      try {
        navigation.navigate('ExploreHome');
      } catch (e) {
        navigation.navigate('ExploreTab');
      }
    }
  };

  useEffect(() => {
    if (dishId) {
      isDishFavourite(dishId).then(setIsSaved);
    }
  }, [dishId]);

  const handleToggleBookmark = async () => {
    if (!dishId) return;
    const newState = await toggleFavouriteDishId(dishId);
    setIsSaved(newState);
  };

  const handlePlayAudio = async () => {
    if (!dish?.pronunciation_audio_url) return;
    try {
      const { sound } = await Audio.Sound.createAsync({ uri: dish.pronunciation_audio_url });
      await sound.playAsync();
    } catch (err) {
      console.log('Audio playback error:', err);
    }
  };

  const handleOpenGoogleMaps = () => {
    if (!dish) return;
    if (dish.google_maps_query && dish.google_maps_query.trim() !== '') {
      const target = dish.google_maps_query.trim();
      if (target.startsWith('http://') || target.startsWith('https://')) {
        Linking.openURL(target);
      } else {
        const mapsUrl = `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(target)}`;
        Linking.openURL(mapsUrl);
      }
    } else {
      const locationName = resolvedLocation?.location_name || 'Japan';
      const searchQuery = `${dish.dish_name} restaurant near ${locationName}, Japan`;
      const mapsUrl = `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(searchQuery)}`;
      Linking.openURL(mapsUrl);
    }
  };

  if (isLoading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={colors.primary} />
        <Text style={styles.loadingText}>Loading dish details...</Text>
      </View>
    );
  }

  if (isError || !dish) {
    return (
      <View style={styles.loadingContainer}>
        <Text style={styles.errorText}>Dish details unavailable ({dishId})</Text>
        <TouchableOpacity style={styles.retryButton} onPress={handleBack}>
          <Text style={styles.retryButtonText}>Go Back</Text>
        </TouchableOpacity>
      </View>
    );
  }

  // Filter chips strictly from TRUE sheet data values
  const rawTrueChips: string[] = [];
  if (dish.home_filter_tags) {
    rawTrueChips.push(...parseTagList(dish.home_filter_tags));
  }
  if (dish.vegetarian_status === 'Verified vegetarian') {
    rawTrueChips.push('Vegetarian');
  }
  if (dish.halal_status === 'Verified halal') {
    rawTrueChips.push('Halal');
  }
  if (dish.featured) {
    rawTrueChips.push('Featured');
  }
  const activeChips = Array.from(
    new Set(rawTrueChips.filter(t => t && t.trim() !== '' && t.toLowerCase() !== 'local classic'))
  );

  const formattedPrice =
    dish.price_min && dish.price_max
      ? `¥${dish.price_min.toLocaleString()}–¥${dish.price_max.toLocaleString()}`
      : dish.price_min
      ? `¥${dish.price_min.toLocaleString()}+`
      : '¥1,000–¥2,500';

  const defaultWhereToLook = [
    {
      title: 'Red Lanterns (赤ちょうちん)',
      description: 'Hanging outside traditional streetside pubs indicate fresh teppan griddles.',
    },
    {
      title: 'Steaming Counter Seating',
      description: 'Look for open counter-style iron grills where chefs cook right in front of you.',
    },
    {
      title: 'Hiroshima & Osaka Districts',
      description: 'Head straight to Dotonbori (Osaka) or Okonomimura (Hiroshima) for legendary varieties.',
    },
  ];

  const parsedVisualCues = parseStructuredSections(dish.visual_cues);
  const whereToLookData = parsedVisualCues.length > 0 ? parsedVisualCues : defaultWhereToLook;

  // Process key ingredients into structured items { title, description }
  const defaultKeyIngredients = [
    {
      title: 'Soft Steamed Dough Base',
      description: 'A tender, elegant exterior crafted from a traditional blend of grated yam and jōyoko (rice flour), yielding a soft, steamed texture rather than a hard snap.',
    },
    {
      title: 'Smooth Red Bean Center',
      description: 'Generously filled with homemade koshian (smooth, pureed sweet red bean paste) to provide a deep, earthy sweetness at its core.',
    },
    {
      title: 'Hand-Crafted Finish',
      description: 'Carefully shaped by hand, gently steamed, and meticulously finished with a delicate touch of green nerikiri to complete the radish illusion.',
    },
  ];

  const parsedIngredients = parseStructuredSections(dish.key_ingredients);
  const ingredientItems = parsedIngredients.length > 0 ? parsedIngredients : defaultKeyIngredients;

  return (
    <View style={styles.mainWrapper}>
      <ScrollView style={styles.container} contentContainerStyle={styles.scrollContent}>
        {/* 1. Header Top Bar (Floating Back & Circular Bookmark) */}
        <View style={styles.topBar}>
          <TouchableOpacity
            style={styles.backButtonInline}
            onPress={handleBack}
            activeOpacity={0.7}
            hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
          >
            <ArrowLeft size={16} color={colors.ink} weight="bold" style={{ marginRight: 6 }} />
            <Text style={styles.backButtonText}>Back</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.circularBookmarkButton} onPress={handleToggleBookmark} activeOpacity={0.8}>
            <Bookmark
              size={18}
              color={isSaved ? colors.primary : 'rgba(28, 25, 23, 0.55)'}
              weight={isSaved ? 'fill' : 'regular'}
            />
          </TouchableOpacity>
        </View>

        {/* 2. Rounded Hero Image Card with Carousel Indicator */}
        <View style={styles.heroImageCard}>
          <ScrollView
            ref={carouselRef}
            horizontal
            pagingEnabled
            showsHorizontalScrollIndicator={false}
            onScrollBeginDrag={() => {
              isUserScrollingRef.current = true;
            }}
            onScrollEndDrag={() => {
              isUserScrollingRef.current = false;
            }}
            onMomentumScrollEnd={(e) => {
              isUserScrollingRef.current = false;
              const slide = Math.round(e.nativeEvent.contentOffset.x / (SCREEN_WIDTH - spacing.lg * 2));
              setActiveImageIndex(slide);
            }}
            onScroll={(e) => {
              const slide = Math.round(e.nativeEvent.contentOffset.x / (SCREEN_WIDTH - spacing.lg * 2));
              setActiveImageIndex(slide);
            }}
            scrollEventThrottle={16}
            style={styles.heroScrollView}
            contentContainerStyle={styles.heroScrollContent}
          >
            {images.map((imgUrl, idx) => (
              <View key={idx} style={styles.heroImageWrapper}>
                <Image
                  source={typeof imgUrl === 'string' ? { uri: imgUrl } : imgUrl}
                  style={styles.heroImage}
                  resizeMode="cover"
                />
              </View>
            ))}
          </ScrollView>

          {images.length > 1 && (
            <View style={styles.paginationDots}>
              {images.map((_, idx) => (
                <View
                  key={idx}
                  style={[styles.dot, activeImageIndex === idx && styles.activeDot]}
                />
              ))}
            </View>
          )}
        </View>

        <View style={styles.contentBody}>
          {/* 3. Title Row: Japanese Header & Rating Star */}
          <View style={styles.titleRatingRow}>
            <Text style={styles.japaneseHeader}>{dish.japanese_name}</Text>
            <View style={styles.ratingBadge}>
              <Star size={18} color={colors.gold} weight="fill" style={{ marginRight: 4 }} />
              <Text style={styles.ratingScore}>4.9</Text>
              <Text style={styles.ratingCount}> (2.4k)</Text>
            </View>
          </View>

          {/* 4. English Subtitle Title */}
          <Text style={styles.englishSubtitle}>{dish.dish_name}</Text>

          {/* 5. Pronunciation Row with speaker icon */}
          <View style={styles.pronunciationRow}>
            <Text style={styles.pronunciationLabel}>Pronounced: </Text>
            <TouchableOpacity
              style={styles.pronunciationTouchable}
              onPress={handlePlayAudio}
              disabled={!dish.pronunciation_audio_url}
              activeOpacity={dish.pronunciation_audio_url ? 0.7 : 1}
            >
              <Text style={styles.phoneticUnderline}>
                {dish.pronunciation_phonetic || 'Oh-koh-noh-mee-yah-kee'}
              </Text>
              <SpeakerHigh size={16} color={colors.ink} weight="regular" style={{ marginLeft: 4 }} />
            </TouchableOpacity>
          </View>

          {/* Tag Chips (Only TRUE sheet filter tags) */}
          {activeChips.length > 0 && (
            <View style={styles.tagChipsRow}>
              {activeChips.map((tag, idx) => (
                <View key={idx} style={styles.tagChip}>
                  <View style={styles.chipDot} />
                  <Text style={styles.tagChipText}>{tag}</Text>
                </View>
              ))}
            </View>
          )}

          {/* Summary Paragraph */}
          <ImpactText text={dish.summary} style={styles.summaryText} />

          {/* §5.3 Trust Cards (Dietary + Price) Reusable Exception Component */}
          <TrustCards dish={dish} formattedPrice={formattedPrice} />

          {/* "How to Find It" Section matching user reference image */}
          <View style={styles.whereToLookSection}>
            <View style={styles.sectionDivider} />
            <Text style={styles.whereToLookTitle}>How to Find It</Text>
            <View style={styles.whereToLookList}>
              {whereToLookData.map((item, idx) => (
                <View key={idx} style={styles.whereToLookRow}>
                  <View style={styles.checkBadgeCircle}>
                    <Check size={14} color="rgba(28, 25, 23, 0.50)" weight="bold" />
                  </View>
                  <View style={styles.whereToLookContent}>
                    <Text style={styles.whereToLookItemTitle}>{item.title}</Text>
                    {item.description ? (
                      <ImpactText text={item.description} style={styles.whereToLookItemDesc} />
                    ) : null}
                  </View>
                </View>
              ))}
            </View>
            <View style={styles.sectionDivider} />
          </View>

          {/* "Origin & Cultural History" Block */}
          {(dish.origin_history_preview || dish.origin_history_full) && (
            <View style={styles.historyBlock}>
              <Text style={styles.sectionHeadingH2}>Origin & Cultural History</Text>
              <ImpactText
                text={
                  isHistoryExpanded
                    ? dish.origin_history_full || dish.origin_history_preview || dish.summary
                    : dish.origin_history_preview || dish.summary
                }
                style={styles.historyText}
              />

              {dish.origin_history_full && (
                <TouchableOpacity onPress={() => setIsHistoryExpanded(!isHistoryExpanded)}>
                  <Text style={styles.readMoreText}>
                    {isHistoryExpanded ? 'Show Less' : 'Read full historical record...'}
                  </Text>
                </TouchableOpacity>
              )}
            </View>
          )}

          {/* "Did You Know?" Callout Card matching user screenshot spec */}
          {dish.did_you_know && (
            <View style={styles.peachCalloutCard}>
              <View style={styles.calloutIconCircle}>
                <Lightbulb size={22} color={colors.highlightIconInk} weight="bold" />
              </View>
              <View style={styles.calloutTextContainer}>
                <Text style={styles.calloutTitle}>Did You Know?</Text>
                <ImpactText text={dish.did_you_know} style={styles.calloutBody} />
              </View>
            </View>
          )}

          {/* Key Ingredients & Traditional Method Section matching reference image */}
          {ingredientItems && ingredientItems.length > 0 && (
            <View style={styles.ingredientsSection}>
              <View style={styles.sectionDivider} />
              <Text style={styles.ingredientsTitle}>Key Ingredients & Traditional Method</Text>
              <View style={styles.ingredientsList}>
                {ingredientItems.map((item, idx) => {
                  const numStr = (idx + 1).toString().padStart(2, '0');
                  return (
                    <View key={idx} style={styles.numberedIngredientCard}>
                      <Text style={styles.ingredientNumber}>{numStr}</Text>
                      <View style={styles.ingredientContent}>
                        <Text style={styles.ingredientItemTitle}>{item.title}</Text>
                        {item.description ? (
                          <ImpactText text={item.description} style={styles.ingredientItemDesc} />
                        ) : null}
                      </View>
                    </View>
                  );
                })}
              </View>
              <View style={styles.sectionDivider} />
            </View>
          )}


          {/* "Find it Nearby / Find the Shop" Card */}
          <View style={styles.findNearbySection}>
            <View style={styles.findNearbyCard}>
              {/* Top Row: Icon + Text */}
              <View style={styles.findNearbyTopRow}>
                <View style={styles.findNearbyIconBox}>
                  <MapTrifold size={26} color={colors.info} weight="bold" />
                </View>
                <View style={styles.findNearbyTextContent}>
                  <Text style={styles.findNearbyTitle}>
                    {dish.dish_id === 'nerima-daikon-manju' ? 'Find the Shop' : 'Find it Nearby'}
                  </Text>
                  <Text style={styles.findNearbySubtitle}>
                    {dish.dish_id === 'nerima-daikon-manju'
                      ? 'Get directions to Okashitsukasa Kimura-ya in Fujimidai to purchase fresh Nerima Daikon Manju.'
                      : `View traditional restaurants serving ${dish.dish_name} near you`}
                  </Text>
                </View>
              </View>

              {/* CTA Button: Find It -> */}
              <TouchableOpacity
                style={styles.findNearbyCtaButton}
                onPress={handleOpenGoogleMaps}
                activeOpacity={0.88}
              >
                <Text style={styles.findNearbyCtaText}>
                  {dish.dish_id === 'nerima-daikon-manju' ? 'Find It' : 'Find out more'}
                </Text>
                <ArrowRight size={18} color="#FFFFFF" weight="bold" style={{ marginLeft: 8 }} />
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  mainWrapper: {
    flex: 1,
    backgroundColor: colors.paper,
  },
  container: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: spacing.xl,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: colors.paper,
    padding: spacing.xl,
  },
  loadingText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    marginTop: spacing.md,
  },
  errorText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.body,
    color: colors.textMuted,
    marginBottom: spacing.lg,
  },
  retryButton: {
    backgroundColor: colors.primary,
    paddingHorizontal: spacing.xl,
    paddingVertical: spacing.md,
    borderRadius: borderRadius.md,
  },
  retryButtonText: {
    color: '#FFFFFF',
    fontFamily: typography.fontFamily.bodySemiBold,
  },
  headerOverlay: {
    position: 'absolute',
    top: spacing.xxl + 10,
    left: spacing.lg,
    right: spacing.lg,
    zIndex: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  topBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.xxl + 10,
    paddingBottom: spacing.md,
    zIndex: 100,
  },
  backButtonInline: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 6,
    paddingRight: 12,
    zIndex: 101,
  },
  backButtonText: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  circularBookmarkButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: '#FFFFFF',
    justifyContent: 'center',
    alignItems: 'center',
    ...shadows.hairline,
  },
  heroImageCard: {
    marginHorizontal: spacing.lg,
    height: 280,
    borderRadius: borderRadius.xl + 4, // Large rounded corners like screenshot
    overflow: 'hidden',
    marginBottom: spacing.xl + 4, // 28px room to breathe
    backgroundColor: '#EAE6DF',
    position: 'relative',
  },
  heroScrollView: {
    width: '100%',
    height: 280,
  },
  heroScrollContent: {
    height: 280,
  },
  heroImageWrapper: {
    width: SCREEN_WIDTH - spacing.lg * 2,
    height: 280,
    overflow: 'hidden',
  },
  heroImage: {
    width: '100%',
    height: '100%',
  },
  paginationDots: {
    position: 'absolute',
    bottom: spacing.md,
    left: 0,
    right: 0,
    flexDirection: 'row',
    justifyContent: 'center',
    gap: spacing.xs,
  },
  dot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'rgba(255, 255, 255, 0.5)',
  },
  activeDot: {
    backgroundColor: '#FFFFFF',
    width: 16,
  },
  contentBody: {
    paddingHorizontal: spacing.lg,
  },
  titleRatingRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm + 2, // 10px spacing
  },
  japaneseHeader: {
    fontSize: 31,
    fontFamily: typography.fontFamily.japanese, // NotoSansJP_900Black
    fontWeight: '900',
    color: colors.ink,
    flex: 1,
    marginRight: spacing.sm,
  },
  ratingBadge: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  ratingScore: {
    fontSize: 16,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
  },
  ratingCount: {
    fontSize: 13,
    fontFamily: typography.fontFamily.body,
    color: 'rgba(28, 25, 23, 0.5)',
  },
  englishSubtitle: {
    fontSize: 20,
    fontFamily: typography.fontFamily.dishSubtitle, // Figtree 600 SemiBold
    fontWeight: '600',
    color: colors.primary, // #EC4900
    marginBottom: spacing.sm + 2, // 10px spacing
  },
  pronunciationRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.lg + 2, // 18px room to breathe
  },
  pronunciationLabel: {
    fontSize: 14,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
    marginRight: 4,
  },
  pronunciationTouchable: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  phoneticUnderline: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    textDecorationLine: 'underline',
  },
  tagChipsRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.xs + 2,
    marginBottom: spacing.xl, // 24px room to breathe
  },
  tagChip: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.full,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.xs + 1,
    borderWidth: 1,
    borderColor: colors.hairline,
  },
  chipDot: {
    width: 5,
    height: 5,
    borderRadius: 2.5,
    backgroundColor: colors.primary,
    marginRight: spacing.xs,
  },
  tagChipText: {
    fontSize: typography.fontSize.uiLabel,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.ink,
  },
  summaryText: {
    fontSize: 16,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 26,
    marginBottom: spacing.xl + 8, // 32px room to breathe
  },
  sectionCard: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md + 2,
    padding: spacing.xl, // 24px padding inside cards
    marginBottom: spacing.xl + 8, // 32px room to breathe
    ...shadows.hairline,
  },
  sectionHeadingH2: {
    fontSize: typography.fontSize.h2, // 22px
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink,
    marginBottom: spacing.md + 2, // 14px heading margin
  },
  sectionBodyText: {
    fontSize: 16,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 26,
  },
  bulletRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: spacing.sm,
  },
  bulletPoint: {
    fontSize: 16,
    color: 'rgba(28, 25, 23, 0.50)',
    marginRight: spacing.xs,
    lineHeight: 26,
  },
  bulletText: {
    flex: 1,
    fontSize: 16,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 26,
  },
  historyBlock: {
    marginBottom: spacing.xl + 8, // 32px room to breathe
  },
  historyText: {
    fontSize: 16,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 26,
    marginBottom: spacing.sm,
  },
  readMoreText: {
    fontSize: typography.fontSize.sm,
    fontFamily: typography.fontFamily.bodyMedium,
    color: colors.primary,
    textDecorationLine: 'underline',
  },
  peachCalloutCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.highlightTint, // #FFF3D2
    borderRadius: borderRadius.md, // 12px rounded rectangle
    paddingHorizontal: 24,
    paddingVertical: 20,
    marginBottom: spacing.xl + 8, // 32px room to breathe
  },
  calloutIconCircle: {
    width: 44,
    height: 44,
    borderRadius: borderRadius.badge, // 6px square-ish
    backgroundColor: colors.highlight, // #FFBF00
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 18,
  },
  calloutTextContainer: {
    flex: 1,
  },
  calloutTitle: {
    fontSize: 18, // 18px Playfair Display Bold title
    fontFamily: typography.fontFamily.h3, // Playfair Display 700 Bold
    color: colors.ink,
    marginBottom: 6,
  },
  calloutBody: {
    fontSize: 14, // 14px body text
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 22,
  },
  calloutBodyBold: {
    fontSize: 14,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: '#1C1917',
  },
  ingredientsSection: {
    marginVertical: spacing.lg,
  },
  ingredientsTitle: {
    fontSize: 24,
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink,
    marginTop: spacing.lg,
    marginBottom: spacing.lg,
  },
  ingredientsList: {
    gap: 12,
    marginBottom: spacing.lg,
  },
  numberedIngredientCard: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    backgroundColor: '#FFFFFF', // White card
    borderRadius: borderRadius.md, // 12px smooth rounded corners
    paddingVertical: 18,
    paddingHorizontal: 20,
    borderWidth: 1,
    borderColor: colors.hairline, // 1px Hairline border
  },
  ingredientNumber: {
    fontSize: 22,
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink, // Neutral ink (#1C1917) per §5.5
    width: 32,
    marginRight: 14,
    marginTop: 1,
  },
  ingredientContent: {
    flex: 1,
  },
  ingredientItemTitle: {
    fontSize: 16,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
    marginBottom: 4,
  },
  ingredientItemDesc: {
    fontSize: 14,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 20,
  },
  nearbyTeaserCard: {
    flexDirection: 'row',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    alignItems: 'center',
    marginBottom: spacing.lg,
    ...shadows.hairline,
  },
  nearbyIconBox: {
    width: 44,
    height: 44,
    backgroundColor: colors.infoTint,
    borderRadius: borderRadius.sm,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  nearbyTeaserContent: {
    flex: 1,
  },
  nearbyTeaserTitle: {
    fontSize: typography.fontSize.md,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    marginBottom: 2,
  },
  nearbyTeaserBody: {
    fontSize: typography.fontSize.caption,
    fontFamily: typography.fontFamily.body,
    color: colors.body,
  },
  whereToLookSection: {
    marginTop: spacing.sm,
    marginBottom: spacing.lg,
  },
  sectionDivider: {
    height: 1,
    backgroundColor: colors.hairline,
  },
  whereToLookTitle: {
    fontSize: 24,
    fontFamily: typography.fontFamily.h2, // Playfair Display 700 Bold
    color: colors.ink,
    marginTop: spacing.lg,
    marginBottom: spacing.lg,
  },
  whereToLookList: {
    gap: spacing.lg,
    marginBottom: spacing.xl,
  },
  whereToLookRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  checkBadgeCircle: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: 'rgba(28, 25, 23, 0.07)', // neutral restrained circle badge
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
    marginTop: 2,
  },
  whereToLookContent: {
    flex: 1,
  },
  whereToLookItemTitle: {
    fontSize: 16,
    fontFamily: typography.fontFamily.bodySemiBold,
    color: colors.ink,
    marginBottom: 4,
  },
  whereToLookItemDesc: {
    fontSize: 15,
    fontFamily: typography.fontFamily.body,
    color: '#44403C',
    lineHeight: 22,
  },
  findNearbySection: {
    marginTop: 0,
    marginBottom: spacing.lg,
  },
  findNearbyCard: {
    backgroundColor: '#FFFFFF', // White card background
    borderRadius: borderRadius.md, // 12px rounded rectangle
    padding: 24, // 24px padding inside
    marginTop: spacing.lg,
    borderWidth: 1,
    borderColor: colors.hairline, // 1px Hairline border
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.04,
    shadowRadius: 12,
    elevation: 2,
  },
  findNearbyTopRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  findNearbyIconBox: {
    width: 52,
    height: 52,
    borderRadius: borderRadius.sm,
    backgroundColor: colors.infoTint, // Info blue tint
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  findNearbyTextContent: {
    flex: 1,
  },
  findNearbyTitle: {
    fontSize: 18,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
    color: colors.ink,
    marginBottom: 4,
  },
  findNearbySubtitle: {
    fontSize: 14,
    fontFamily: typography.fontFamily.body,
    color: '#6B7280',
    lineHeight: 20,
  },
  findNearbyCtaButton: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: colors.primary, // Solid primary fill (#EC4900)
    borderRadius: borderRadius.md, // Rounded rectangle (12px), not pill per §3 & §5.1
    paddingVertical: 14,
    shadowColor: colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 3,
  },
  findNearbyCtaText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontFamily: typography.fontFamily.bodySemiBold,
    fontWeight: '700',
  },
});

export default DishDetailScreen;

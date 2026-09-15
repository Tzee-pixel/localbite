import { ImageSourcePropType } from 'react-native';
import { Dish } from '../types';

// Bundled high-resolution local assets
export const LOCAL_DISH_ASSETS: Record<string, ImageSourcePropType[]> = {
  'nerima-daikon-manju': [
    require('../../assets/dish-details/nerima-daikon-manju-1.jpg'),
    require('../../assets/dish-details/nerima-daikon-manju-2.jpg'),
    require('../../assets/dish-details/nerima-daikon-manju-3.jpg'),
  ],
  'nerima-daikon-takuan': [
    require('../../assets/dish-details/nerima-daikon-takuan-1.webp'),
    require('../../assets/dish-details/nerima-daikon-takuan-2.jpg'),
    require('../../assets/dish-details/nerima-daikon-takuan-3.jpg'),
  ],
  'nerima-daifuku': [
    require('../../assets/dish-details/nerima-daifuku-1.jpg'),
    require('../../assets/dish-details/nerima-daifuku-2.jpg'),
    require('../../assets/dish-details/nerima-daifuku-3.jpg'),
  ],
  'nerima-sable': [
    require('../../assets/dish-details/nerima-sable-1.jpg'),
    require('../../assets/dish-details/nerima-sable-2.jpg'),
    require('../../assets/dish-details/nerima-sable-3.jpg'),
  ],
  'nerima-sabl': [
    require('../../assets/dish-details/nerima-sable-1.jpg'),
    require('../../assets/dish-details/nerima-sable-2.jpg'),
    require('../../assets/dish-details/nerima-sable-3.jpg'),
  ],
  'aochu': [
    require('../../assets/dish-details/aochu_1.webp'),
    require('../../assets/dish-details/aochu_2.webp'),
    require('../../assets/dish-details/aochu_3.webp'),
  ],
  'hingya-no-shio': [
    require('../../assets/dish-details/hingya-1.jpg'),
    require('../../assets/dish-details/hingya-2.jpg'),
    require('../../assets/dish-details/hingya-3.jpg'),
  ],
  'inagi-pears': [
    require('../../assets/dish-details/inagi-pears-1.jpg'),
    require('../../assets/dish-details/inagi-pears-2.jpg'),
    require('../../assets/dish-details/inagi-pears-3.jpg'),
  ],
  'inagi-nashi': [
    require('../../assets/dish-details/inagi-pears-1.jpg'),
    require('../../assets/dish-details/inagi-pears-2.jpg'),
    require('../../assets/dish-details/inagi-pears-3.jpg'),
  ],
  'shima-lemon-jelly': [
    require('../../assets/dish-details/shima-lemon-jelly-1.webp'),
    require('../../assets/dish-details/shima-lemon-jelly-2.jpg'),
    require('../../assets/dish-details/shima-lemon-jelly-3.jpg'),
  ],
  'takinogawa-gobo': [
    require('../../assets/dish-details/takinogawa-gobo-1.jpg'),
    require('../../assets/dish-details/takinogawa-gobo-2.jpg'),
    require('../../assets/dish-details/takinogawa-gobo-3.jpg'),
  ],
  'kiyose-man': [
    require('../../assets/dish-details/kiyose-man-1.png'),
    require('../../assets/dish-details/kiyose-man-2.jpeg'),
    require('../../assets/dish-details/kiyose-man-3.jpg'),
  ],
  'hino-pears': [
    require('../../assets/dish-details/hino-pears-1.webp'),
    require('../../assets/dish-details/hino-pears-2.webp'),
    require('../../assets/dish-details/hino-pears-3.webp'),
  ],
  'hino-nashi': [
    require('../../assets/dish-details/hino-pears-1.webp'),
    require('../../assets/dish-details/hino-pears-2.webp'),
    require('../../assets/dish-details/hino-pears-3.webp'),
  ],
  'hinohara-potatoes': [
    require('../../assets/dish-details/hinohara-potatoes-1.jpg'),
    require('../../assets/dish-details/hinohara-potatoes-2.jpg'),
    require('../../assets/dish-details/hinohara-potatoes-3.jpg'),
  ],
  'akame-satoimo': [
    require('../../assets/dish-details/akame-satoimo-1.jpg'),
    require('../../assets/dish-details/akame-satoimo-2.webp'),
    require('../../assets/dish-details/akame-satoimo-3.jpg'),
  ],
  'akame-satimo': [
    require('../../assets/dish-details/akame-satoimo-1.jpg'),
    require('../../assets/dish-details/akame-satoimo-2.webp'),
    require('../../assets/dish-details/akame-satoimo-3.jpg'),
  ],
  'meguro-no-sanma': [
    require('../../assets/dish-details/meguro-no-sanma-1.jpg'),
    require('../../assets/dish-details/meguro-no-sanma-2.jpg'),
    require('../../assets/dish-details/meguro-no-sanma-3.jpg'),
  ],
  'meguro-sanma': [
    require('../../assets/dish-details/meguro-no-sanma-1.jpg'),
    require('../../assets/dish-details/meguro-no-sanma-2.jpg'),
    require('../../assets/dish-details/meguro-no-sanma-3.jpg'),
  ],
  '8-tier-soft-serve-daily-chico': [
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-1.jpg'),
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-2.jpg'),
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-3.webp'),
  ],
  'daily-chico': [
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-1.jpg'),
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-2.jpg'),
    require('../../assets/dish-details/8-Tier-Soft-Serve-Daily-Chico-3.webp'),
  ],
  'oyaki-refu-tei': [
    require('../../assets/dish-details/oyaki-refu-tei-1.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-2.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-3.jpg'),
  ],
  'oyaki-refutei': [
    require('../../assets/dish-details/oyaki-refu-tei-1.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-2.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-3.jpg'),
  ],
  'refu-tei': [
    require('../../assets/dish-details/oyaki-refu-tei-1.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-2.jpg'),
    require('../../assets/dish-details/oyaki-refu-tei-3.jpg'),
  ],
  'ogikubo-ramen': [
    require('../../assets/dish-details/ogikubo-ramen-1.jpg'),
    require('../../assets/dish-details/ogikubo-ramen-2.jpg'),
    require('../../assets/dish-details/ogikubo-ramen-3.jpeg'),
  ],
  'okara-soy-milk-karinto': [
    require('../../assets/dish-details/okara-and-soy-milk-karinto-1.jpg'),
    require('../../assets/dish-details/okara-and-soy-milk-karinto-2.jpg'),
    require('../../assets/dish-details/okara-and-soy-milk-karinto-3.jpeg'),
  ],
  'okara-and-soy-milk-karinto': [
    require('../../assets/dish-details/okara-and-soy-milk-karinto-1.jpg'),
    require('../../assets/dish-details/okara-and-soy-milk-karinto-2.jpg'),
    require('../../assets/dish-details/okara-and-soy-milk-karinto-3.jpeg'),
  ],
  'omoide-yokocho-yakitori': [
    require('../../assets/dish-details/omoide-yokocho-yakitori-1.webp'),
    require('../../assets/dish-details/omoide-yokocho-yakitori-2.png'),
    require('../../assets/dish-details/omoide-yokocho-yakitori-3.jpeg'),
  ],
  'omoide-yokocho': [
    require('../../assets/dish-details/omoide-yokocho-yakitori-1.webp'),
    require('../../assets/dish-details/omoide-yokocho-yakitori-2.png'),
    require('../../assets/dish-details/omoide-yokocho-yakitori-3.jpeg'),
  ],
  'shima-zushi': [
    require('../../assets/dish-details/shima-zushi-1.jpg'),
    require('../../assets/dish-details/shima-zushi-2.jpg'),
    require('../../assets/dish-details/shima-zushi-3.jpg'),
  ],
  'shimazushi': [
    require('../../assets/dish-details/shima-zushi-1.jpg'),
    require('../../assets/dish-details/shima-zushi-2.jpg'),
    require('../../assets/dish-details/shima-zushi-3.jpg'),
  ],
  'kame-ni': [
    require('../../assets/dish-details/kame-ni-1.webp'),
    require('../../assets/dish-details/kame-ni-2.webp'),
    require('../../assets/dish-details/kame-ni-3.jpg'),
  ],
  'kameni': [
    require('../../assets/dish-details/kame-ni-1.webp'),
    require('../../assets/dish-details/kame-ni-2.webp'),
    require('../../assets/dish-details/kame-ni-3.jpg'),
  ],
  'same-burger': [
    require('../../assets/dish-details/same-burger-1.jpg'),
    require('../../assets/dish-details/same-burger-2.jpg'),
    require('../../assets/dish-details/same-burger-3.jpg'),
  ],
  'shark-burger': [
    require('../../assets/dish-details/same-burger-1.jpg'),
    require('../../assets/dish-details/same-burger-2.jpg'),
    require('../../assets/dish-details/same-burger-3.jpg'),
  ],
  'shikaku-mame-tempura': [
    require('../../assets/dish-details/Shikaku-mame-Tempura-1.jpg'),
    require('../../assets/dish-details/Shikaku-mame-Tempura-2.webp'),
    require('../../assets/dish-details/Shikaku-mame-Tempura-3.jpeg'),
  ],
  'shikakumame-tempura': [
    require('../../assets/dish-details/Shikaku-mame-Tempura-1.jpg'),
    require('../../assets/dish-details/Shikaku-mame-Tempura-2.webp'),
    require('../../assets/dish-details/Shikaku-mame-Tempura-3.jpeg'),
  ],
  'akaba-miso-soup': [
    require('../../assets/dish-details/Akaba-Miso-Soup-1.jpg'),
    require('../../assets/dish-details/Akaba-Miso-Soup-2.webp'),
    require('../../assets/dish-details/Akaba-Miso-Soup-3.webp'),
  ],
  'akaba-soup': [
    require('../../assets/dish-details/Akaba-Miso-Soup-1.jpg'),
    require('../../assets/dish-details/Akaba-Miso-Soup-2.webp'),
    require('../../assets/dish-details/Akaba-Miso-Soup-3.webp'),
  ],
};

// Curated authentic Japanese cuisine photography categorized by style/type
export const THEMATIC_FALLBACK_IMAGES: Record<string, string[]> = {
  wagashi: [
    'https://images.unsplash.com/photo-1582293041079-7814c2f12063?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1542310503-4f0578864708?auto=format&fit=crop&w=800&q=80',
  ],
  ramen: [
    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=800&q=80',
  ],
  sushi: [
    'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80',
  ],
  seafood: [
    'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80',
  ],
  noodles: [
    'https://images.unsplash.com/photo-1618841557871-b4664fbf0cb3?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=800&q=80',
  ],
  grill: [
    'https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80',
  ],
  default: [
    'https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80',
  ],
};

function isValidHttpUrl(url: any): boolean {
  if (typeof url !== 'string') return false;
  const trimmed = url.trim();
  if (!trimmed || trimmed === '-' || trimmed.toLowerCase() === 'image' || trimmed.toLowerCase() === 'link') {
    return false;
  }
  return trimmed.startsWith('http://') || trimmed.startsWith('https://');
}

/**
 * Returns an array of React Native ImageSource objects (either require objects or { uri })
 * guarantees always returning valid, beautiful images.
 */
export function getDishImageSources(dish?: Partial<Dish> | null): ImageSourcePropType[] {
  if (!dish) {
    return THEMATIC_FALLBACK_IMAGES.default.map((uri) => ({ uri }));
  }

  // 1. Check local high-res asset bundle first
  if (dish.dish_id && LOCAL_DISH_ASSETS[dish.dish_id]) {
    return LOCAL_DISH_ASSETS[dish.dish_id];
  }

  // 2. Check if dish has valid HTTP image_urls
  if (dish.image_urls && Array.isArray(dish.image_urls)) {
    const validHttpUrls = dish.image_urls.filter(isValidHttpUrl);
    if (validHttpUrls.length > 0) {
      return validHttpUrls.map((uri) => ({ uri }));
    }
  }

  // 3. Fallback based on dish keywords / tags / name
  const combinedText = `${dish.dish_name || ''} ${dish.japanese_name || ''} ${dish.summary || ''} ${(dish.tags || []).join(' ')} ${(dish.home_filter_tags || []).join(' ')}`.toLowerCase();

  if (
    combinedText.includes('manju') ||
    combinedText.includes('sweet') ||
    combinedText.includes('mochi') ||
    combinedText.includes('daifuku') ||
    combinedText.includes('wagashi') ||
    combinedText.includes('dessert') ||
    combinedText.includes('pastry') ||
    combinedText.includes('cookie') ||
    combinedText.includes('sable') ||
    combinedText.includes('cake')
  ) {
    return THEMATIC_FALLBACK_IMAGES.wagashi.map((uri) => ({ uri }));
  }

  if (combinedText.includes('ramen') || combinedText.includes('broth')) {
    return THEMATIC_FALLBACK_IMAGES.ramen.map((uri) => ({ uri }));
  }

  if (combinedText.includes('sushi') || combinedText.includes('sashimi')) {
    return THEMATIC_FALLBACK_IMAGES.sushi.map((uri) => ({ uri }));
  }

  if (combinedText.includes('soba') || combinedText.includes('udon') || combinedText.includes('noodle')) {
    return THEMATIC_FALLBACK_IMAGES.noodles.map((uri) => ({ uri }));
  }

  if (
    combinedText.includes('fish') ||
    combinedText.includes('seafood') ||
    combinedText.includes('shirasu') ||
    combinedText.includes('squid') ||
    combinedText.includes('octopus') ||
    combinedText.includes('uni')
  ) {
    return THEMATIC_FALLBACK_IMAGES.seafood.map((uri) => ({ uri }));
  }

  if (
    combinedText.includes('yakitori') ||
    combinedText.includes('grilled') ||
    combinedText.includes('griddle') ||
    combinedText.includes('okonomiyaki') ||
    combinedText.includes('skewer')
  ) {
    return THEMATIC_FALLBACK_IMAGES.grill.map((uri) => ({ uri }));
  }

  return THEMATIC_FALLBACK_IMAGES.default.map((uri) => ({ uri }));
}

/**
 * Returns the primary (first) image source for cards, thumbnails, lists.
 */
export function getDishPrimaryImageSource(dish?: Partial<Dish> | null): ImageSourcePropType {
  const sources = getDishImageSources(dish);
  return sources[0] || { uri: THEMATIC_FALLBACK_IMAGES.default[0] };
}

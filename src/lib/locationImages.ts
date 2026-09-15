import { ImageSourcePropType } from 'react-native';
import { Location } from '../types';

export const LOCAL_LOCATION_ASSETS: Record<string, ImageSourcePropType> = {
  'ogasawara-village': require('../../assets/locations/ogasawara-village.jpg'),
  'ogasawara': require('../../assets/locations/ogasawara-village.jpg'),
};

export const LOCATION_HERO_IMAGES: Record<string, string> = {
  // Ogasawara & Tokyo Islands (lush misty mountains/subtropical nature)
  'ogasawara-village': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=80',
  'aogashima-village': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
  'hachijo-town': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
  'oshima-town': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=80',
  'miyake-village': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',

  // Western Tokyo Nature & Mountains
  'hinohara-village': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'okutama-town': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'ome-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'hachioji-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'hino-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'inagi-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'kiyose-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',

  // Tokyo Central Wards & Districts
  'shinjuku-ward': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'shinjuku': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'shibuya-ward': 'https://images.unsplash.com/photo-1542051841857-5f90071e7989?auto=format&fit=crop&w=1200&q=80',
  'shibuya': 'https://images.unsplash.com/photo-1542051841857-5f90071e7989?auto=format&fit=crop&w=1200&q=80',
  'setagaya-ward': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'setagaya': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'meguro-ward': 'https://images.unsplash.com/photo-1528164344705-475426879c0d?auto=format&fit=crop&w=1200&q=80',
  'meguro': 'https://images.unsplash.com/photo-1528164344705-475426879c0d?auto=format&fit=crop&w=1200&q=80',
  'nakano-ward': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'nakano': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'suginami-ward': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'ogikubo': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'chiyoda-ward': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'chuo-ward': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'ginza': 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1200&q=80',
  'tsukiji': 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=1200&q=80',
  'taito-ward': 'https://images.unsplash.com/photo-1528164344705-475426879c0d?auto=format&fit=crop&w=1200&q=80',
  'asakusa': 'https://images.unsplash.com/photo-1528164344705-475426879c0d?auto=format&fit=crop&w=1200&q=80',
  'ueno': 'https://images.unsplash.com/photo-1528164344705-475426879c0d?auto=format&fit=crop&w=1200&q=80',
  'nerima-ward': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'itabashi-ward': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',
  'kita-ward': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1200&q=80',

  // Nagano & Highlands
  'karuizawa': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'matsumoto': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',
  'nagano-city': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=1200&q=80',

  // Default Scenic Japan Landscape
  'default': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=80',
};

export function getLocationHeroImageSource(location?: Partial<Location> | null): ImageSourcePropType {
  if (!location) return { uri: LOCATION_HERO_IMAGES.default };

  const id = (location.location_id || '').toLowerCase().trim();
  if (LOCAL_LOCATION_ASSETS[id]) {
    return LOCAL_LOCATION_ASSETS[id];
  }

  // Check name keywords for local assets
  const name = (location.location_name || '').toLowerCase();
  if (name.includes('ogasawara') || id.includes('ogasawara')) {
    return LOCAL_LOCATION_ASSETS['ogasawara-village'];
  }

  if (location.image_url && typeof location.image_url === 'string' && location.image_url.startsWith('http')) {
    return { uri: location.image_url };
  }

  if (LOCATION_HERO_IMAGES[id]) {
    return { uri: LOCATION_HERO_IMAGES[id] };
  }

  if (name.includes('island') || id.includes('island')) {
    return { uri: LOCATION_HERO_IMAGES['aogashima-village'] };
  }
  if (name.includes('okutama') || name.includes('hinohara') || name.includes('mountain')) {
    return { uri: LOCATION_HERO_IMAGES['hinohara-village'] };
  }
  if (name.includes('asakusa') || name.includes('temple') || name.includes('ueno')) {
    return { uri: LOCATION_HERO_IMAGES['asakusa'] };
  }
  if (name.includes('shibuya') || name.includes('shinjuku') || name.includes('ginza')) {
    return { uri: LOCATION_HERO_IMAGES['shinjuku'] };
  }

  return { uri: LOCATION_HERO_IMAGES.default };
}

// Backward compatibility helper
export function getLocationHeroImage(location?: Partial<Location> | null): string {
  if (!location) return LOCATION_HERO_IMAGES.default;
  const id = (location.location_id || '').toLowerCase().trim();
  return LOCATION_HERO_IMAGES[id] || LOCATION_HERO_IMAGES.default;
}


export type ContentStatus = 'Draft' | 'In Review' | 'Published';
export type LinkStatus = 'Planned' | 'Published';

export type LocationType = 'City' | 'Area' | 'Market' | 'Town' | 'Island town' | 'Food hall' | 'Coastal town' | string;

export type VegetarianStatus = 'Not reviewed' | 'Verified vegetarian' | 'Not vegetarian';
export type HalalStatus = 'Not reviewed' | 'Verified halal' | 'Not halal';

export type DishRelationship = 'origin' | 'best-known' | 'available' | 'seasonal';

export interface Region {
  region_id: string;
  region_name: string;
  display_order: number;
  food_discovery_lens: string | null;
}

export interface Prefecture {
  prefecture_id: string;
  region_id: string;
  prefecture_name: string;
  primary_launch_city: string | null;
  suggested_phase: string | null;
}

export interface Location {
  location_id: string;
  location_name: string;
  type: LocationType;
  parent_location_id: string | null;
  city: string | null;
  prefecture_id: string;
  region_id: string;
  coverage_phase: number | string | null;
  food_focus: string | null;
  admin_note: string | null;
  content_status: ContentStatus;
  image_url?: string | null;
}

export interface Dish {
  dish_id: string;
  dish_name: string;
  japanese_name: string;
  region_id: string | null;
  primary_prefecture_id: string | null;
  summary: string;
  seasons: string[];
  in_season?: boolean;
  season?: string;
  tags: string[];
  dietary_guidance: string | null;
  price_min: number | null;
  price_max: number | null;
  content_status: ContentStatus;
  home_filter_tags: string[];
  vegetarian_status: VegetarianStatus;
  halal_status: HalalStatus;
  featured: boolean;
  origin_history_preview: string | null;
  origin_history_full: string | null;
  did_you_know: string | null;
  key_ingredients: string[] | null;
  pronunciation_phonetic: string | null;
  pronunciation_audio_url: string | null;
  image_urls?: string[] | null;
  dish_subtitle?: string | null;
  visual_cues?: string[] | string | null;
  cooking_method?: string | null;
  toppings?: string | null;
  google_maps_query?: string | null;
}

export interface DishLocation {
  id: string | number;
  dish_id: string;
  location_id: string;
  relationship: DishRelationship;
  display_priority: number;
  editorial_note: string | null;
  link_status: LinkStatus;
}

-- ==========================================
-- LocalBite Database Migration
-- PRD §7.2 Data Model & Schema Definition
-- ==========================================

-- 1. REGIONS TABLE
CREATE TABLE IF NOT EXISTS regions (
  region_id TEXT PRIMARY KEY,
  region_name TEXT NOT NULL,
  display_order INTEGER NOT NULL,
  food_discovery_lens TEXT
);

-- 2. PREFECTURES TABLE
CREATE TABLE IF NOT EXISTS prefectures (
  prefecture_id TEXT PRIMARY KEY,
  region_id TEXT NOT NULL REFERENCES regions(region_id) ON DELETE CASCADE,
  prefecture_name TEXT NOT NULL,
  primary_launch_city TEXT,
  suggested_phase TEXT
);

-- 3. LOCATIONS TABLE
CREATE TABLE IF NOT EXISTS locations (
  location_id TEXT PRIMARY KEY,
  location_name TEXT NOT NULL,
  type TEXT NOT NULL,
  parent_location_id TEXT REFERENCES locations(location_id) ON DELETE SET NULL,
  city TEXT,
  prefecture_id TEXT REFERENCES prefectures(prefecture_id) ON DELETE SET NULL,
  region_id TEXT REFERENCES regions(region_id) ON DELETE SET NULL,
  coverage_phase INTEGER,
  food_focus TEXT,
  admin_note TEXT,
  content_status TEXT NOT NULL DEFAULT 'Draft' CHECK (content_status IN ('Draft', 'In Review', 'Published'))
);

-- 4. DISHES TABLE
CREATE TABLE IF NOT EXISTS dishes (
  dish_id TEXT PRIMARY KEY,
  dish_name TEXT NOT NULL,
  japanese_name TEXT NOT NULL,
  region_id TEXT REFERENCES regions(region_id) ON DELETE SET NULL,
  primary_prefecture_id TEXT REFERENCES prefectures(prefecture_id) ON DELETE SET NULL,
  summary TEXT NOT NULL,
  seasons TEXT[] NOT NULL DEFAULT '{}',
  tags TEXT[] NOT NULL DEFAULT '{}',
  dietary_guidance TEXT,
  price_min INTEGER,
  price_max INTEGER,
  content_status TEXT NOT NULL DEFAULT 'Draft' CHECK (content_status IN ('Draft', 'In Review', 'Published')),
  home_filter_tags TEXT[] NOT NULL DEFAULT '{}',
  vegetarian_status TEXT NOT NULL DEFAULT 'Not reviewed' CHECK (vegetarian_status IN ('Not reviewed', 'Verified vegetarian', 'Not vegetarian')),
  halal_status TEXT NOT NULL DEFAULT 'Not reviewed' CHECK (halal_status IN ('Not reviewed', 'Verified halal', 'Not halal')),
  featured BOOLEAN NOT NULL DEFAULT FALSE,
  origin_history_preview TEXT,
  origin_history_full TEXT,
  did_you_know TEXT,
  key_ingredients TEXT[],
  pronunciation_phonetic TEXT,
  pronunciation_audio_url TEXT
);

-- 5. DISH_LOCATIONS JOIN TABLE
CREATE TABLE IF NOT EXISTS dish_locations (
  id BIGSERIAL PRIMARY KEY,
  dish_id TEXT NOT NULL REFERENCES dishes(dish_id) ON DELETE CASCADE,
  location_id TEXT NOT NULL REFERENCES locations(location_id) ON DELETE CASCADE,
  relationship TEXT NOT NULL CHECK (relationship IN ('origin', 'best-known', 'available', 'seasonal')),
  display_priority INTEGER NOT NULL DEFAULT 1,
  editorial_note TEXT,
  link_status TEXT NOT NULL DEFAULT 'Planned' CHECK (link_status IN ('Planned', 'Published')),
  CONSTRAINT unique_dish_location_link UNIQUE (dish_id, location_id, relationship)
);

-- ==========================================
-- INDEXES
-- ==========================================

-- Foreign key indexes
CREATE INDEX IF NOT EXISTS idx_prefectures_region_id ON prefectures(region_id);
CREATE INDEX IF NOT EXISTS idx_locations_parent_location_id ON locations(parent_location_id);
CREATE INDEX IF NOT EXISTS idx_locations_prefecture_id ON locations(prefecture_id);
CREATE INDEX IF NOT EXISTS idx_locations_region_id ON locations(region_id);
CREATE INDEX IF NOT EXISTS idx_dishes_region_id ON dishes(region_id);
CREATE INDEX IF NOT EXISTS idx_dishes_primary_prefecture_id ON dishes(primary_prefecture_id);
CREATE INDEX IF NOT EXISTS idx_dish_locations_dish_id ON dish_locations(dish_id);
CREATE INDEX IF NOT EXISTS idx_dish_locations_location_id ON dish_locations(location_id);

-- Content status indexes for fast query filtering (FR-7.4)
CREATE INDEX IF NOT EXISTS idx_locations_content_status ON locations(content_status);
CREATE INDEX IF NOT EXISTS idx_dishes_content_status ON dishes(content_status);
CREATE INDEX IF NOT EXISTS idx_dish_locations_link_status ON dish_locations(link_status);

-- GIN Indexes for array containment queries (seasons, tags, home_filter_tags)
CREATE INDEX IF NOT EXISTS idx_dishes_seasons_gin ON dishes USING GIN (seasons);
CREATE INDEX IF NOT EXISTS idx_dishes_tags_gin ON dishes USING GIN (tags);
CREATE INDEX IF NOT EXISTS idx_dishes_home_filter_tags_gin ON dishes USING GIN (home_filter_tags);

-- ==========================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Public read-only access for v1 (writes via Supabase dashboard/admin)
-- ==========================================

ALTER TABLE regions ENABLE ROW LEVEL SECURITY;
ALTER TABLE prefectures ENABLE ROW LEVEL SECURITY;
ALTER TABLE locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE dishes ENABLE ROW LEVEL SECURITY;
ALTER TABLE dish_locations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public read access for regions" ON regions;
CREATE POLICY "Public read access for regions" ON regions FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read access for prefectures" ON prefectures;
CREATE POLICY "Public read access for prefectures" ON prefectures FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read access for locations" ON locations;
CREATE POLICY "Public read access for locations" ON locations FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read access for dishes" ON dishes;
CREATE POLICY "Public read access for dishes" ON dishes FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public read access for dish_locations" ON dish_locations;
CREATE POLICY "Public read access for dish_locations" ON dish_locations FOR SELECT USING (true);

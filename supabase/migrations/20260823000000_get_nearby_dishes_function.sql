-- Step 2: Distance-Ranked Nearby Dishes Function
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;

CREATE OR REPLACE FUNCTION get_nearby_dishes(user_lat double precision, user_lng double precision)
RETURNS TABLE (
  dish_id text,
  dish_name text,
  japanese_name text,
  region_id text,
  primary_prefecture_id text,
  summary text,
  seasons text[],
  tags text[],
  dietary_guidance text,
  price_min integer,
  price_max integer,
  content_status text,
  home_filter_tags text[],
  vegetarian_status text,
  halal_status text,
  featured boolean,
  image_urls text[],
  did_you_know text,
  key_ingredients text[],
  origin_history_preview text,
  origin_history_full text,
  pronunciation_phonetic text,
  pronunciation_audio_url text,
  distance_km numeric,
  nearest_location_name text
) AS $$
DECLARE
  r double precision;
  radii double precision[] := ARRAY[15.0, 40.0, 100.0, 250.0];
  dish_count integer := 0;
  target_radius double precision := 250.0;
BEGIN
  -- 1. Try expanding radii: 15km -> 40km -> 100km -> 250km
  FOREACH r IN ARRAY radii
  LOOP
    SELECT COUNT(DISTINCT d.dish_id) INTO dish_count
    FROM dishes d
    JOIN dish_locations dl ON d.dish_id = dl.dish_id
    JOIN locations l ON dl.location_id = l.location_id
    WHERE d.content_status = 'Published'
      AND dl.link_status = 'Published'
      AND l.content_status = 'Published'
      AND l.lat IS NOT NULL
      AND l.lng IS NOT NULL
      AND (earth_distance(ll_to_earth(user_lat, user_lng), ll_to_earth(l.lat, l.lng)) / 1000.0) <= r;

    IF dish_count >= 6 THEN
      target_radius := r;
      EXIT;
    END IF;
  END LOOP;

  -- 2. Return distance-ranked dishes within the winning radius
  RETURN QUERY
  WITH candidate_dishes AS (
    SELECT DISTINCT ON (d.dish_id)
      d.*,
      ROUND((earth_distance(ll_to_earth(user_lat, user_lng), ll_to_earth(l.lat, l.lng)) / 1000.0)::numeric, 1) AS dist_km,
      l.location_name AS loc_name,
      dl.relationship AS rel,
      dl.display_priority AS prio,
      -- Weighted ranking score combining proximity, relationship, and display_priority
      (
        (earth_distance(ll_to_earth(user_lat, user_lng), ll_to_earth(l.lat, l.lng)) / 1000.0) * 1.2
        + CASE WHEN dl.relationship IN ('best-known', 'origin') THEN -30.0 ELSE 0.0 END
        + COALESCE(dl.display_priority, 1) * 3.0
      ) AS rank_score
    FROM dishes d
    JOIN dish_locations dl ON d.dish_id = dl.dish_id
    JOIN locations l ON dl.location_id = l.location_id
    WHERE d.content_status = 'Published'
      AND dl.link_status = 'Published'
      AND l.content_status = 'Published'
      AND l.lat IS NOT NULL
      AND l.lng IS NOT NULL
      AND (earth_distance(ll_to_earth(user_lat, user_lng), ll_to_earth(l.lat, l.lng)) / 1000.0) <= target_radius
    ORDER BY d.dish_id, (earth_distance(ll_to_earth(user_lat, user_lng), ll_to_earth(l.lat, l.lng))) ASC
  )
  SELECT
    cd.dish_id,
    cd.dish_name,
    cd.japanese_name,
    cd.region_id,
    cd.primary_prefecture_id,
    cd.summary,
    cd.seasons,
    cd.tags,
    cd.dietary_guidance,
    cd.price_min,
    cd.price_max,
    cd.content_status,
    cd.home_filter_tags,
    cd.vegetarian_status,
    cd.halal_status,
    cd.featured,
    cd.image_urls,
    cd.did_you_know,
    cd.key_ingredients,
    cd.origin_history_preview,
    cd.origin_history_full,
    cd.pronunciation_phonetic,
    cd.pronunciation_audio_url,
    cd.dist_km,
    cd.loc_name
  FROM candidate_dishes cd
  ORDER BY cd.rank_score ASC;
END;
$$ LANGUAGE plpgsql STABLE;

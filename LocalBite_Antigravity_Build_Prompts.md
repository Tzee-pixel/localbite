# LocalBite — Antigravity Build Prompts

**Stack:** React Native (Expo) + TypeScript, React Navigation, Supabase (Postgres + Auth + Storage)

**Why Supabase over Firebase:** your data model is inherently relational — `Region → Prefecture → Location` is a hierarchy with foreign keys, and `Dish Locations` is a proper many-to-many join table with its own attributes (`Relationship`, `Display priority`). That maps directly onto Postgres tables and joins. Firestore's NoSQL/subcollection model would force you to either duplicate data across documents or do a lot of manual join logic in the client — Postgres avoids both.

---

## How to use this document

1. Start a **new Antigravity workspace** pointed at an empty repo.
2. Paste **Step 0** first, as its own message, with your `LocalBite_PRD.md` and the 7 wireframe PNGs attached. This sets persistent project context — Antigravity should treat it as ground truth for the rest of the build.
3. Then feed the remaining steps **one at a time, in order**, as separate messages. Don't paste the whole file at once — each step assumes the previous one's output exists in the repo.
4. After each step, **run the app and sanity-check it** (or let Antigravity run/test it) before moving to the next step. If something's off, correct it in that step's thread before moving on — don't let errors compound across steps.
5. Steps 5–11 (the actual screens) can be reordered or done in parallel threads once Steps 0–4 are solid, since they mostly depend on the data layer, not each other. The order below just follows the user's natural first-run path.

---

## Step 0 — Project Brief & Ground Truth (paste once, first)

```
You are building "LocalBite," a dish-first food discovery app for travelers in Japan.

I'm attaching two things:
1. The full Product Requirements Document (LocalBite_PRD.md) — this is the source of
   truth for scope, functional requirements (FR-#), data model, and open questions.
2. Seven wireframe screens (01–07, PNG) — these define layout and content hierarchy.
   They are low-fidelity wireframes, not final visual design — you have latitude on
   colors, typography, and spacing, but must preserve the information architecture,
   content sections, and interaction affordances shown.

STACK FOR THIS PROJECT:
- React Native with Expo (managed workflow), TypeScript strict mode
- React Navigation (bottom tabs + native stack per tab)
- Supabase for Postgres database, auth (anonymous/session-based is fine for v1 —
  no login/signup flow is in scope), and storage (dish/location images)
- State/data fetching: TanStack Query (React Query) against the Supabase client
- Styling: a lightweight design token system (colors, spacing, type scale) — no UI
  kit dependency; components should be hand-built and reusable

WORKING AGREEMENT FOR THIS BUILD:
- Treat FR-# numbers from the PRD as acceptance criteria. When you finish a step,
  list which FR-#s you satisfied and flag any you couldn't fully implement yet.
- The PRD's "Open Questions & Risks" section (§10) lists things that are NOT yet
  specified (e.g. Favourites screen detail, Settings screen detail). Where a step
  touches one of these, implement a reasonable, simple v1 version and clearly
  comment `// TODO: unresolved PRD open question #N` in the code so we can revisit it.
- Every screen must handle a loading state and an empty/error state — the wireframes
  show only the "happy path" content-populated state.
- Do not build any restaurant listing/detail UI. Per the PRD changelog, that was
  explicitly removed from scope — Dish Detail's only outbound action is a Google
  Maps deep link (see FR-31, FR-32).

For this message, just confirm you've read both documents and give me:
1. A one-paragraph summary of the app in your own words (so I can confirm alignment)
2. The top 3 ambiguities you see that you'll need to make an assumption about before
   Step 1

Don't write any code yet.
```

---

## Step 1 — Project Scaffolding

```
Initialize the Expo/TypeScript project structure.

1. Create a new Expo app (TypeScript template) named "localbite".
2. Install and configure: React Navigation (bottom-tabs + native-stack),
   @supabase/supabase-js, @tanstack/react-query, expo-location,
   expo-av (for pronunciation audio playback), and any icon library you
   prefer (e.g. @expo/vector-icons).
3. Set up a `src/` structure:
   src/
     screens/
     components/
     navigation/
     lib/          (supabase client, query client)
     theme/         (design tokens: colors, spacing, typography scale)
     types/         (TypeScript types mirroring the PRD data model, §7.2)
4. In src/theme, define a small token system: a neutral/warm color palette
   suited to a food-discovery app, a type scale, and spacing scale. Wireframes
   are grayscale placeholders — use your judgment for the actual palette, but
   keep it consistent and centralized (no inline magic numbers/colors in screens).
5. In src/types, define TypeScript interfaces for Region, Prefecture, Location,
   Dish, and DishLocation exactly matching the fields listed in PRD §7.2.
6. Set up React Navigation with a placeholder bottom tab bar with 4 tabs —
   Explore, Search, Favourites, Settings (PRD §6.0, FR-1 through FR-6) — each
   rendering a blank placeholder screen for now. Confirm the tab bar behavior:
   it should stay visible on Explore/Search/Favourites/Settings but we'll
   revisit whether it recedes on the Dish Detail screen in a later step (FR-6).
7. Set up an empty Supabase client in src/lib/supabase.ts reading URL/anon key
   from environment variables (.env, not committed — add to .gitignore).

Don't implement any real screen content yet. Confirm the app builds and runs
in Expo Go / simulator with the 4 empty tabs visible before finishing this step.
```

---

## Step 2 — Supabase Schema & Data Seeding

```
Set up the Supabase database schema and seed it from my source spreadsheet data.

1. Write Postgres migration SQL (as a .sql file in a /supabase/migrations folder)
   creating these tables, matching PRD §7.2 field-for-field:
   - regions (region_id PK, region_name, display_order, food_discovery_lens)
   - prefectures (prefecture_id PK, region_id FK, prefecture_name,
     primary_launch_city, suggested_phase)
   - locations (location_id PK, location_name, type [City|Area|Market],
     parent_location_id FK to locations.location_id nullable, city,
     prefecture_id FK, region_id FK, coverage_phase, food_focus, admin_note,
     content_status [Draft|In Review|Published])
   - dishes (dish_id PK, dish_name, japanese_name, region_id FK,
     primary_prefecture_id FK, summary, seasons text[], tags text[],
     dietary_guidance text, price_min integer, price_max integer,
     content_status [Draft|In Review|Published], home_filter_tags text[],
     vegetarian_status [Not reviewed|Verified vegetarian|Not vegetarian],
     halal_status [Not reviewed|Verified halal|Not halal], featured boolean
     default false, origin_history_preview text, origin_history_full text,
     did_you_know text, key_ingredients text[], pronunciation_phonetic text,
     pronunciation_audio_url text)
   - dish_locations (id PK, dish_id FK, location_id FK,
     relationship [origin|best-known|available|seasonal],
     display_priority integer, editorial_note text,
     link_status [Planned|Published])
2. Add appropriate indexes (on foreign keys, on content_status, on dishes.seasons
   using GIN for array containment queries).
3. Enable Row Level Security with a public read-only policy for all tables
   (no auth-gated content in v1 — writes happen via Supabase dashboard/admin
   only, not from the app).
4. I'll export my working spreadsheet (japan-location-hierarchy-with-dishes.xlsx)
   sheets — Regions, Prefectures, Locations, Dishes, Dish Locations — as CSVs
   and share them with you. Write a seed script (Node or SQL COPY commands)
   that imports each CSV into its matching table. Map the spreadsheet's Region
   ID / Location ID / Dish ID text keys directly as primary keys (they're
   already stable lowercase slugs per the Admin Guide rules in the PRD).
   Note: origin_history_preview/full, did_you_know, key_ingredients,
   pronunciation_phonetic/audio_url are NOT in the current spreadsheet — add
   them as nullable columns for now and seed them as null; flag this as
   content that still needs to be authored (PRD §8.2 authoring checklist).
5. Every dish and location should seed with content_status = 'Draft' as-is
   from the spreadsheet (per PRD §7.4) — do not mark anything Published by
   default. Separately, give me the SQL to flip a specific set of dish_ids
   and location_ids to 'Published' so I can control what's actually live
   for testing.

Show me the schema and seed script before running it. Confirm row counts
after seeding match the spreadsheet (8 regions, 47 prefectures, 71 locations,
37 dishes, 42 dish_locations links).
```

---

## Step 3 — Data Layer (Queries)

```
Build the data-fetching layer using TanStack Query against Supabase, in
src/lib/queries.ts (or split by domain if cleaner).

Only ever query rows where content_status = 'Published' (or link_status =
'Published' for dish_locations) — Draft/In Review content must never reach
the UI, per PRD §7.4.

Implement these query hooks:
1. useResolvedLocation(lat, lng) — given coordinates, find the nearest
   Published Location. If the nearest match has fewer than 4 linked
   Published dishes (via dish_locations), walk up via parent_location_id
   to the City level and use that instead. Return null if nothing is
   within a reasonable radius (PRD §7.3, FR-17).
2. useDishesInPeakSeason(regionId) — dishes where the current calendar
   season is in the dish's seasons array, filtered to the given region,
   ordered for carousel display (PRD FR-14).
3. useLocalSpecialities(locationId) — dishes linked to a location via
   dish_locations, ordered by relationship (best-known before available)
   then display_priority (FR-15, FR-47).
4. useFeaturedDishes() — dishes where featured = true, for the
   Location-Denied fallback state (FR-19, FR-21).
5. useDish(dishId) — full single-dish record for Dish Detail.
6. useSearch(query) — full-text-ish search across dish_name, japanese_name,
   location_name, and season keywords, returning grouped results
   { dishes: [...], locations: [...] } (FR-34, FR-39).
7. useSeasonalDishes(season, regionId?) — dishes for a given season,
   optionally filtered by region (FR-40–FR-44).
8. useLocationDetail(locationId) — single location + its full ordered
   dish list (FR-45–FR-48).

Write these as typed hooks returning { data, isLoading, isError } via
React Query. Don't build any screens yet — just the data layer. Give me a
short scratch/test screen (temporary, to be deleted later) that calls each
hook and prints raw JSON so we can sanity-check the queries against the
seeded data before building real UI.
```

---

## Step 4 — Location Permission & Navigation Shell

```
Implement Step 0's PRD flow: the first-launch location permission screen
and the Explore-tab routing logic that depends on it.

1. Build the Location Permission screen per wireframe 01_Location_Permission.png
   and PRD §6.1 (FR-7–FR-10):
   - Title "Local Speciality Finder", body copy, primary CTA "Enable Location
     Access", secondary CTA "Explore Regions Manually"
   - "Enable Location Access" triggers expo-location's requestForegroundPermissionsAsync
   - "Explore Regions Manually" skips straight to Explore in the denied state
   - This screen should only show once — persist a flag (AsyncStorage or
     expo-secure-store) so it doesn't reappear on subsequent app opens unless
     permission is later revoked in system settings
2. Wire the Explore tab to branch based on permission + resolution result:
   - Granted + location resolves to a Published Location → Explore/Granted
     state (build in Step 5)
   - Denied, OR granted but resolution returns null (PRD §7.3 fallback) →
     Explore/Denied-Unavailable state (build in Step 6)
   These are two different reasons for the same visual state — make sure
   your code distinguishes them internally (see PRD §10, Open Question 3)
   even if the UI treatment is initially the same, so we can differentiate
   copy later without a rearchitecture.
3. Finish wiring the bottom tab bar's 4 real destinations (Explore, Search,
   Favourites — simple placeholder screen for now, Settings — simple
   placeholder screen for now) using the routing logic above for Explore.

Confirm: on a fresh install, the permission screen appears once; after
responding either way, subsequent app opens go straight to the right
Explore state without re-prompting.
```

---

## Step 5 — Explore Screen (Location Granted)

```
Build the Explore screen's location-granted state per wireframe
02_Location_Granted.png and PRD §6.2 (FR-11–FR-17).

Sections, top to bottom:
1. Header: resolved location name (from useResolvedLocation)
2. Persistent search bar with placeholder "Search by location, dish or
   season..." — tapping it navigates to the Search tab (FR-12)
3. Horizontally scrollable filter chips: Quick Bite, Vegetarian, Dine-in,
   Halal, Seasonal Peak — multi-select, filtering the sections below by
   matching against dishes.home_filter_tags (FR-13)
4. "In Peak Season Right Now" — horizontal carousel using
   useDishesInPeakSeason (FR-14)
5. "Local Speciality in [Location]" — 2-column grid using
   useLocalSpecialities, each card: image, dish name, truncated summary,
   "Know More" → navigates to Dish Detail with dishId (FR-15, FR-16)

Handle loading (skeleton placeholders matching card shapes) and empty
states (e.g., "No dishes published here yet" — should be rare given the
Step 3 fallback logic, but must not crash or show a blank screen).

Reference wireframe 02 for layout proportions but use your own visual
design per the theme tokens from Step 1.
```

---

## Step 6 — Explore Screen (Location Denied / Unavailable)

```
Build the Explore screen's location-denied/unavailable state per wireframe
03_Location_Denied.png and PRD §6.3 (FR-18–FR-21).

Sections, top to bottom:
1. Header: "Location Unavailable" with inline "Allow Location Access >"
   link — tapping it re-triggers the OS permission prompt, or if
   permission was previously denied at the OS level (can't re-prompt),
   deep-links to system settings instead (FR-18)
2. Same search bar and filter chips as the granted state (FR-20)
3. A season header block: current season name + one-line theme copy
   (e.g. "Early Autumn in Japan" / "The season of rich harvests...") —
   for now, hardcode this seasonal copy in a small lookup table keyed by
   month, since it's not in the current dish/location data model
4. "Peak Seasonal Speciality" — carousel of nationally featured seasonal
   dishes (reuse useDishesInPeakSeason without a region filter, or add
   a national variant)
5. "Popular Dishes in Japan" — grid using useFeaturedDishes (FR-19, FR-21)

This should be the same screen component as Step 5 with a different data
source and header, not a fully separate screen — share the dish-card and
grid/carousel components between both states.
```

---

## Step 7 — Dish Detail Screen

```
Build the Dish Detail screen per wireframe 04_Card_Detail.png and PRD §6.4
(FR-22–FR-32). This is the most content-dense screen — build it as a single
scrollable page, not multiple screens.

Top to bottom:
1. Image carousel (swipeable, page dots), with Back and Save icon buttons
   overlaid/pinned in the header area. Save toggles this dish into
   Favourites (persist via a favourites table in Supabase keyed to a
   device/anonymous session ID, or local storage for v1 — your call, note
   the choice) (FR-22)
2. Japanese name (large script), English name + descriptive translation,
   phonetic pronunciation as a tappable row with a speaker icon that plays
   pronunciation_audio_url via expo-av if present, otherwise hide the
   audio icon and just show the phonetic text (FR-23)
3. Tag chips from dish.tags / home_filter_tags (FR-24)
4. Summary paragraph (FR-25)
5. Two side-by-side info cards: "Dietary" (dietary_guidance text) and
   "Typical price" (formatted ¥price_min–¥price_max). If vegetarian_status
   or halal_status is 'Not reviewed', do NOT show a green checkmark or any
   affirmative badge — render neutral/informational styling only. This is
   a hard requirement, not a style preference (PRD §7.4, §8.4) (FR-26)
6. "Where to Look for it?" bulleted list (FR-27)
7. "Origin & Cultural History" — show origin_history_preview by default
   with a "Read More..." link that expands to show origin_history_full
   inline (no navigation). Animate the expand if straightforward, but a
   simple show/hide is fine for v1 (FR-28)
8. "Did You Know?" callout card, only rendered if did_you_know is non-null
   (FR-29)
9. "Key Ingredients & Traditional Method" bulleted list from
   key_ingredients (FR-30)
10. "Find it Nearby" teaser card: icon + copy "Open Google Maps to see
    current nearby places serving {dish.dish_name}" (FR-31)
11. Primary CTA button "Find on Google Maps" — opens a Google Maps search
    deep link. Construct the query as `${dish.dish_name} near me` combined
    with the resolved/current location name if available, e.g.
    "Okonomiyaki restaurant near Sapporo, Japan" — use Linking.openURL with
    a maps search URL scheme (FR-32)

Do NOT build any restaurant list, restaurant cards, sort-by control, or a
secondary "Know More about the Dish" button — these were removed from
scope (see PRD changelog and FR-33).

Handle the case where optional content fields (did_you_know,
pronunciation_audio_url, origin_history_full, key_ingredients) are null,
since the current seed data has them empty until content is authored
(per Step 2 notes) — the screen should degrade gracefully, not show
empty section headers with no content.
```

---

## Step 8 — Search Screen

```
Build the Search screen per wireframe 05_Search_Screen.png and PRD §6.5
(FR-34–FR-39).

1. Search input with placeholder "Search by location, dish or season..."
   and typeahead behavior using useSearch, debounced (~300ms)
2. Pre-query state (empty search input) shows:
   - Same filter chips row as Explore
   - 2x2 grid of season shortcut buttons: Summer, Spring, Winter, Autumn —
     each navigates to the Seasonal Search screen (Step 9) pre-filtered to
     that season (FR-35)
   - "Locations" section: horizontal scroll of location shortcut cards
     (image + name) with a "More >" link to a full location browser (a
     simple region-grouped list screen — build minimally, flag as light
     scope in PRD terms) (FR-36)
   - "Dishes" section: similar horizontal shortcut carousel + "More >" to
     a full filterable dish index (FR-37)
3. In-query state: replace the above with live results grouped under
   "Dishes" and "Locations" headers as the user types, using useSearch
   (FR-39). Respect active filter chips (FR-38).
4. Tapping a dish result → Dish Detail. Tapping a location result →
   Location Detail (Step 10).

Reference wireframe 05 for the pre-query layout; the in-query results
layout isn't wireframed in detail, so use a simple grouped list and note
that as an assumption.
```

---

## Step 9 — Seasonal Search Screen

```
Build the Seasonal Search screen per wireframe 06_Seasonal_Search_Screen.png
and PRD §6.6 (FR-40–FR-44).

1. Header: season name (e.g. "Autumn Speciality") + evocative one-line
   theme + short description — use the same seasonal copy lookup table
   introduced in Step 6, keyed by season
2. Region filter tabs: All, Hokkaido, Tohoku, Kanto, Chubu, Chugoku,
   Kansai, Shikoku, Kyushu — horizontally scrollable, single-select,
   "All" active by default (FR-41)
3. "Peak Ingredients" carousel — for v1, since there's no dedicated
   ingredient content type yet (PRD §10, Open Question 2), reuse the Dish
   card/query pattern filtered to dishes tagged 'Seasonal Peak' as a
   stand-in, and add a `// TODO: unresolved PRD open question #2 — model
   ingredients as their own lightweight content type` comment (FR-42)
4. "Seasonal Dishes" grid — useSeasonalDishes(season, selectedRegion),
   updates when either the season (from route params) or region tab
   changes (FR-43)
5. Reflect season + region tab selection in the navigation route
   params/URL so this screen state is deep-linkable (FR-44)

This screen should be reachable both from the Search screen's season
buttons (Step 8) and from a location's context if relevant — just wire
the season-button entry point for now.
```

---

## Step 10 — Location Detail Screen

```
Build the Location Detail screen per wireframe 07_Seasonal_Search_Screen.png
(the Karuizawa example) and PRD §6.7 (FR-45–FR-48).

1. Header: location name + prefecture (e.g. "Karuizawa, Nagano")
2. Editorial description paragraph from location.food_focus (expand this
   into a fuller sentence/paragraph if the raw spreadsheet text is too
   terse — flag where you've done this)
3. "Top Local Specialities in [Location]" — full 2-column grid (not a
   carousel) using useLocationDetail, ordered by relationship then
   display_priority (FR-47)
4. If the location has a parent_location_id (i.e. it's an Area or Market,
   not a City), show a breadcrumb back to the parent City name, and if
   this location has fewer than 4 published dishes on its own, merge in
   the parent's dishes to avoid a sparse page (FR-48, and the Admin Guide
   anti-sparse rule referenced throughout the PRD)

Reachable from: Search screen's "Locations" shortcuts/More, and from
tapping a location search result.
```

---

## Step 11 — Favourites & Settings (Minimal v1)

```
These two tabs are referenced in navigation (PRD §6.0) but not detailed
in any wireframe (PRD §10, Open Question 1). Build minimal, functional
versions — don't over-invest here, just make them usable:

FAVOURITES:
- A simple list/grid of saved dishes (from the Save action on Dish Detail,
  Step 7), showing image + dish name + one-line summary, tappable through
  to Dish Detail
- Empty state: friendly message + a CTA back to Explore if there's nothing
  saved yet
- Add `// TODO: unresolved PRD open question #1 — confirm whether
  Favourites should support saved Locations too, and/or trip/itinerary
  grouping` in the code

SETTINGS:
- A simple list of settings rows: "Location permission" (shows current
  status, deep-links to system settings), "About LocalBite" (static
  info), and a units/language row as a disabled/placeholder for now
  since v1 is English-only (PRD §9)
- Add the same `// TODO: unresolved PRD open question #1` style comment
  noting Settings scope wasn't specified beyond the nav placeholder

Keep both screens simple — they exist so the tab bar isn't dead-ended,
not as fully-scoped features yet.
```

---

## Step 12 — QA & Polish Pass

```
Do a full pass across all screens built in Steps 4–11:

1. Verify every screen has a loading state and an empty/error state — no
   screen should be able to render blank or crash on missing data.
2. Verify no Draft/In Review content ever appears in any query result
   (spot-check by temporarily flipping a seed dish back to Draft and
   confirming it disappears everywhere).
3. Verify the Vegetarian/Halal filter chips only surface dishes with a
   verified (not 'Not reviewed') status, and that the Dietary card on
   Dish Detail never implies certification for unverified dishes
   (PRD §7.4, §8.4 — this is the highest-risk area in the PRD, treat it
   as a hard gate, not a nice-to-have).
4. Verify deep links work: a Dish Detail URL and a Seasonal Search
   URL (with season + region params) should open directly to the right
   state from cold start.
5. Give me a short report: which FR-#s from the PRD are fully implemented,
   which are partially implemented, and which are still open (cross-
   referencing PRD §10's Open Questions list).
```

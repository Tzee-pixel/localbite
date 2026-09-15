# Product Requirements Document: LocalBite
### Local Speciality Finder — Discover Authentic Regional Food, Wherever You Are

| | |
|---|---|
| **Status** | Draft v1.1 |
| **Author** | [Your name] |
| **Date** | August 17, 2026 |
| **Platform** | iOS / Android (mobile-first) |
| **Market (Phase 1)** | Japan |

**Changelog from v1.0:**
- Added persistent bottom tab navigation (Explore / Search / Favourites / Settings), replacing the header-level "Saved Collection" entry point.
- Dish Detail redesigned: dietary and price info are now structured, explicit UI fields; long-form cultural history is inline with progressive disclosure ("Read More") instead of a separate screen.
- **Restaurant listing section removed from Dish Detail.** The product no longer curates or displays individual restaurant cards — "Find on Google Maps" is now the single, primary path from dish to place. This meaningfully reduces content-ops scope for v1 (see §8.3).
- Screen count reduced from 8 to 7 (the standalone "Dish History" screen is now folded into Dish Detail via expand/collapse).

---

## 1. Problem Statement

Travelers want to eat like locals, but they can't find their way to the food that actually defines a place.

Existing food discovery apps (Google Maps, Tabelog, Yelp) are optimized for **ratings and popularity**, not **regional authenticity**. This creates a recurring failure pattern for travelers:

1. They arrive somewhere new and want to try the dish the region is famous for.
2. They open a food app and get a list of highly-rated restaurants — with no indication of what's actually *local* versus what's generically popular with tourists.
3. Menus are in Japanese, dishes are unfamiliar, and there's no context on what to order or how.
4. Faced with that uncertainty, they default to the safe, familiar, or heavily-reviewed tourist spot.
5. They leave the region having eaten adequately, but never having tasted what made that trip *food-worthy* — and they know it.

**The gap isn't restaurant discovery — it's dish discovery.** Travelers don't know what they don't know. They need a layer that answers "what should I be eating here, right now" *before* they get to "where should I eat it."

---

## 2. Product Vision

> **LocalBite is a dish-first discovery app that tells travelers what to eat in a specific place, at a specific time of year, and gives them the confidence to order it — then sends them to Google Maps to find it nearby.**

Instead of starting from restaurants, LocalBite starts from **the dish** — its story, its season, how to recognize it, and how to order it. The product deliberately stops short of being a restaurant directory: once a traveler understands *what* they're looking for, LocalBite hands off to Google Maps for the *where*, rather than trying to compete with it.

### Guiding principles
- **Dish-first, not restaurant-first.** The app's job ends at "you now know what to look for and how to ask for it" — it is not a restaurant database.
- **Location + season together.** "What's good here" changes by month; the product should feel alive, not static.
- **Reduce ordering anxiety.** Phonetic pronunciation, visual/sensory cues, structured dietary/price info, and plain-language stories turn hesitation into confidence.
- **Editorial, not crowdsourced.** Content is curated and fact-checked (see §8), not scraped reviews — this is the trust differentiator vs. Google Maps.
- **Do one thing well.** By not trying to also be a restaurant directory, the app avoids the staleness/liability problems of maintaining restaurant listings (hours, closures, menus) — that responsibility stays with Google Maps.

---

## 3. Target Users

### Primary persona: "The Curious Independent Traveler"
- Traveling in Japan (solo, couple, or small group), 1–3 weeks.
- Not on a packaged tour; makes their own daily food decisions.
- Wants "real" experiences and will actively seek out a specialty dish as part of the trip.
- Limited or no Japanese language ability; anxious about menus and ordering etiquette.
- Already uses Google Maps for navigation but finds it unsatisfying for "what should I actually eat here."

### Secondary persona: "The Planning Foodie"
- Researches food *before* the trip; builds a mental list of dishes to try region by region.
- Wants to plan around seasonal peak — e.g., timing a Hokkaido trip to hit crab season.
- Likely to be the primary user of **Favourites**, saving dishes ahead of a trip.

### Out of scope for v1
- Restaurant owners / business-side users (no claim/manage-listing flows — reinforced by the removal of the restaurant list, see Changelog).
- Locals looking for everyday dining (this is a visitor-context product).

---

## 4. Goals & Success Metrics

| Goal | Metric | Target (first 2 quarters post-launch) |
|---|---|---|
| Help travelers discover dishes they wouldn't otherwise find | % of sessions that view a Dish Detail page | ≥ 60% |
| Convert discovery into confident action | % of Dish Detail views that tap "Find on Google Maps" | ≥ 30% *(raised from v1.0 — this is now the single conversion path, not one of several)* |
| Reduce ordering anxiety | % of Dish Detail views that expand "Read More" (cultural history) or play pronunciation audio | ≥ 30% |
| Location relevance | % of sessions using granted location (vs. manual browse) | ≥ 50% once location-enabled |
| Retention across a trip | Return sessions per user within a 14-day window | ≥ 3 |
| Save behavior | % of users who save at least one dish/location to Favourites | ≥ 20% |
| Content trust | User reports of inaccurate dietary/allergen info | Track to zero; each report triggers content review (see §8.4) |

---

## 5. Scope & Phasing

Content rollout is gated by the location hierarchy already modeled in the data set (see §7), not by engineering effort alone — a location should not go live without enough curated dish content to be useful (per **Admin Guide** rule: *"Avoid: Showing a mostly empty location in the app."*).

| Phase | Coverage | Basis |
|---|---|---|
| **Phase 1 (MVP launch)** | 7 seed locations, national dish set in Draft→Published pipeline | `Locations` sheet: 7 records flagged Coverage phase = 1 |
| **Phase 2** | Expand within already-launched regions (e.g., more Hokkaido areas/markets) | Coverage phase = 2 |
| **Phase 3–4** | Additional regions (Tohoku, Kansai, etc.) as content is authored | Coverage phase = 3, 4 per `Locations`/`Prefectures` sheets |
| **Post-MVP / Future** | Countries beyond Japan | New top-level `Region` hierarchy re-using the same schema |

**In scope for v1:**
- Persistent bottom navigation: Explore, Search, Favourites, Settings.
- Location-based and manual browsing of dishes by Region → Prefecture → Location.
- Seasonal discovery (What's in peak season now / by season).
- Search by location, dish, or season.
- Dish detail pages with structured dietary/price info, cultural context, ordering tips, and a single outbound action to Google Maps.
- Saving dishes/locations to Favourites.
- Filters: Quick Bite, Vegetarian, Dine-in, Halal, Seasonal Peak.

**Out of scope for v1:**
- Any in-app restaurant directory, listings, or restaurant-level detail pages (explicitly removed from design — see Changelog).
- In-app reservations or ordering.
- User-generated reviews or ratings.
- Translation/live camera menu scanning (candidate for v2).
- Multi-country content (structure supports it; content doesn't exist yet).
- Settings screen functionality is referenced by the nav bar but not yet specified — see §10, Open Question 1.

---

## 6. Experience Overview & Screen-by-Screen Requirements

This maps directly to the provided wireframes (7 screens).

### 6.0 Global Navigation
**Purpose:** Give the app a persistent, predictable structure across all main screens.

**Requirements:**
- FR-1: A bottom tab bar with four destinations is present on all primary (non-modal, non-detail-drilldown) screens: **Explore**, **Search**, **Favourites**, **Settings**.
- FR-2: **Explore** = the Home screen (§6.2 / §6.3, location-granted or -denied state).
- FR-3: **Search** = the Search screen (§6.5).
- FR-4: **Favourites** = the user's saved dishes/locations (replaces the "Saved Collection" header link from v1.0). Not detailed in wireframes yet — scope as a simple saved-items list for v1 unless specified otherwise (see §10).
- FR-5: **Settings** = app-level preferences (units, language, location permission management, notifications if any). Not detailed in wireframes — flag as an open scope item (§10).
- FR-6: The tab bar should recede or stay unobtrusive on scroll-heavy detail screens (e.g., Dish Detail) if it interferes with primary CTAs — confirm interaction pattern during visual design.

### 6.1 First Launch — Location Permission (`01_Location_Permission.png`)
**Purpose:** Set expectations for the app's value prop and get location consent without blocking the user.

**Requirements:**
- FR-7: On first app open, show a modal with app name, one-paragraph value proposition, and two CTAs: **"Enable Location Access"** (primary) and **"Explore Regions Manually"** (secondary, non-blocking).
- FR-8: Tapping "Enable Location Access" triggers the native OS location permission prompt.
- FR-9: Tapping "Explore Regions Manually" dismisses the modal and routes to the Explore tab in the **Location Denied/Unavailable** state (§6.3), without triggering the OS prompt.
- FR-10: This modal should not reappear on subsequent app opens unless permission state changes (e.g., revoked in system settings).

### 6.2 Explore — Location Granted (`02_Location_Granted.png`)
**Purpose:** Immediately surface what's relevant *here* and *now*.

**Requirements:**
- FR-11: Header shows the resolved location name (nearest supported `Location` record; see §7 for resolution logic).
- FR-12: Persistent search bar: *"Search by location, dish or season…"* — always accessible; tapping it can also route into the Search tab for a full-screen search experience.
- FR-13: Quick filter chips: Quick Bite, Vegetarian, Dine-in, Halal, Seasonal Peak — multi-select, filters all dish content below.
- FR-14: **"In Peak Season Right Now"** horizontal carousel — dishes where the current date falls within the dish's `Seasons` field, prioritized for the user's resolved region.
- FR-15: **"Local Speciality in [Location]"** grid — dishes linked to the resolved location via the `Dish Locations` table, ordered by `Relationship` (best-known before available) then `Display priority`.
- FR-16: Each dish card = image, dish name, one-line summary (from `Dishes.Summary`, truncated), "Know More" link → Dish Detail.
- FR-17: If the resolved location has fewer than a minimum content threshold (e.g., 4 dishes), fall back to the nearest parent location (e.g., Area → City) per the location hierarchy, rather than showing a sparse page.

### 6.3 Explore — Location Denied/Unavailable (`03_Location_Denied.png`)
**Purpose:** Give a graceful, still-useful default experience.

**Requirements:**
- FR-18: Header shows **"Location Unavailable"** with an inline **"Allow Location Access →"** link that re-triggers the OS permission flow (or deep-links to system settings if previously denied).
- FR-19: Content defaults to a **national/seasonal view** rather than a specific location: "[Season] in Japan" header + description, "Peak Seasonal Speciality" carousel, and "Popular Dishes in Japan" grid (curated, not location-scoped).
- FR-20: Same filter chips and search bar remain available and functional without location.
- FR-21: "Popular Dishes in Japan" selection logic should be editorially curated (a flag on `Dishes`, e.g. `Featured = true`) rather than algorithmic, since there's no ratings data to rank by.

### 6.4 Dish Detail (`04_Card_Detail.png`)
**Purpose:** This is the core trust-building screen — it must replace the confidence a local companion would give you. **This screen is now a single scrollable page with progressive disclosure**, replacing the two-screen (card + history) pattern from v1.0.

**Requirements:**
- FR-22: Image carousel (multiple photos, swipeable, with page indicator) at top; **Back** and **Save** actions persist in the header while scrolling. "Save" adds the dish to **Favourites**.
- FR-23: Dish name shown in **Japanese script**, **English name with descriptive translation** (e.g., *"As-You-Like-It Pancake"*), and a **phonetic pronunciation guide** with an audio playback icon (🔊).
- FR-24: Tag chips (e.g., Dine-in, Seasonal Peak) sourced from `Dishes.Tags` / `Home filter tags`.
- FR-25: **Summary** paragraph (`Dishes.Summary`).
- FR-26: **Structured info cards, side by side:**
  - **Dietary** card — plain-language allergen/ingredient summary (`Dishes.Dietary guidance`). Until `Vegetarian status`/`Halal status` is formally verified, this card must not imply certification — see FR-38.
  - **Typical price** card — a ¥ range rendered directly from `Dishes.Price min` / `Price max`.
- FR-27: **"Where to Look for it?"** — a short, scannable bulleted list of sensory/visual cues (signage, smells, seating style) that help a traveler recognize the right kind of establishment. Editorial content, authored per dish.
- FR-28: **"Origin & Cultural History"** — shows a short preview (2–3 sentences) with a **"Read More…"** link that expands the full narrative inline (no navigation to a new screen). Content should be authored with a clear truncation point in mind (a short opening + fuller continuation).
- FR-29: **"Did You Know?"** callout — a single surprising/shareable fact. Optional per dish but recommended for engagement.
- FR-30: **"Key Ingredients & Traditional Method"** — bulleted list. This is flavor/technique content and is explicitly **not** a substitute for the structured Dietary card (FR-26) for allergen decisions.
- FR-31: **"Find it Nearby"** teaser card — icon + one line of templated copy (*"Open Google Maps to see current nearby places serving {Dish Name}"*) directly above the primary CTA. `{Dish Name}` is interpolated from `Dishes.Dish name`.
- FR-32: Primary CTA **"Find on Google Maps"** — deep-links out to Google Maps search for the dish name + resolved/selected location. This is now the **sole** mechanism for finding a place to eat; there is no in-app restaurant list (see §8.3 for the rationale and content-ops implications).
- FR-33 *(removed from v1.0)*: ~~Restaurants section with cards, Sort By, and "Know More about the Dish" secondary CTA.~~ These elements are no longer part of the design. Do not build restaurant-card UI or a restaurant data pipeline for v1.

### 6.5 Search (`05_Search_Screen.png`)
**Purpose:** Single entry point for all discovery, not just keyword lookup.

**Requirements:**
- FR-34: Search bar supports free text across dish name, location name, and season (per placeholder copy) with typeahead.
- FR-35: Below the search bar (pre-query state), show **season shortcut buttons**: Summer, Spring, Winter, Autumn — tapping routes to the Seasonal Search screen (§6.6) for that season.
- FR-36: **Locations** row — horizontally scrollable shortcuts to popular/nearby locations, with a **"More >"** link to a full location browser (Region → Prefecture → Location drill-down, per §7 hierarchy).
- FR-37: **Dishes** row — similarly, a shortcut carousel with "More >" to a full dish index/filterable list.
- FR-38: Filter chips remain available above the season buttons so search results can be pre-filtered (e.g., searching within Vegetarian only).
- FR-39: As the user types, live results should be grouped by type (Dishes / Locations) rather than an undifferentiated list.

### 6.6 Seasonal Search (`06_Seasonal_Search_Screen.png`)
**Purpose:** Let the "when" dimension drive discovery, and let users cross it with "where."

**Requirements:**
- FR-40: Header states the season name (e.g., "Autumn Speciality") with an evocative one-line theme (*"The Season of Harvest & Rich Flavors"*) and a short description — editorial content per season, not auto-generated.
- FR-41: Region filter tabs (All, Hokkaido, Tohoku, Kanto, Chubu, Chugoku, Kansai, Shikoku, Kyushu) allow narrowing seasonal dishes to a specific `Region` — this maps directly to the 8-region top-level hierarchy in the data model.
- FR-42: **"Peak Ingredients"** carousel — seasonal ingredients (not full dishes) that are at their peak; supports a lighter-weight content type than a full dish record (open question, §10).
- FR-43: **"Seasonal Dishes"** grid — all dishes where `Seasons` includes the selected season, filtered further by the selected region tab.
- FR-44: Region tab selection and season should both be reflected in the URL/deep-link state so results are shareable and bookmarkable.

### 6.7 Location Detail (`07_Seasonal_Search_Screen.png` — Karuizawa example)
**Purpose:** A dedicated page per browsable location for manual explorers.

**Requirements:**
- FR-45: Header: Location name + parent prefecture (e.g., "Karuizawa, Nagano").
- FR-46: Short editorial description of the location's food identity (`Locations.Food focus`, expanded into a full paragraph — e.g., *"Alpine Highland Cuisine. Known for fresh mountain spring water, wild game, and artisanal buckwheat soba noodles."*).
- FR-47: **"Top Local Specialities in [Location]"** — full grid (not carousel) of every dish linked to this location via `Dish Locations`, ordered by `Relationship` then `Display priority`.
- FR-48: If this location is an `Area` or `Market` (has a `Parent location ID`), show a breadcrumb back to the parent City, and optionally roll up dishes from the parent if the child location alone has too few (per Admin Guide anti-sparse rule).

---

## 7. Data Model & Content Architecture

The wireframes are backed by a hierarchy already defined in `japan-location-hierarchy-with-dishes.xlsx`. This should be treated as the v1 content schema, not just reference data. **This section is unchanged from v1.0** — the data model still fully supports the redesigned screens; the removal of the restaurant section actually simplifies content requirements (see §8.3).

### 7.1 Entity relationship overview

```
Region (8)
  └── Prefecture (47)
        └── Location (71) — Type: City | Area | Market
                                (Areas/Markets have Parent location ID)
Dish (37 seed records)
  ⇄  Dish Locations (join table, many-to-many)
        Relationship: origin | best-known | available | seasonal
        Display priority, Editorial note, Link status
```

### 7.2 Core entities

**Region** — top-level filter (Hokkaido, Tohoku, Kanto, Chubu, Chugoku, Kansai, Shikoku, Kyushu). Fields: Region ID, Region name, Display order, Prefectures (list), Food-discovery lens.

**Prefecture** — Region ID, Prefecture name, Primary launch city, Example places to add, Suggested phase. Used for content planning/rollout, not a user-facing browse level on its own.

**Location** — Location ID (stable lowercase key), Location name, Type (City/Area/Market), Parent location ID (nullable — enables nesting, e.g., Susukino and Nijo Market nested under Sapporo), City, Prefecture, Region, Coverage phase, Food focus, Admin note, Content status (Planned → Published).

**Dish** — Dish ID, Dish name (English), Japanese name, Region, Primary prefecture, Summary, Seasons (multi-value), Tags, **Dietary guidance** (now directly surfaced in the UI's Dietary card, FR-26), **Price min/max (¥)** (now directly surfaced in the Typical price card, FR-26), Content status, Home filter tags, Vegetarian status, Halal status.

**Dish Locations** (join table) — Dish ID, Location ID, Relationship (origin / best-known / available / seasonal), Display priority, Editorial note, Link status. Powers the location-scoped dish grids (§6.2, §6.7). **Note:** this table links dishes to *places* (cities/areas/markets), not to individual restaurants — it was never intended to model restaurant-level data, which aligns cleanly with the restaurant section's removal from the UI.

### 7.3 Location resolution logic (for Explore screen personalization)
1. Get device GPS coordinates (if permission granted).
2. Match to nearest `Location` record with `Content status = Published`.
3. If nearest match has < content threshold, walk up via `Parent location ID` to the City level.
4. If no `Location` within a reasonable radius (e.g., outside Japan, or in an unmapped area), fall back to Location Denied/Unavailable state (§6.3) even though permission was granted — this is a distinct state from "permission denied" and should be handled explicitly (see §10).

### 7.4 Content status & dietary verification workflow
The data set is currently 100% `Draft`/`Planned` content with `Vegetarian status` / `Halal status` = `Not reviewed`. With dietary info now a prominent, structured UI element (FR-26), this becomes a **more visible launch blocker**, not less:
- A dish cannot be exposed under the **Vegetarian** or **Halal** filter chip, nor show an affirmative claim in the Dietary card, until its status is verified.
- Content status should progress: `Draft` → `In Review` → `Published`. Only `Published` content with resolved dietary statuses appears live.

---

## 8. Content Operations Requirements

### 8.1 Minimum content bar per location before publishing
Per Admin Guide rule: define and enforce a minimum (recommend **≥ 4 published dishes** linked via `Dish Locations`) before a `Location` can move from `Planned` to `Published`.

### 8.2 Dish authoring checklist
Each published dish requires, at minimum:
- English + Japanese name, phonetic pronunciation (+ audio asset)
- Summary, structured Dietary guidance text, structured price range
- Origin & Cultural History written with an explicit short-preview / full-expansion split (for the "Read More" pattern, FR-28)
- "Where to Look for it" cues
- At least one linked location with `Relationship` set
- Season(s)
- Vegetarian/Halal status resolved (not "Not reviewed") if the dish is to appear under those filter chips or show an affirmative Dietary card claim

### 8.3 Restaurant data — **no longer required for v1**
The redesigned Dish Detail screen removes the in-app restaurant list entirely (§6.4, FR-33). This is a meaningful scope reduction from v1.0:
- No restaurant name/blurb/image content needs to be authored, sourced, or kept fresh.
- No restaurant claim flow, hours, or stale-listing risk to manage.
- The **"Find it Nearby"** card (FR-31) only needs the dish name to construct its copy and outbound Maps query — no restaurant-level data dependency.
- If restaurant-level curation is desired in a future version, it should be scoped as a distinct, deliberate feature (with its own data model and freshness process) rather than reintroduced piecemeal.

### 8.4 Trust & correction loop
- Add a lightweight "Something wrong with this info?" report action on Dish Detail (not shown in wireframes — flag as a v1 addition given the dietary-guidance risk noted in §7.4, and now more relevant given the Dietary card's prominence).
- Reports on dietary/allergen claims should be treated as high priority and can temporarily suppress the Vegetarian/Halal badge and Dietary card affirmation pending review.

---

## 9. Non-Functional Requirements

| Category | Requirement |
|---|---|
| **Performance** | Explore screen (location-granted) should render initial content in < 2s on 4G; images lazy-loaded below the fold. |
| **Offline resilience** | Cache the last-viewed location's dish set and any Favourites items for offline viewing. |
| **Localization** | UI copy in English for v1; dish names always show Japanese script + romanization regardless of app language. |
| **Accessibility** | Pronunciation audio (FR-23) must have a text fallback; all filter chips, tab bar items, and CTAs meet standard tap-target and contrast guidelines. |
| **Privacy** | Location access is optional and clearly reversible (FR-7, FR-18); no location data retained beyond session unless the user saves content via Favourites. |
| **Deep linking** | Season + region filter state (FR-44) and individual Dish Detail pages should be deep-linkable/shareable. |

---

## 10. Open Questions & Risks

| # | Question / Risk | Why it matters |
|---|---|---|
| 1 | **Favourites and Settings tabs are named in navigation but not yet wireframed.** What does Favourites show (flat list vs. trip/itinerary grouping)? What lives in Settings (units, language, permissions, notifications)? | Both are now permanent, always-visible nav destinations; they need design before v1 can be considered complete, not just Explore/Search/Detail. |
| 2 | How is "Peak Ingredients" (FR-42) modeled — a lightweight variant of `Dishes`, or a new content type? | Affects schema and authoring workflow before Seasonal Search can ship broadly. |
| 3 | What exactly triggers "Location Unavailable" when permission *is* granted but the user is outside content coverage (e.g., outside Japan, or in a Phase-3+ region not yet published)? | Wireframe 03 conflates "permission denied" and "no data here" — these need distinct copy/handling so users in unlaunched regions aren't told to "Allow Location Access" when they already have. |
| 4 | With the restaurant list removed, does "Find on Google Maps" pass a specific, well-formed query (dish name + cuisine keyword + location) reliably enough to surface relevant results, especially for dishes with non-obvious English names? | This CTA is now the *only* path from dish to place — if the Maps query is too generic, the core conversion moment (§4 metrics) fails silently. Recommend a query-construction spec and testing per dish, not just a generic template. |
| 5 | Dietary filter legal/liability exposure — given current data is 100% "Not reviewed," and dietary info now has a dedicated, prominent card, what's the verification standard before a dish can show an affirmative Dietary/Halal/Vegetarian claim? | Higher-risk than in v1.0 given the card's visual prominence; needs a defined sign-off process before launch. |
| 6 | Multi-country expansion — does `Region` become a country-scoped concept, or does the app support one country at a time? | Impacts whether "Region" filter chips need a country switcher above them eventually. |

---

## 11. Appendix — Wireframe → Requirement Mapping

| Screen | File | Section |
|---|---|---|
| Location Permission | `01_Location_Permission.png` | §6.1 |
| Explore (Location Granted) | `02_Location_Granted.png` | §6.2 |
| Explore (Location Denied) | `03_Location_Denied.png` | §6.3 |
| Dish Detail (single scroll, w/ Read More) | `04_Card_Detail.png` | §6.4 |
| Search | `05_Search_Screen.png` | §6.5 |
| Seasonal Search | `06_Seasonal_Search_Screen.png` | §6.6 |
| Location Detail (Karuizawa) | `07_Seasonal_Search_Screen.png` | §6.7 |

**Source data file:** `japan-location-hierarchy-with-dishes.xlsx` — sheets: Overview, Regions, Prefectures, Locations, Admin Guide, Dishes, Dish Locations.

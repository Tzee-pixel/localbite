# LocalBite Design System — v2.0 (Final)

**Status:** Locked — ready to implement.
**Scope:** Visual design only. Do not modify data-fetching, navigation logic, routing, or state management. This spec governs colors, type, spacing, icons, components, and motion — nothing else.

---

## 0. Direction

LocalBite is a dish-first discovery app that has to build trust fast: a traveler standing in an unfamiliar place, deciding whether to order something they can't read. The design reads as a **warm editorial guidebook** — curated and considered, not a generic listings app.

Two things the system should never lose sight of:
- **Season is a signature visual element**, not just a filter option — it gets its own consistent color language, recurring across the app.
- **The dietary/trust cards (Verified Vegetarian, Not Yet Reviewed) are the highest-stakes UI in the product.** They use a deliberately distinct visual language from the rest of the app — see §5.3.

---

## 1. Color tokens

### 1.1 Core

| Token | Hex | Role |
|---|---|---|
| `paper` | `#FAF8F5` | App background |
| `surface` | `#FFFFFF` | Cards, search bar, nav bar — sits above `paper` |
| `ink` | `#1C1917` | Headings, primary text |
| `body` | `#44403C` | Body/paragraph text |
| `rust` | `#C2410C` | Primary accent — CTAs, links, active nav, icons, dish subtitle |
| `hairline` | `rgba(28,25,23,0.12)` | Borders, dividers |

### 1.2 Seasonal accent (signature element)

Used for: "In Peak Season" carousel, season tags/chips, Seasonal Search theming. Everything else on a seasonal card stays neutral so this color reads as a deliberate signal.

| Season | Hex |
|---|---|
| Spring | `#DB5A73` |
| Summer | `#5B8C3E` |
| Autumn | `#D9622C` |
| Winter | `#4A7C9E` |

### 1.3 Trust card system (exception palette — see §5.3)

| Token | Hex | Role |
|---|---|---|
| `trust-green-tint` | `#E4F0E1` | Dietary card background |
| `trust-green-badge` | `#3D7A41` | Dietary icon badge |
| `trust-green-headline` | `#2F6B33` | "Verified Vegetarian" text |
| `trust-green-label` | `#4B7C4F` | Uppercase label + subtext |
| `trust-indigo-tint` | `#E8ECF8` | Price card background |
| `trust-indigo-badge` | `#2E4C8C` | Price icon badge |
| `trust-indigo-label` | `#3E4E7A` | Uppercase label |
| `trust-indigo-subtext` | `#5A6B95` | Supporting text |
| `caution-tint` | `#F5E1E1` | "Not reviewed" card background |
| `caution` | `#C23B3B` | Caution badge/text |

### 1.4 Supporting

| Token | Hex | Role |
|---|---|---|
| `peach` | `#F3DFC5` | "Did You Know?" callout background |
| `gold` | `#E7A73E` | Rating star *(flagged — see §7)* |

---

## 2. Typography

| Role | Typeface | Weight | Color | Size |
|---|---|---|---|---|
| Dish name (Japanese script) | **Noto Sans JP** | 900 (Black) | `ink` | 36px |
| Dish name (English subtitle) | **Figtree** | 600 (Semibold) | `rust` | 20px |
| Section heading (H2) | **Playfair Display** | 700 (Bold) | `ink` | 22px |
| Sub-heading (H3) | **Playfair Display** | 700 (Bold) | `ink` | 18px |
| Body / paragraph | **Figtree** | 400 (Regular) | `body` | 14px |
| UI labels, nav, chips, buttons | **Figtree** | 500–600 | `ink` / `rust` | 12–13px |
| Trust card values (exception) | **IBM Plex Mono** | 500–600 | see §1.3 | 10–15px |

**Font stack summary:**
- **Noto Sans JP** — Japanese dish names only.
- **Playfair Display** — all English section/screen headings.
- **Figtree** — body copy, UI labels, buttons, dish subtitle.
- **IBM Plex Mono** — reserved exclusively for the trust card component (§5.3). Not used elsewhere.

### Name treatment (Dish Detail)
1. Japanese script (Noto Sans JP Black, 36px, `ink`)
2. English name (Figtree Semibold, 20px, `rust`)
3. "Pronounced: [romanization]" + 🔊 icon (Figtree 14px, `body`/`ink`, `rust` icon)

---

## 3. Spacing, radius, elevation

*(Unchanged from v1 — still applies.)*

### Spacing (4px base unit)
| Token | Value |
|---|---|
| `xs` | 4px |
| `sm` | 8px |
| `md` | 12px |
| `lg` | 16px |
| `xl` | 24px |
| `2xl` | 32px |
| `3xl` | 48px |

### Radius
| Token | Value | Use |
|---|---|---|
| `radius-sm` | 8px | Inputs, small controls |
| `radius-md` | 12px | Cards |
| `radius-lg` | 20px | Modals, sheets |
| `radius-full` | 999px | Chips, pills, primary CTA button |

### Elevation
| Token | Value | Use |
|---|---|---|
| `hairline` | `0.5px solid rgba(28,25,23,0.12)` | Default separator |
| `shadow-float` | `0 2px 12px rgba(28,25,23,0.08)` | Floating elements only (toasts, save confirmation) |

---

## 4. Icons

**Set: Phosphor Icons, regular weight** (icons in the reference mockups used Tabler as a stand-in for preview purposes only — Phosphor is the actual spec for the built app).

| Function | Icon |
|---|---|
| Explore / home | Compass or house |
| Search | Magnifying glass |
| Favourites | Heart / bookmark |
| Settings | Gear |
| Pronunciation | Speaker |
| Save | Bookmark (outline → filled) |
| Dietary verified | Check (in `trust-green-badge` circle) |
| Dietary caution | Info (in `caution` circle) — not a warning triangle |
| Price | Tag (in `trust-indigo-badge` circle) |
| Find on Google Maps | Map pin / arrow-right |
| Filter category dots | Small filled circle, colored per category (orange/green/rust) |

**Seasonal marks:** four custom line icons (blossom, leaf, maple leaf, snowflake) at Phosphor's stroke weight — still a TODO for a bespoke pass; acceptable to use closest library icon as placeholder during build.

---

## 5. Components

### 5.1 Buttons

| Type | Style |
|---|---|
| Primary | Solid `rust` fill, white text, **`radius-full` (pill shape)** |
| Secondary | White fill, `rust` 1.5px border, `rust` text |
| Tertiary/text | No fill/border, `rust` text, underline |
| Icon button | Circular, white bg, hairline border |

States: default → pressed (scale 97%, 100ms) → disabled (40% opacity) → loading (label fades, spinner fades in).

### 5.2 Micro-interactions
1. **Save action** — icon fill toggle with overshoot scale (1 → 1.3 → 1), ~250ms.
2. **"Read More" / "Read full historical record"** — inline text-link expand, no navigation.
3. **Filter chip select** — background/dot state fades, ~150ms, no bounce.
4. **Primary CTA press** — scale-97% + brief background darken.

### 5.3 Trust cards (Dietary + Price) — exception component

These deliberately break from the rest of the type/color system because they're the app's core trust-building moment.

- Tinted background (not white) — green for dietary, indigo for price (§1.3).
- 20px circular icon badge, solid color fill, white icon.
- Uppercase label in **IBM Plex Mono**, 10px.
- Headline value: bold, 15px, in the tint's dark variant.
- Supporting subtext: 11px, muted tint color.
- Always shown as an equal-width side-by-side pair.
- Caution variant (unreviewed dietary status) uses `caution-tint`/`caution` — same structure.

### 5.4 Standard cards (dish cards, "where to look for it," ingredient list, etc.)

- White (`surface`) background, hairline border, `radius-md`, no shadow.
- 4:3 photo crop for dish cards.
- Numbered list items (Key Ingredients): number in Playfair Display Bold `rust`, inside a hairline-bordered white card.

### 5.5 Chips

- Unselected: white fill, hairline border, small colored dot + `ink` label text.
- Dot color indicates category (not full chip fill) — orange/green/rust rotation per filter type.
- Uniform height (32px), multi-select (not radio-exclusive).

### 5.6 Nav bar

- Fixed bottom, 4 equal tabs: Explore, Search, Favourites, Settings.
- White background, hairline top border, no shadow.
- Active: `rust` icon + label. Inactive: `body`/muted icon + label.
- Hides on scroll-down / reveals on scroll-up **on Dish Detail only** (to clear space for the pinned CTA). Persistent elsewhere.

---

## 6. Build order for Antigravity

Styling-only pass on an already-functional app. Go component-by-component:

1. Centralize all tokens (§1–3) in one theme/variables file — no hardcoded hex/spacing inline.
2. Buttons, chips, nav bar (shared everywhere).
3. Standard cards (§5.4).
4. Trust card component (§5.3) — build as its own distinct, reusable component given its exception styling.
5. Apply to Dish Detail (highest-stakes screen — validate here first).
6. Apply to Explore.
7. Apply to Search / Seasonal Search.
8. Apply to Favourites / Settings.
9. Motion pass (§5.2) last.

**Guardrails:**
- Styling/theme layers only — do not touch data-fetching, routing, or state logic.
- Screenshot after each component/screen for review before moving on.
- One component category per commit, so regressions are easy to isolate.

---

## 7. Open flag

The reference screenshot includes a star rating ("4.9, 2.4k"). Your PRD (§5) explicitly lists user-generated reviews/ratings as **out of scope for v1**. Decide before build: keep as a curated/editorial rating (not user-generated), or remove entirely to stay consistent with the PRD. Not resolved in this spec — `gold` token (§1.4) is included but unused pending this decision.

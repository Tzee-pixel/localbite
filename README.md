# LocalBite 🍱

> **Hyper-Local Japanese Gastronomy & Food Discovery Mobile Application**  
> Built with **React Native (Expo SDK 57)**, **TypeScript**, and **Supabase (PostgreSQL & Object Storage)**.

---

## 🌟 Overview
LocalBite is a travel and culinary companion designed for discovering authentic, hyper-local Japanese dishes, seasonal specialties, and micro-regional food culture across Japan.

---

## 🏗 Tech Stack & Architecture

- **Frontend**: React Native with Expo SDK 57, React Navigation v7 (Tabs & Native Stacks), Phosphor Icons, Expo AV.
- **State & Data Fetching**: TanStack React Query v5 with offline fallback caching and robust mock data.
- **Backend / Database**: Supabase PostgreSQL.
- **Storage**: Supabase Storage for dish photos, location hero banners, and audio pronunciation clips.
- **Styling**: Modern design system tokens (`colors`, `typography`, `spacing`, `shadows`).

---

## 🗄 Database & Supabase Storage Setup

### 1. Database Migrations
Migrations are stored in [`supabase/migrations/`](./supabase/migrations/):
- `20260817000000_create_localbite_tables.sql`: Tables for `locations`, `dishes`, `reviews`, `user_favourites`.
- `20260823000000_get_nearby_dishes_function.sql`: Spatial query RPC `get_nearby_dishes` for GPS/distance filtering.

### 2. Seeding Initial Data
- Full SQL dump: [`supabase/seed.sql`](./supabase/seed.sql)
- Raw Master Sheet CSV: [`LocalBite_Master_Dishes.csv`](./LocalBite_Master_Dishes.csv)

### 3. Supabase Image Storage Setup
Supabase handles all image and audio assets natively:
1. Create a **Public Bucket** in Supabase Storage named `dish-images`.
2. Create a **Public Bucket** named `location-images`.
3. Set public read access policies so mobile clients can fetch images via CDN.
4. Public image URLs follow the format:
   ```text
   https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/dish-images/<filename>.jpg
   ```
5. Supabase built-in image resizing is supported by appending query parameters:
   ```text
   ?width=600&quality=80
   ```

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v18+)
- npm or yarn
- [Expo Go](https://expo.dev/client) app on iOS / Android or iOS Simulator / Android Emulator

### 1. Clone & Install
```bash
git clone <YOUR_GITHUB_REPO_URL>
cd localbite
npm install
```

### 2. Configure Environment Variables
Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```
Fill in your Supabase credentials:
```ini
EXPO_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Run the Development Server
```bash
npm start
# or
npx expo start
```
- Press `i` to open in iOS Simulator.
- Press `a` to open in Android Emulator.
- Scan QR code using the **Expo Go** mobile app.

---

## 📁 Project Structure

```text
localbite/
├── assets/                  # Local icons, splash, fallback imagery
├── src/
│   ├── components/          # Reusable UI cards, chips, badges, trust cards
│   ├── context/             # Location & app-wide state context
│   ├── lib/                 # Supabase client, queries, favourites, mockData, asset helpers
│   ├── navigation/          # React Navigation stacks & bottom tabs
│   ├── screens/             # ExploreHome, LocationDetail, DishDetail, Favourites, Profile
│   ├── theme/               # Color palettes, typography, spacing tokens
│   └── types/               # TypeScript interfaces & database schemas
├── supabase/
│   ├── migrations/          # Schema definitions and RPC functions
│   ├── seed.sql             # Complete database seed file
│   └── seed_data/           # CSV data splits
├── LocalBite_Master_Dishes.csv # Single source of truth dish database
└── package.json
```

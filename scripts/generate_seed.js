const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

function slugify(text) {
  return String(text).toLowerCase().trim().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function escapeSqlString(str) {
  if (str === null || str === undefined) return 'NULL';
  return `'${String(str).replace(/'/g, "''")}'`;
}

function formatSqlArray(arr) {
  if (!arr || !Array.isArray(arr) || arr.length === 0) return 'ARRAY[]::text[]';
  const escapedElements = arr.map(e => `'${String(e).replace(/'/g, "''")}'`);
  return `ARRAY[${escapedElements.join(', ')}]::text[]`;
}

function parseArray(val) {
  if (!val) return [];
  return String(val).split(/;|,/).map(s => s.trim()).filter(Boolean);
}

function formatCsvCell(val) {
  if (val === null || val === undefined) return '';
  if (Array.isArray(val)) val = val.join(';');
  const str = String(val);
  if (str.includes(',') || str.includes('"') || str.includes('\n')) {
    return `"${str.replace(/"/g, '""')}"`;
  }
  return str;
}

const excelPath = path.join(__dirname, '..', 'japan-location-hierarchy-with-dishes.xlsx');
const workbook = XLSX.readFile(excelPath);

// ==========================================
// 1. REGIONS
// ==========================================
const regionsSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Regions'], { header: 1 });
const regions = regionsSheet.slice(2).filter(r => r[0]).map(r => ({
  region_id: String(r[0]).trim().toLowerCase(),
  region_name: String(r[1]).trim(),
  display_order: parseInt(r[2], 10),
  food_discovery_lens: r[4] ? String(r[4]).trim() : null
}));

const regionNameToId = new Map(regions.map(r => [r.region_name.toLowerCase(), r.region_id]));

// ==========================================
// 2. PREFECTURES
// ==========================================
const prefSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Prefectures'], { header: 1 });
const prefectures = prefSheet.slice(2).filter(r => r[0]).map(r => {
  const regId = String(r[0]).trim().toLowerCase();
  const prefName = String(r[1]).trim();
  const prefId = slugify(prefName);
  return {
    prefecture_id: prefId,
    region_id: regId,
    prefecture_name: prefName,
    primary_launch_city: r[2] ? String(r[2]).trim() : null,
    suggested_phase: r[4] ? String(r[4]).trim() : null
  };
});

const prefNameToId = new Map(prefectures.map(p => [p.prefecture_name.toLowerCase(), p.prefecture_id]));

// ==========================================
// 3. LOCATIONS
// ==========================================
const locSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Locations'], { header: 1 });
const locations = locSheet.slice(2).filter(r => r[0]).map(r => {
  const locId = String(r[0]).trim().toLowerCase();
  const locName = String(r[1]).trim();
  const type = String(r[2]).trim();
  const parentLocId = r[3] ? String(r[3]).trim().toLowerCase() : null;
  const city = r[4] ? String(r[4]).trim() : null;
  const prefName = r[5] ? String(r[5]).trim() : '';
  const regName = r[6] ? String(r[6]).trim() : '';
  const phase = r[7] != null && !isNaN(parseInt(r[7], 10)) ? parseInt(r[7], 10) : null;
  const foodFocus = r[8] ? String(r[8]).trim() : null;
  const adminNote = r[9] ? String(r[9]).trim() : null;
  // Per prompt requirement §2.5: Seed with content_status = 'Draft'
  const contentStatus = 'Draft';

  const prefId = prefNameToId.get(prefName.toLowerCase()) || slugify(prefName);
  const regId = regionNameToId.get(regName.toLowerCase()) || slugify(regName);

  return {
    location_id: locId,
    location_name: locName,
    type,
    parent_location_id: parentLocId,
    city,
    prefecture_id: prefId,
    region_id: regId,
    coverage_phase: phase,
    food_focus: foodFocus,
    admin_note: adminNote,
    content_status: contentStatus
  };
});

// Parent cities that are referenced in Locations parent_location_id but not in original sheet
const missingParentCities = [
  { location_id: 'tokyo', location_name: 'Tokyo', type: 'City', city: 'Tokyo', prefecture_id: 'tokyo', region_id: 'kanto', coverage_phase: 1, food_focus: 'Capital dining, sushi, tempura, ramen, and street markets', admin_note: 'Parent city for Tokyo neighborhoods', content_status: 'Draft' },
  { location_id: 'yokohama', location_name: 'Yokohama', type: 'City', city: 'Yokohama', prefecture_id: 'kanagawa', region_id: 'kanto', coverage_phase: 3, food_focus: 'Port city dining and Chinatown specialties', admin_note: 'Parent city for Yokohama Chinatown', content_status: 'Draft' },
  { location_id: 'kyoto-city', location_name: 'Kyoto City', type: 'City', city: 'Kyoto', prefecture_id: 'kyoto', region_id: 'kansai', coverage_phase: 1, food_focus: 'Traditional kaiseki, obanzai, yudofu, and matcha', admin_note: 'Parent city for Kyoto districts', content_status: 'Draft' },
  { location_id: 'osaka-city', location_name: 'Osaka City', type: 'City', city: 'Osaka', prefecture_id: 'osaka', region_id: 'kansai', coverage_phase: 1, food_focus: 'Kuidaore food capital, takoyaki, okonomiyaki, kushikatsu', admin_note: 'Parent city for Osaka districts', content_status: 'Draft' },
  { location_id: 'kobe', location_name: 'Kobe', type: 'City', city: 'Kobe', prefecture_id: 'hyogo', region_id: 'kansai', coverage_phase: 3, food_focus: 'Kobe beef, port dining, and western bakery culture', admin_note: 'Parent city for Kobe districts', content_status: 'Draft' },
  { location_id: 'fukuoka-city', location_name: 'Fukuoka City', type: 'City', city: 'Fukuoka', prefecture_id: 'fukuoka', region_id: 'kyushu-okinawa', coverage_phase: 1, food_focus: 'Hakata ramen, yatai food stalls, and seafood', admin_note: 'Parent city for Hakata and Nakasu', content_status: 'Draft' },
  { location_id: 'nagasaki-city', location_name: 'Nagasaki City', type: 'City', city: 'Nagasaki', prefecture_id: 'nagasaki', region_id: 'kyushu-okinawa', coverage_phase: 3, food_focus: 'Champon, sara udon, and castella cake', admin_note: 'Parent city for Nagasaki Chinatown', content_status: 'Draft' }
];

const existingLocIds = new Set(locations.map(l => l.location_id));
for (const pCity of missingParentCities) {
  if (!existingLocIds.has(pCity.location_id)) {
    locations.unshift(pCity);
    existingLocIds.add(pCity.location_id);
  }
}

// ==========================================
// 4. DISHES
// ==========================================
const dishSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Dishes'], { header: 1 });
const dishes = dishSheet.slice(2).filter(r => r[0]).map(r => {
  const dishId = String(r[0]).trim().toLowerCase();
  const dishName = String(r[1]).trim();
  const japaneseName = String(r[2]).trim();
  const regName = r[3] ? String(r[3]).trim() : '';
  const prefName = r[4] ? String(r[4]).trim() : '';
  const summary = String(r[5] || '').trim();
  const seasons = parseArray(r[6]);
  const tags = parseArray(r[7]);
  const dietaryGuidance = r[8] ? String(r[8]).trim() : null;
  const priceMin = r[9] != null && !isNaN(parseInt(r[9], 10)) ? parseInt(r[9], 10) : null;
  const priceMax = r[10] != null && !isNaN(parseInt(r[10], 10)) ? parseInt(r[10], 10) : null;
  // Per prompt requirement §2.5: Seed with content_status = 'Draft'
  const contentStatus = 'Draft';
  const homeFilterTags = parseArray(r[12]);
  const vegStatus = r[13] ? String(r[13]).trim() : 'Not reviewed';
  const halalStatus = r[14] ? String(r[14]).trim() : 'Not reviewed';

  const regId = regionNameToId.get(regName.toLowerCase()) || slugify(regName);
  const prefId = prefNameToId.get(prefName.toLowerCase()) || slugify(prefName);

  return {
    dish_id: dishId,
    dish_name: dishName,
    japanese_name: japaneseName,
    region_id: regId,
    primary_prefecture_id: prefId,
    summary,
    seasons,
    tags,
    dietary_guidance: dietaryGuidance,
    price_min: priceMin,
    price_max: priceMax,
    content_status: contentStatus,
    home_filter_tags: homeFilterTags,
    vegetarian_status: vegStatus,
    halal_status: halalStatus,
    featured: false,
    origin_history_preview: null,
    origin_history_full: null,
    did_you_know: null,
    key_ingredients: null,
    pronunciation_phonetic: null,
    pronunciation_audio_url: null
  };
});

// ==========================================
// 5. DISH LOCATIONS
// ==========================================
const dlSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Dish Locations'], { header: 1 });
const dishLocations = dlSheet.slice(2).filter(r => r[0]).map(r => {
  const dishId = String(r[0]).trim().toLowerCase();
  const locId = String(r[1]).trim().toLowerCase();
  const relationship = String(r[2] || '').trim();
  const displayPriority = parseInt(r[3], 10) || 1;
  const editorialNote = r[4] ? String(r[4]).trim() : null;
  const linkStatus = r[5] ? String(r[5]).trim() : 'Planned';

  return {
    dish_id: dishId,
    location_id: locId,
    relationship,
    display_priority: displayPriority,
    editorial_note: editorialNote,
    link_status: linkStatus
  };
});

// ==========================================
// WRITE SEED SQL
// ==========================================
const sqlLines = [];
sqlLines.push('-- ==========================================');
sqlLines.push('-- LocalBite Seed Data');
sqlLines.push('-- Generated from japan-location-hierarchy-with-dishes.xlsx');
sqlLines.push('-- ==========================================\n');

sqlLines.push('TRUNCATE TABLE dish_locations, dishes, locations, prefectures, regions CASCADE;\n');

// Insert Regions
sqlLines.push('-- Insert Regions');
regions.forEach(r => {
  sqlLines.push(`INSERT INTO regions (region_id, region_name, display_order, food_discovery_lens) VALUES (${escapeSqlString(r.region_id)}, ${escapeSqlString(r.region_name)}, ${r.display_order}, ${escapeSqlString(r.food_discovery_lens)});`);
});
sqlLines.push('');

// Insert Prefectures
sqlLines.push('-- Insert Prefectures');
prefectures.forEach(p => {
  sqlLines.push(`INSERT INTO prefectures (prefecture_id, region_id, prefecture_name, primary_launch_city, suggested_phase) VALUES (${escapeSqlString(p.prefecture_id)}, ${escapeSqlString(p.region_id)}, ${escapeSqlString(p.prefecture_name)}, ${escapeSqlString(p.primary_launch_city)}, ${escapeSqlString(p.suggested_phase)});`);
});
sqlLines.push('');

// Insert Locations
sqlLines.push('-- Insert Locations');
locations.forEach(l => {
  const phaseVal = l.coverage_phase != null ? l.coverage_phase : 'NULL';
  sqlLines.push(`INSERT INTO locations (location_id, location_name, type, parent_location_id, city, prefecture_id, region_id, coverage_phase, food_focus, admin_note, content_status) VALUES (${escapeSqlString(l.location_id)}, ${escapeSqlString(l.location_name)}, ${escapeSqlString(l.type)}, ${escapeSqlString(l.parent_location_id)}, ${escapeSqlString(l.city)}, ${escapeSqlString(l.prefecture_id)}, ${escapeSqlString(l.region_id)}, ${phaseVal}, ${escapeSqlString(l.food_focus)}, ${escapeSqlString(l.admin_note)}, ${escapeSqlString(l.content_status)});`);
});
sqlLines.push('');

// Insert Dishes
sqlLines.push('-- Insert Dishes');
dishes.forEach(d => {
  const minVal = d.price_min != null ? d.price_min : 'NULL';
  const maxVal = d.price_max != null ? d.price_max : 'NULL';
  sqlLines.push(`INSERT INTO dishes (dish_id, dish_name, japanese_name, region_id, primary_prefecture_id, summary, seasons, tags, dietary_guidance, price_min, price_max, content_status, home_filter_tags, vegetarian_status, halal_status, featured, origin_history_preview, origin_history_full, did_you_know, key_ingredients, pronunciation_phonetic, pronunciation_audio_url) VALUES (${escapeSqlString(d.dish_id)}, ${escapeSqlString(d.dish_name)}, ${escapeSqlString(d.japanese_name)}, ${escapeSqlString(d.region_id)}, ${escapeSqlString(d.primary_prefecture_id)}, ${escapeSqlString(d.summary)}, ${formatSqlArray(d.seasons)}, ${formatSqlArray(d.tags)}, ${escapeSqlString(d.dietary_guidance)}, ${minVal}, ${maxVal}, ${escapeSqlString(d.content_status)}, ${formatSqlArray(d.home_filter_tags)}, ${escapeSqlString(d.vegetarian_status)}, ${escapeSqlString(d.halal_status)}, ${d.featured ? 'TRUE' : 'FALSE'}, NULL, NULL, NULL, NULL, NULL, NULL);`);
});
sqlLines.push('');

// Insert Dish Locations
sqlLines.push('-- Insert Dish Locations');
dishLocations.forEach(dl => {
  sqlLines.push(`INSERT INTO dish_locations (dish_id, location_id, relationship, display_priority, editorial_note, link_status) VALUES (${escapeSqlString(dl.dish_id)}, ${escapeSqlString(dl.location_id)}, ${escapeSqlString(dl.relationship)}, ${dl.display_priority}, ${escapeSqlString(dl.editorial_note)}, ${escapeSqlString(dl.link_status)});`);
});
sqlLines.push('');

const supabaseDir = path.join(__dirname, '..', 'supabase');
if (!fs.existsSync(supabaseDir)) fs.mkdirSync(supabaseDir);

fs.writeFileSync(path.join(supabaseDir, 'seed.sql'), sqlLines.join('\n'), 'utf8');

// ==========================================
// WRITE CSV FILES
// ==========================================
const seedDataDir = path.join(supabaseDir, 'seed_data');
if (!fs.existsSync(seedDataDir)) fs.mkdirSync(seedDataDir);

// 1. regions.csv
const regionsCsv = [
  'region_id,region_name,display_order,food_discovery_lens',
  ...regions.map(r => `${formatCsvCell(r.region_id)},${formatCsvCell(r.region_name)},${r.display_order},${formatCsvCell(r.food_discovery_lens)}`)
].join('\n');
fs.writeFileSync(path.join(seedDataDir, 'regions.csv'), regionsCsv, 'utf8');

// 2. prefectures.csv
const prefCsv = [
  'prefecture_id,region_id,prefecture_name,primary_launch_city,suggested_phase',
  ...prefectures.map(p => `${formatCsvCell(p.prefecture_id)},${formatCsvCell(p.region_id)},${formatCsvCell(p.prefecture_name)},${formatCsvCell(p.primary_launch_city)},${formatCsvCell(p.suggested_phase)}`)
].join('\n');
fs.writeFileSync(path.join(seedDataDir, 'prefectures.csv'), prefCsv, 'utf8');

// 3. locations.csv
const locCsv = [
  'location_id,location_name,type,parent_location_id,city,prefecture_id,region_id,coverage_phase,food_focus,admin_note,content_status',
  ...locations.map(l => `${formatCsvCell(l.location_id)},${formatCsvCell(l.location_name)},${formatCsvCell(l.type)},${formatCsvCell(l.parent_location_id)},${formatCsvCell(l.city)},${formatCsvCell(l.prefecture_id)},${formatCsvCell(l.region_id)},${formatCsvCell(l.coverage_phase)},${formatCsvCell(l.food_focus)},${formatCsvCell(l.admin_note)},${formatCsvCell(l.content_status)}`)
].join('\n');
fs.writeFileSync(path.join(seedDataDir, 'locations.csv'), locCsv, 'utf8');

// 4. dishes.csv
const dishesCsv = [
  'dish_id,dish_name,japanese_name,region_id,primary_prefecture_id,summary,seasons,tags,dietary_guidance,price_min,price_max,content_status,home_filter_tags,vegetarian_status,halal_status,featured,origin_history_preview,origin_history_full,did_you_know,key_ingredients,pronunciation_phonetic,pronunciation_audio_url',
  ...dishes.map(d => `${formatCsvCell(d.dish_id)},${formatCsvCell(d.dish_name)},${formatCsvCell(d.japanese_name)},${formatCsvCell(d.region_id)},${formatCsvCell(d.primary_prefecture_id)},${formatCsvCell(d.summary)},${formatCsvCell(d.seasons)},${formatCsvCell(d.tags)},${formatCsvCell(d.dietary_guidance)},${formatCsvCell(d.price_min)},${formatCsvCell(d.price_max)},${formatCsvCell(d.content_status)},${formatCsvCell(d.home_filter_tags)},${formatCsvCell(d.vegetarian_status)},${formatCsvCell(d.halal_status)},${d.featured},,,,,`)
].join('\n');
fs.writeFileSync(path.join(seedDataDir, 'dishes.csv'), dishesCsv, 'utf8');

// 5. dish_locations.csv
const dlCsv = [
  'dish_id,location_id,relationship,display_priority,editorial_note,link_status',
  ...dishLocations.map(dl => `${formatCsvCell(dl.dish_id)},${formatCsvCell(dl.location_id)},${formatCsvCell(dl.relationship)},${dl.display_priority},${formatCsvCell(dl.editorial_note)},${formatCsvCell(dl.link_status)}`)
].join('\n');
fs.writeFileSync(path.join(seedDataDir, 'dish_locations.csv'), dlCsv, 'utf8');

console.log('✅ Generated supabase/seed.sql and supabase/seed_data/ CSV files!');
console.log(`Counts: ${regions.length} regions, ${prefectures.length} prefectures, ${locations.length} locations (${locations.length - 7} from sheet + 7 parent cities), ${dishes.length} dishes, ${dishLocations.length} dish_locations.`);

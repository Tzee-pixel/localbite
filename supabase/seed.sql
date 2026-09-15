-- LocalBite Seed Data
-- Master dataset for Regions, Prefectures, Locations, Dishes, and Dish_Locations

-- 1. REGIONS
INSERT INTO regions (region_id, region_name, display_order, food_discovery_lens) VALUES
('hokkaido', 'Hokkaido', 1, NULL),
('tohoku', 'Tohoku', 2, NULL),
('kanto', 'Kanto', 3, NULL),
('chubu', 'Chubu', 4, NULL),
('kansai', 'Kansai', 5, NULL),
('chugoku', 'Chugoku', 6, NULL),
('shikoku', 'Shikoku', 7, NULL),
('kyuushuu', 'Kyuushuu', 8, NULL),
('kyushu', 'Kyushu', 9, NULL),
('okinawa', 'Okinawa', 10, NULL)
ON CONFLICT (region_id) DO UPDATE SET region_name = EXCLUDED.region_name, display_order = EXCLUDED.display_order;

-- 2. PREFECTURES
INSERT INTO prefectures (prefecture_id, region_id, prefecture_name, primary_launch_city, suggested_phase) VALUES
('hokkaido', 'hokkaido', 'Hokkaido', 'Hokkaido City', '1'),
('aomori', 'tohoku', 'Aomori', 'Aomori City', '1'),
('iwate', 'tohoku', 'Iwate', 'Iwate City', '1'),
('miyagi', 'tohoku', 'Miyagi', 'Miyagi City', '1'),
('akita', 'tohoku', 'Akita', 'Akita City', '1'),
('yamagata', 'tohoku', 'Yamagata', 'Yamagata City', '1'),
('fukushima', 'tohoku', 'Fukushima', 'Fukushima City', '1'),
('ibaraki', 'kanto', 'Ibaraki', 'Ibaraki City', '1'),
('tochigi', 'kanto', 'Tochigi', 'Tochigi City', '1'),
('gunma', 'kanto', 'Gunma', 'Gunma City', '1'),
('saitama', 'kanto', 'Saitama', 'Saitama City', '1'),
('chiba', 'kanto', 'Chiba', 'Chiba City', '1'),
('tokyo', 'kanto', 'Tokyo', 'Tokyo City', '1'),
('kanagawa', 'kanto', 'Kanagawa', 'Kanagawa City', '1'),
('niigata', 'chubu', 'Niigata', 'Niigata City', '1'),
('toyama', 'chubu', 'Toyama', 'Toyama City', '1'),
('ishikawa', 'chubu', 'Ishikawa', 'Ishikawa City', '1'),
('fukui', 'chubu', 'Fukui', 'Fukui City', '1'),
('yamanashi', 'chubu', 'Yamanashi', 'Yamanashi City', '1'),
('nagano', 'chubu', 'Nagano', 'Nagano City', '1'),
('gifu', 'chubu', 'Gifu', 'Gifu City', '1'),
('shizuoka', 'chubu', 'Shizuoka', 'Shizuoka City', '1'),
('aichi', 'chubu', 'Aichi', 'Aichi City', '1'),
('mie', 'kansai', 'Mie', 'Mie City', '1'),
('shiga', 'kansai', 'Shiga', 'Shiga City', '1'),
('kyoto', 'kansai', 'Kyoto', 'Kyoto City', '1'),
('osaka', 'kansai', 'Osaka', 'Osaka City', '1'),
('hyogo', 'kansai', 'Hyogo', 'Hyogo City', '1'),
('nara', 'kansai', 'Nara', 'Nara City', '1'),
('wakayama', 'kansai', 'Wakayama', 'Wakayama City', '1'),
('tottori', 'chugoku', 'Tottori', 'Tottori City', '1'),
('shimane', 'chugoku', 'Shimane', 'Shimane City', '1'),
('okayama', 'chugoku', 'Okayama', 'Okayama City', '1'),
('hiroshima', 'chugoku', 'Hiroshima', 'Hiroshima City', '1'),
('yamaguchi', 'chugoku', 'Yamaguchi', 'Yamaguchi City', '1'),
('tokushima', 'shikoku', 'Tokushima', 'Tokushima City', '1'),
('kagawa', 'shikoku', 'Kagawa', 'Kagawa City', '1'),
('ehime', 'shikoku', 'Ehime', 'Ehime City', '1'),
('kochi', 'shikoku', 'Kochi', 'Kochi City', '1'),
('fukuoka', 'kyuushuu', 'Fukuoka', 'Fukuoka City', '1'),
('saga', 'kyuushuu', 'Saga', 'Saga City', '1'),
('nagasaki', 'kyuushuu', 'Nagasaki', 'Nagasaki City', '1'),
('kumamoto', 'kyuushuu', 'Kumamoto', 'Kumamoto City', '1'),
('oita', 'kyuushuu', 'Oita', 'Oita City', '1'),
('miyazaki', 'kyuushuu', 'Miyazaki', 'Miyazaki City', '1'),
('kagoshima', 'kyuushuu', 'Kagoshima', 'Kagoshima City', '1'),
('okinawa', 'kyuushuu', 'Okinawa', 'Okinawa City', '1')
ON CONFLICT (prefecture_id) DO UPDATE SET region_id = EXCLUDED.region_id, prefecture_name = EXCLUDED.prefecture_name;

-- 3. LOCATIONS
INSERT INTO locations (location_id, location_name, type, parent_location_id, city, prefecture_id, region_id, coverage_phase, food_focus, admin_note, content_status) VALUES
('aibetsu-town', 'Aibetsu Town', 'Town', NULL, 'Aibetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('akaigawa-village', 'Akaigawa Village', 'City', NULL, 'Akaigawa Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('akabira-city', 'Akabira City', 'City', NULL, 'Akabira City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('asahikawa-city', 'Asahikawa City', 'City', NULL, 'Asahikawa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ashibetsu-city', 'Ashibetsu City', 'City', NULL, 'Ashibetsu City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ashoro-town', 'Ashoro Town', 'Town', NULL, 'Ashoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('akkeshi-town', 'Akkeshi Town', 'Town', NULL, 'Akkeshi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('assabu-town', 'Assabu Town', 'Town', NULL, 'Assabu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('atsuma-town', 'Atsuma Town', 'Town', NULL, 'Atsuma Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('abashiri-city', 'Abashiri City', 'City', NULL, 'Abashiri City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('abira-town', 'Abira Town', 'Town', NULL, 'Abira Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ikeda-town', 'Ikeda Town', 'Town', NULL, 'Ikeda Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ishikari-city', 'Ishikari City', 'City', NULL, 'Ishikari City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('imakane-town', 'Imakane Town', 'Town', NULL, 'Imakane Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('iwanai-town', 'Iwanai Town', 'Town', NULL, 'Iwanai Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('iwamizawa-city', 'Iwamizawa City', 'City', NULL, 'Iwamizawa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('utashinai-city', 'Utashinai City', 'City', NULL, 'Utashinai City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('urausu-town', 'Urausu Town', 'Town', NULL, 'Urausu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('urakawa-town', 'Urakawa Town', 'Town', NULL, 'Urakawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('urahoro-town', 'Urahoro Town', 'Town', NULL, 'Urahoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('uryu-town', 'Uryu Town', 'Town', NULL, 'Uryu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('esashi-town', 'Esashi Town', 'Town', NULL, 'Esashi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('eniwa-city', 'Eniwa City', 'City', NULL, 'Eniwa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ebetsu-city', 'Ebetsu City', 'City', NULL, 'Ebetsu City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('erimo-town', 'Erimo Town', 'Town', NULL, 'Erimo Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('engaru-town', 'Engaru Town', 'Town', NULL, 'Engaru Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('embetsu-town', 'Embetsu Town', 'Town', NULL, 'Embetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('oumu-town', 'Oumu Town', 'Town', NULL, 'Oumu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ozora-town', 'Ozora Town', 'Town', NULL, 'Ozora Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('okushiri-town', 'Okushiri Town', 'Town', NULL, 'Okushiri Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('oketo-town', 'Oketo Town', 'Town', NULL, 'Oketo Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('okoppe-town', 'Okoppe Town', 'Town', NULL, 'Okoppe Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('oshamambe-town', 'Oshamambe Town', 'Town', NULL, 'Oshamambe Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('otaru-city', 'Otaru City', 'City', NULL, 'Otaru City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('otoineppu-village', 'Otoineppu Village', 'City', NULL, 'Otoineppu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('otofuke-town', 'Otofuke Town', 'Town', NULL, 'Otofuke Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('otobe-town', 'Otobe Town', 'Town', NULL, 'Otobe Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('obihiro-city', 'Obihiro City', 'City', NULL, 'Obihiro City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('obira-town', 'Obira Town', 'Town', NULL, 'Obira Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kamikawa-town', 'Kamikawa Town', 'Town', NULL, 'Kamikawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kamishihoro-town', 'Kamishihoro Town', 'Town', NULL, 'Kamishihoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kamisunagawa-town', 'Kamisunagawa Town', 'Town', NULL, 'Kamisunagawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kaminokuni-town', 'Kaminokuni Town', 'Town', NULL, 'Kaminokuni Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kamifurano-town', 'Kamifurano Town', 'Town', NULL, 'Kamifurano Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kamoenai-village', 'Kamoenai Village', 'City', NULL, 'Kamoenai Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kikonai-town', 'Kikonai Town', 'Town', NULL, 'Kikonai Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kitahiroshima-city', 'Kitahiroshima City', 'City', NULL, 'Kitahiroshima City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kitami-city', 'Kitami City', 'City', NULL, 'Kitami City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kimobetsu-town', 'Kimobetsu Town', 'Town', NULL, 'Kimobetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kyogoku-town', 'Kyogoku Town', 'Town', NULL, 'Kyogoku Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kyowa-town', 'Kyowa Town', 'Town', NULL, 'Kyowa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kiyosato-town', 'Kiyosato Town', 'Town', NULL, 'Kiyosato Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kushiro-city', 'Kushiro City', 'City', NULL, 'Kushiro City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kushiro-town', 'Kushiro Town', 'Town', NULL, 'Kushiro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kutchan-town', 'Kutchan Town', 'Town', NULL, 'Kutchan Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kuriyama-town', 'Kuriyama Town', 'Town', NULL, 'Kuriyama Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kuromatsunai-town', 'Kuromatsunai Town', 'Town', NULL, 'Kuromatsunai Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kunneppu-town', 'Kunneppu Town', 'Town', NULL, 'Kunneppu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('kembuchi-town', 'Kembuchi Town', 'Town', NULL, 'Kembuchi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('koshimizu-town', 'Koshimizu Town', 'Town', NULL, 'Koshimizu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('sapporo-city', 'Sapporo City', 'City', NULL, 'Sapporo City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('samani-town', 'Samani Town', 'Town', NULL, 'Samani Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('sarabetsu-village', 'Sarabetsu Village', 'City', NULL, 'Sarabetsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('sarufutsu-village', 'Sarufutsu Village', 'City', NULL, 'Sarufutsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('saroma-town', 'Saroma Town', 'Town', NULL, 'Saroma Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shikaoi-town', 'Shikaoi Town', 'Town', NULL, 'Shikaoi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shikabe-town', 'Shikabe Town', 'Town', NULL, 'Shikabe Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shikotan-village', 'Shikotan Village', 'City', NULL, 'Shikotan Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shibecha-town', 'Shibecha Town', 'Town', NULL, 'Shibecha Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shibetsu-city', 'Shibetsu City', 'City', NULL, 'Shibetsu City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shibetsu-town', 'Shibetsu Town', 'Town', NULL, 'Shibetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shibetoro-village', 'Shibetoro Village', 'City', NULL, 'Shibetoro Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shihoro-town', 'Shihoro Town', 'Town', NULL, 'Shihoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shimamaki-village', 'Shimamaki Village', 'City', NULL, 'Shimamaki Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shimizu-town', 'Shimizu Town', 'Town', NULL, 'Shimizu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shimukappu-village', 'Shimukappu Village', 'City', NULL, 'Shimukappu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shimokawa-town', 'Shimokawa Town', 'Town', NULL, 'Shimokawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shakotan-town', 'Shakotan Town', 'Town', NULL, 'Shakotan Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shana-village', 'Shana Village', 'City', NULL, 'Shana Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shari-town', 'Shari Town', 'Town', NULL, 'Shari Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shosanbetsu-village', 'Shosanbetsu Village', 'City', NULL, 'Shosanbetsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shiraoi-town', 'Shiraoi Town', 'Town', NULL, 'Shiraoi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shiranuka-town', 'Shiranuka Town', 'Town', NULL, 'Shiranuka Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shiriuchi-town', 'Shiriuchi Town', 'Town', NULL, 'Shiriuchi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shinshinotsu-village', 'Shinshinotsu Village', 'City', NULL, 'Shinshinotsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shintoku-town', 'Shintoku Town', 'Town', NULL, 'Shintoku Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shintotsukawa-town', 'Shintotsukawa Town', 'Town', NULL, 'Shintotsukawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('shinhidaka-town', 'Shinhidaka Town', 'Town', NULL, 'Shinhidaka Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('suttsu-town', 'Suttsu Town', 'Town', NULL, 'Suttsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('sunagawa-city', 'Sunagawa City', 'City', NULL, 'Sunagawa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('setana-town', 'Setana Town', 'Town', NULL, 'Setana Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('sobetsu-town', 'Sobetsu Town', 'Town', NULL, 'Sobetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('taiki-town', 'Taiki Town', 'Town', NULL, 'Taiki Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('takasu-town', 'Takasu Town', 'Town', NULL, 'Takasu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('takikawa-city', 'Takikawa City', 'City', NULL, 'Takikawa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('takinoue-town', 'Takinoue Town', 'Town', NULL, 'Takinoue Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('date-city', 'Date City', 'City', NULL, 'Date City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('chippubetsu-town', 'Chippubetsu Town', 'Town', NULL, 'Chippubetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('chitose-city', 'Chitose City', 'City', NULL, 'Chitose City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tsukigata-town', 'Tsukigata Town', 'Town', NULL, 'Tsukigata Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tsubetsu-town', 'Tsubetsu Town', 'Town', NULL, 'Tsubetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tsurui-village', 'Tsurui Village', 'City', NULL, 'Tsurui Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('teshio-town', 'Teshio Town', 'Town', NULL, 'Teshio Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('teshikaga-town', 'Teshikaga Town', 'Town', NULL, 'Teshikaga Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tobetsu-town', 'Tobetsu Town', 'Town', NULL, 'Tobetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tohma-town', 'Tohma Town', 'Town', NULL, 'Tohma Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('toyako-town', 'Toyako Town', 'Town', NULL, 'Toyako Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tomakomai-city', 'Tomakomai City', 'City', NULL, 'Tomakomai City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tomamae-town', 'Tomamae Town', 'Town', NULL, 'Tomamae Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tomari-village', 'Tomari Village', 'City', NULL, 'Tomari Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('tomari-village-kunashir-island', 'Tomari Village (Kunashir Island)', 'City', NULL, 'Tomari Village (Kunashir Island)', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('toyoura-town', 'Toyoura Town', 'Town', NULL, 'Toyoura Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('toyokoro-town', 'Toyokoro Town', 'Town', NULL, 'Toyokoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('toyotomi-town', 'Toyotomi Town', 'Town', NULL, 'Toyotomi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('naie-town', 'Naie Town', 'Town', NULL, 'Naie Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nakagawa-town', 'Nakagawa Town', 'Town', NULL, 'Nakagawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nakasatsunai-village', 'Nakasatsunai Village', 'City', NULL, 'Nakasatsunai Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nakashibetsu-town', 'Nakashibetsu Town', 'Town', NULL, 'Nakashibetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nakatombetsu-town', 'Nakatombetsu Town', 'Town', NULL, 'Nakatombetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('naganuma-town', 'Naganuma Town', 'Town', NULL, 'Naganuma Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nakafurano-town', 'Nakafurano Town', 'Town', NULL, 'Nakafurano Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nanae-town', 'Nanae Town', 'Town', NULL, 'Nanae Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nayoro-city', 'Nayoro City', 'City', NULL, 'Nayoro City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nanporo-town', 'Nanporo Town', 'Town', NULL, 'Nanporo Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('niikappu-town', 'Niikappu Town', 'Town', NULL, 'Niikappu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('niki-town', 'Niki Town', 'Town', NULL, 'Niki Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nishiokoppe-village', 'Nishiokoppe Village', 'City', NULL, 'Nishiokoppe Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('niseko-town', 'Niseko Town', 'Town', NULL, 'Niseko Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('numata-town', 'Numata Town', 'Town', NULL, 'Numata Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('nemuro-city', 'Nemuro City', 'City', NULL, 'Nemuro City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('noboribetsu-city', 'Noboribetsu City', 'City', NULL, 'Noboribetsu City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hakodate-city', 'Hakodate City', 'City', NULL, 'Hakodate City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('haboro-town', 'Haboro Town', 'Town', NULL, 'Haboro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hamatonbetsu-town', 'Hamatonbetsu Town', 'Town', NULL, 'Hamatonbetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hamanaka-town', 'Hamanaka Town', 'Town', NULL, 'Hamanaka Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('biei-town', 'Biei Town', 'Town', NULL, 'Biei Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('higashikagura-town', 'Higashikagura Town', 'Town', NULL, 'Higashikagura Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('higashikawa-town', 'Higashikawa Town', 'Town', NULL, 'Higashikawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hidaka-town', 'Hidaka Town', 'Town', NULL, 'Hidaka Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('pippu-town', 'Pippu Town', 'Town', NULL, 'Pippu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('bibai-city', 'Bibai City', 'City', NULL, 'Bibai City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('bifuka-town', 'Bifuka Town', 'Town', NULL, 'Bifuka Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('bihoro-town', 'Bihoro Town', 'Town', NULL, 'Bihoro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('biratori-town', 'Biratori Town', 'Town', NULL, 'Biratori Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hiroo-town', 'Hiroo Town', 'Town', NULL, 'Hiroo Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('fukagawa-city', 'Fukagawa City', 'City', NULL, 'Fukagawa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('fukushima-town', 'Fukushima Town', 'Town', NULL, 'Fukushima Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('furano-city', 'Furano City', 'City', NULL, 'Furano City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('furubira-town', 'Furubira Town', 'Town', NULL, 'Furubira Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('betsukai-town', 'Betsukai Town', 'Town', NULL, 'Betsukai Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hokuto-city', 'Hokuto City', 'City', NULL, 'Hokuto City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('hokuryu-town', 'Hokuryu Town', 'Town', NULL, 'Hokuryu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('horokanai-town', 'Horokanai Town', 'Town', NULL, 'Horokanai Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('horonobe-town', 'Horonobe Town', 'Town', NULL, 'Horonobe Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('honbetsu-town', 'Honbetsu Town', 'Town', NULL, 'Honbetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('makubetsu-town', 'Makubetsu Town', 'Town', NULL, 'Makubetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('mashike-town', 'Mashike Town', 'Town', NULL, 'Mashike Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('makkari-village', 'Makkari Village', 'City', NULL, 'Makkari Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('matsumae-town', 'Matsumae Town', 'Town', NULL, 'Matsumae Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('mikasa-city', 'Mikasa City', 'City', NULL, 'Mikasa City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('minamifurano-town', 'Minamifurano Town', 'Town', NULL, 'Minamifurano Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('mukawa-town', 'Mukawa Town', 'Town', NULL, 'Mukawa Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('muroran-city', 'Muroran City', 'City', NULL, 'Muroran City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('memuro-town', 'Memuro Town', 'Town', NULL, 'Memuro Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('moseushi-town', 'Moseushi Town', 'Town', NULL, 'Moseushi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('mori-town', 'Mori Town', 'Town', NULL, 'Mori Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('mombetsu-city', 'Mombetsu City', 'City', NULL, 'Mombetsu City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('yakumo-town', 'Yakumo Town', 'Town', NULL, 'Yakumo Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('yubari-city', 'Yubari City', 'City', NULL, 'Yubari City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('yubetsu-town', 'Yubetsu Town', 'Town', NULL, 'Yubetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('yuni-town', 'Yuni Town', 'Town', NULL, 'Yuni Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('yoichi-town', 'Yoichi Town', 'Town', NULL, 'Yoichi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rausu-town', 'Rausu Town', 'Town', NULL, 'Rausu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rankoshi-town', 'Rankoshi Town', 'Town', NULL, 'Rankoshi Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rikubetsu-town', 'Rikubetsu Town', 'Town', NULL, 'Rikubetsu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rishiri-town', 'Rishiri Town', 'Town', NULL, 'Rishiri Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rishirifuji-town', 'Rishirifuji Town', 'Town', NULL, 'Rishirifuji Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rusutsu-village', 'Rusutsu Village', 'City', NULL, 'Rusutsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rubetsu-village', 'Rubetsu Village', 'City', NULL, 'Rubetsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rumoi-city', 'Rumoi City', 'City', NULL, 'Rumoi City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('ruyobetsu-village', 'Ruyobetsu Village', 'City', NULL, 'Ruyobetsu Village', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('rebun-town', 'Rebun Town', 'Town', NULL, 'Rebun Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('wakkanai-city', 'Wakkanai City', 'City', NULL, 'Wakkanai City', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('wassamu-town', 'Wassamu Town', 'Town', NULL, 'Wassamu Town', 'hokkaido', 'hokkaido', 1, NULL, NULL, 'Published'),
('aomori-city', 'Aomori City', 'City', NULL, 'Aomori City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('ajigasawa-town', 'Ajigasawa Town', 'Town', NULL, 'Ajigasawa Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('itayanagi-town', 'Itayanagi Town', 'Town', NULL, 'Itayanagi Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('inakadate-village', 'Inakadate Village', 'City', NULL, 'Inakadate Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('imabetsu-town', 'Imabetsu Town', 'Town', NULL, 'Imabetsu Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('oirase-town', 'Oirase Town', 'Town', NULL, 'Oirase Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('oma-town', 'Oma Town', 'Town', NULL, 'Oma Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('owani-town', 'Owani Town', 'Town', NULL, 'Owani Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('kazamaura-village', 'Kazamaura Village', 'City', NULL, 'Kazamaura Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('kuroishi-city', 'Kuroishi City', 'City', NULL, 'Kuroishi City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('goshogawara-city', 'Goshogawara City', 'City', NULL, 'Goshogawara City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('gonohe-town', 'Gonohe Town', 'Town', NULL, 'Gonohe Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('sai-village', 'Sai Village', 'City', NULL, 'Sai Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('sannohe-town', 'Sannohe Town', 'Town', NULL, 'Sannohe Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('shichinohe-town', 'Shichinohe Town', 'Town', NULL, 'Shichinohe Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('shingo-village', 'Shingo Village', 'City', NULL, 'Shingo Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('sotogahama-town', 'Sotogahama Town', 'Town', NULL, 'Sotogahama Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('takko-town', 'Takko Town', 'Town', NULL, 'Takko Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('tsugaru-city', 'Tsugaru City', 'City', NULL, 'Tsugaru City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('tsuruta-town', 'Tsuruta Town', 'Town', NULL, 'Tsuruta Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('tohoku-town', 'Tohoku Town', 'Town', NULL, 'Tohoku Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('towada-city', 'Towada City', 'City', NULL, 'Towada City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('nakadomari-town', 'Nakadomari Town', 'Town', NULL, 'Nakadomari Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('nanbu-town', 'Nanbu Town', 'Town', NULL, 'Nanbu Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('nishimeya-village', 'Nishimeya Village', 'City', NULL, 'Nishimeya Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('noheji-town', 'Noheji Town', 'Town', NULL, 'Noheji Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('hashikami-town', 'Hashikami Town', 'Town', NULL, 'Hashikami Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('hachinohe-city', 'Hachinohe City', 'City', NULL, 'Hachinohe City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('higashidori-village', 'Higashidori Village', 'City', NULL, 'Higashidori Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('hirakawa-city', 'Hirakawa City', 'City', NULL, 'Hirakawa City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('hiranai-town', 'Hiranai Town', 'Town', NULL, 'Hiranai Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('hirosaki-city', 'Hirosaki City', 'City', NULL, 'Hirosaki City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('fukaura-town', 'Fukaura Town', 'Town', NULL, 'Fukaura Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('fujisaki-town', 'Fujisaki Town', 'Town', NULL, 'Fujisaki Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('misawa-city', 'Misawa City', 'City', NULL, 'Misawa City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('mutsu-city', 'Mutsu City', 'City', NULL, 'Mutsu City', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('yokohama-town', 'Yokohama Town', 'Town', NULL, 'Yokohama Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('yomogita-village', 'Yomogita Village', 'City', NULL, 'Yomogita Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('rokunohe-town', 'Rokunohe Town', 'Town', NULL, 'Rokunohe Town', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('rokkasho-village', 'Rokkasho Village', 'City', NULL, 'Rokkasho Village', 'aomori', 'tohoku', 1, NULL, NULL, 'Published'),
('ichinoseki-city', 'Ichinoseki City', 'City', NULL, 'Ichinoseki City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('ichinohe-town', 'Ichinohe Town', 'Town', NULL, 'Ichinohe Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('iwaizumi-town', 'Iwaizumi Town', 'Town', NULL, 'Iwaizumi Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('iwate-town', 'Iwate Town', 'Town', NULL, 'Iwate Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('oshu-city', 'Oshu City', 'City', NULL, 'Oshu City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('otsuchi-town', 'Otsuchi Town', 'Town', NULL, 'Otsuchi Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('ofunato-city', 'Ofunato City', 'City', NULL, 'Ofunato City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kanegasaki-town', 'Kanegasaki Town', 'Town', NULL, 'Kanegasaki Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kamaishi-city', 'Kamaishi City', 'City', NULL, 'Kamaishi City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('karumai-town', 'Karumai Town', 'Town', NULL, 'Karumai Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kitakami-city', 'Kitakami City', 'City', NULL, 'Kitakami City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kuji-city', 'Kuji City', 'City', NULL, 'Kuji City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kuzumaki-town', 'Kuzumaki Town', 'Town', NULL, 'Kuzumaki Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('kunohe-village', 'Kunohe Village', 'City', NULL, 'Kunohe Village', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('shizukuishi-town', 'Shizukuishi Town', 'Town', NULL, 'Shizukuishi Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('shiwa-town', 'Shiwa Town', 'Town', NULL, 'Shiwa Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('sumita-town', 'Sumita Town', 'Town', NULL, 'Sumita Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('takizawa-city', 'Takizawa City', 'City', NULL, 'Takizawa City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('tanohata-village', 'Tanohata Village', 'City', NULL, 'Tanohata Village', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('tono-city', 'Tono City', 'City', NULL, 'Tono City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('nishiwaga-town', 'Nishiwaga Town', 'Town', NULL, 'Nishiwaga Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('ninohe-city', 'Ninohe City', 'City', NULL, 'Ninohe City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('noda-village', 'Noda Village', 'City', NULL, 'Noda Village', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('hachimantai-city', 'Hachimantai City', 'City', NULL, 'Hachimantai City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('hanamaki-city', 'Hanamaki City', 'City', NULL, 'Hanamaki City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('hiraizumi-town', 'Hiraizumi Town', 'Town', NULL, 'Hiraizumi Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('hirono-town', 'Hirono Town', 'Town', NULL, 'Hirono Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('fudai-village', 'Fudai Village', 'City', NULL, 'Fudai Village', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('miyako-city', 'Miyako City', 'City', NULL, 'Miyako City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('morioka-city', 'Morioka City', 'City', NULL, 'Morioka City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('yahaba-town', 'Yahaba Town', 'Town', NULL, 'Yahaba Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('yamada-town', 'Yamada Town', 'Town', NULL, 'Yamada Town', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('rikuzentakata-city', 'Rikuzentakata City', 'City', NULL, 'Rikuzentakata City', 'iwate', 'tohoku', 1, NULL, NULL, 'Published'),
('ishinomaki-city', 'Ishinomaki City', 'City', NULL, 'Ishinomaki City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('iwanuma-city', 'Iwanuma City', 'City', NULL, 'Iwanuma City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('ogawara-town', 'Ogawara Town', 'Town', NULL, 'Ogawara Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('osaki-city', 'Osaki City', 'City', NULL, 'Osaki City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('osato-town', 'Osato Town', 'Town', NULL, 'Osato Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('ohira-village', 'Ohira Village', 'City', NULL, 'Ohira Village', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('onagawa-town', 'Onagawa Town', 'Town', NULL, 'Onagawa Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('kakuda-city', 'Kakuda City', 'City', NULL, 'Kakuda City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('kami-town', 'Kami Town', 'Town', NULL, 'Kami Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('kawasaki-town', 'Kawasaki Town', 'Town', NULL, 'Kawasaki Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('kurihara-city', 'Kurihara City', 'City', NULL, 'Kurihara City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('kesennuma-city', 'Kesennuma City', 'City', NULL, 'Kesennuma City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('zao-town', 'Zao Town', 'Town', NULL, 'Zao Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shiogama-city', 'Shiogama City', 'City', NULL, 'Shiogama City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shikama-town', 'Shikama Town', 'Town', NULL, 'Shikama Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shichikashuku-town', 'Shichikashuku Town', 'Town', NULL, 'Shichikashuku Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shichigahama-town', 'Shichigahama Town', 'Town', NULL, 'Shichigahama Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shibata-town', 'Shibata Town', 'Town', NULL, 'Shibata Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('shiroishi-city', 'Shiroishi City', 'City', NULL, 'Shiroishi City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('sendai-city', 'Sendai City', 'City', NULL, 'Sendai City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('taiwa-town', 'Taiwa Town', 'Town', NULL, 'Taiwa Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('tagajo-city', 'Tagajo City', 'City', NULL, 'Tagajo City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('tomiya-city', 'Tomiya City', 'City', NULL, 'Tomiya City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('tome-city', 'Tome City', 'City', NULL, 'Tome City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('natori-city', 'Natori City', 'City', NULL, 'Natori City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('higashimatsushima-city', 'Higashimatsushima City', 'City', NULL, 'Higashimatsushima City', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('matsushima-town', 'Matsushima Town', 'Town', NULL, 'Matsushima Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('marumori-town', 'Marumori Town', 'Town', NULL, 'Marumori Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('misato-town', 'Misato Town', 'Town', NULL, 'Misato Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('minamisanriku-town', 'Minamisanriku Town', 'Town', NULL, 'Minamisanriku Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('murata-town', 'Murata Town', 'Town', NULL, 'Murata Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('yamamoto-town', 'Yamamoto Town', 'Town', NULL, 'Yamamoto Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('rifu-town', 'Rifu Town', 'Town', NULL, 'Rifu Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('wakuya-town', 'Wakuya Town', 'Town', NULL, 'Wakuya Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('watari-town', 'Watari Town', 'Town', NULL, 'Watari Town', 'miyagi', 'tohoku', 1, NULL, NULL, 'Published'),
('akita-city', 'Akita City', 'City', NULL, 'Akita City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('ikawa-town', 'Ikawa Town', 'Town', NULL, 'Ikawa Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('ugo-town', 'Ugo Town', 'Town', NULL, 'Ugo Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('ogata-village', 'Ogata Village', 'City', NULL, 'Ogata Village', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('odate-city', 'Odate City', 'City', NULL, 'Odate City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('oga-city', 'Oga City', 'City', NULL, 'Oga City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('katagami-city', 'Katagami City', 'City', NULL, 'Katagami City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('kazuno-city', 'Kazuno City', 'City', NULL, 'Kazuno City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('kamikoani-village', 'Kamikoani Village', 'City', NULL, 'Kamikoani Village', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('kitaakita-city', 'Kitaakita City', 'City', NULL, 'Kitaakita City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('kosaka-town', 'Kosaka Town', 'Town', NULL, 'Kosaka Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('gojome-town', 'Gojome Town', 'Town', NULL, 'Gojome Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('semboku-city', 'Semboku City', 'City', NULL, 'Semboku City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('daisen-city', 'Daisen City', 'City', NULL, 'Daisen City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('nikaho-city', 'Nikaho City', 'City', NULL, 'Nikaho City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('noshiro-city', 'Noshiro City', 'City', NULL, 'Noshiro City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('hachirogata-town', 'Hachirogata Town', 'Town', NULL, 'Hachirogata Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('happo-town', 'Happo Town', 'Town', NULL, 'Happo Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('higashinaruse-village', 'Higashinaruse Village', 'City', NULL, 'Higashinaruse Village', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('fujisato-town', 'Fujisato Town', 'Town', NULL, 'Fujisato Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('mitane-town', 'Mitane Town', 'Town', NULL, 'Mitane Town', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('yuzawa-city', 'Yuzawa City', 'City', NULL, 'Yuzawa City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('yurihonjo-city', 'Yurihonjo City', 'City', NULL, 'Yurihonjo City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('yokote-city', 'Yokote City', 'City', NULL, 'Yokote City', 'akita', 'tohoku', 1, NULL, NULL, 'Published'),
('asahi-town', 'Asahi Town', 'Town', NULL, 'Asahi Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('iide-town', 'Iide Town', 'Town', NULL, 'Iide Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('oishida-town', 'Oishida Town', 'Town', NULL, 'Oishida Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('oe-town', 'Oe Town', 'Town', NULL, 'Oe Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('okura-village', 'Okura Village', 'City', NULL, 'Okura Village', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('oguni-town', 'Oguni Town', 'Town', NULL, 'Oguni Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('obanazawa-city', 'Obanazawa City', 'City', NULL, 'Obanazawa City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('kaneyama-town', 'Kaneyama Town', 'Town', NULL, 'Kaneyama Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('kahoku-town', 'Kahoku Town', 'Town', NULL, 'Kahoku Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('kaminoyama-city', 'Kaminoyama City', 'City', NULL, 'Kaminoyama City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('kawanishi-town', 'Kawanishi Town', 'Town', NULL, 'Kawanishi Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('sagae-city', 'Sagae City', 'City', NULL, 'Sagae City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('sakata-city', 'Sakata City', 'City', NULL, 'Sakata City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('sakegawa-village', 'Sakegawa Village', 'City', NULL, 'Sakegawa Village', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('shonai-town', 'Shonai Town', 'Town', NULL, 'Shonai Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('shirataka-town', 'Shirataka Town', 'Town', NULL, 'Shirataka Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('shinjo-city', 'Shinjo City', 'City', NULL, 'Shinjo City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('takahata-town', 'Takahata Town', 'Town', NULL, 'Takahata Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('tsuruoka-city', 'Tsuruoka City', 'City', NULL, 'Tsuruoka City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('tendo-city', 'Tendo City', 'City', NULL, 'Tendo City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('tozawa-village', 'Tozawa Village', 'City', NULL, 'Tozawa Village', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('nagai-city', 'Nagai City', 'City', NULL, 'Nagai City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('nakayama-town', 'Nakayama Town', 'Town', NULL, 'Nakayama Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('nanyo-city', 'Nanyo City', 'City', NULL, 'Nanyo City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('nishikawa-town', 'Nishikawa Town', 'Town', NULL, 'Nishikawa Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('higashine-city', 'Higashine City', 'City', NULL, 'Higashine City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('funagata-town', 'Funagata Town', 'Town', NULL, 'Funagata Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('mamurogawa-town', 'Mamurogawa Town', 'Town', NULL, 'Mamurogawa Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('mikawa-town', 'Mikawa Town', 'Town', NULL, 'Mikawa Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('murayama-city', 'Murayama City', 'City', NULL, 'Murayama City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('mogami-town', 'Mogami Town', 'Town', NULL, 'Mogami Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('yamagata-city', 'Yamagata City', 'City', NULL, 'Yamagata City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('yamanobe-town', 'Yamanobe Town', 'Town', NULL, 'Yamanobe Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('yuza-town', 'Yuza Town', 'Town', NULL, 'Yuza Town', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('yonezawa-city', 'Yonezawa City', 'City', NULL, 'Yonezawa City', 'yamagata', 'tohoku', 1, NULL, NULL, 'Published'),
('aizubange-town', 'Aizubange Town', 'Town', NULL, 'Aizubange Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('aizumisato-town', 'Aizumisato Town', 'Town', NULL, 'Aizumisato Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('aizuwakamatsu-city', 'Aizuwakamatsu City', 'City', NULL, 'Aizuwakamatsu City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('asakawa-town', 'Asakawa Town', 'Town', NULL, 'Asakawa Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('iitate-village', 'Iitate Village', 'City', NULL, 'Iitate Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('ishikawa-town', 'Ishikawa Town', 'Town', NULL, 'Ishikawa Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('izumizaki-village', 'Izumizaki Village', 'City', NULL, 'Izumizaki Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('inawashiro-town', 'Inawashiro Town', 'Town', NULL, 'Inawashiro Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('iwaki-city', 'Iwaki City', 'City', NULL, 'Iwaki City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('okuma-town', 'Okuma Town', 'Town', NULL, 'Okuma Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('otama-village', 'Otama Village', 'City', NULL, 'Otama Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('ono-town', 'Ono Town', 'Town', NULL, 'Ono Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kagamiishi-town', 'Kagamiishi Town', 'Town', NULL, 'Kagamiishi Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('katsurao-village', 'Katsurao Village', 'City', NULL, 'Katsurao Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kawauchi-village', 'Kawauchi Village', 'City', NULL, 'Kawauchi Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kawamata-town', 'Kawamata Town', 'Town', NULL, 'Kawamata Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kitakata-city', 'Kitakata City', 'City', NULL, 'Kitakata City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kitashiobara-village', 'Kitashiobara Village', 'City', NULL, 'Kitashiobara Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('kunimi-town', 'Kunimi Town', 'Town', NULL, 'Kunimi Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('koori-town', 'Koori Town', 'Town', NULL, 'Koori Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('koriyama-city', 'Koriyama City', 'City', NULL, 'Koriyama City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('samegawa-village', 'Samegawa Village', 'City', NULL, 'Samegawa Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('shimogo-town', 'Shimogo Town', 'Town', NULL, 'Shimogo Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('showa-village', 'Showa Village', 'City', NULL, 'Showa Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('shirakawa-city', 'Shirakawa City', 'City', NULL, 'Shirakawa City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('shinchi-town', 'Shinchi Town', 'Town', NULL, 'Shinchi Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('sukagawa-city', 'Sukagawa City', 'City', NULL, 'Sukagawa City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('soma-city', 'Soma City', 'City', NULL, 'Soma City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tadami-town', 'Tadami Town', 'Town', NULL, 'Tadami Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tanagura-town', 'Tanagura Town', 'Town', NULL, 'Tanagura Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tamakawa-village', 'Tamakawa Village', 'City', NULL, 'Tamakawa Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tamura-city', 'Tamura City', 'City', NULL, 'Tamura City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tenei-village', 'Tenei Village', 'City', NULL, 'Tenei Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('tomioka-town', 'Tomioka Town', 'Town', NULL, 'Tomioka Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('nakajima-village', 'Nakajima Village', 'City', NULL, 'Nakajima Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('namie-town', 'Namie Town', 'Town', NULL, 'Namie Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('naraha-town', 'Naraha Town', 'Town', NULL, 'Naraha Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('nishiaizu-town', 'Nishiaizu Town', 'Town', NULL, 'Nishiaizu Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('nishigo-village', 'Nishigo Village', 'City', NULL, 'Nishigo Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('nihonmatsu-city', 'Nihonmatsu City', 'City', NULL, 'Nihonmatsu City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('hanawa-town', 'Hanawa Town', 'Town', NULL, 'Hanawa Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('bandai-town', 'Bandai Town', 'Town', NULL, 'Bandai Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('hinoemata-village', 'Hinoemata Village', 'City', NULL, 'Hinoemata Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('hirata-village', 'Hirata Village', 'City', NULL, 'Hirata Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('fukushima-city', 'Fukushima City', 'City', NULL, 'Fukushima City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('futaba-town', 'Futaba Town', 'Town', NULL, 'Futaba Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('furudono-town', 'Furudono Town', 'Town', NULL, 'Furudono Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('mishima-town', 'Mishima Town', 'Town', NULL, 'Mishima Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('minamiaizu-town', 'Minamiaizu Town', 'Town', NULL, 'Minamiaizu Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('minamisoma-city', 'Minamisoma City', 'City', NULL, 'Minamisoma City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('miharu-town', 'Miharu Town', 'Town', NULL, 'Miharu Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('motomiya-city', 'Motomiya City', 'City', NULL, 'Motomiya City', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('yanaizu-town', 'Yanaizu Town', 'Town', NULL, 'Yanaizu Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('yabuki-town', 'Yabuki Town', 'Town', NULL, 'Yabuki Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('yamatsuri-town', 'Yamatsuri Town', 'Town', NULL, 'Yamatsuri Town', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('yugawa-village', 'Yugawa Village', 'City', NULL, 'Yugawa Village', 'fukushima', 'tohoku', 1, NULL, NULL, 'Published'),
('ami-town', 'Ami Town', 'Town', NULL, 'Ami Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('ishioka-city', 'Ishioka City', 'City', NULL, 'Ishioka City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('itako-city', 'Itako City', 'City', NULL, 'Itako City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('inashiki-city', 'Inashiki City', 'City', NULL, 'Inashiki City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('ibaraki-town', 'Ibaraki Town', 'Town', NULL, 'Ibaraki Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('ushiku-city', 'Ushiku City', 'City', NULL, 'Ushiku City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('oarai-town', 'Oarai Town', 'Town', NULL, 'Oarai Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('omitama-city', 'Omitama City', 'City', NULL, 'Omitama City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kasama-city', 'Kasama City', 'City', NULL, 'Kasama City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kashima-city', 'Kashima City', 'City', NULL, 'Kashima City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kasumigaura-city', 'Kasumigaura City', 'City', NULL, 'Kasumigaura City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kamisu-city', 'Kamisu City', 'City', NULL, 'Kamisu City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kawachi-town', 'Kawachi Town', 'Town', NULL, 'Kawachi Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('kitaibaraki-city', 'Kitaibaraki City', 'City', NULL, 'Kitaibaraki City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('koga-city', 'Koga City', 'City', NULL, 'Koga City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('goka-town', 'Goka Town', 'Town', NULL, 'Goka Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('sakai-town', 'Sakai Town', 'Town', NULL, 'Sakai Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('sakuragawa-city', 'Sakuragawa City', 'City', NULL, 'Sakuragawa City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('shimotsuma-city', 'Shimotsuma City', 'City', NULL, 'Shimotsuma City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('joso-city', 'Joso City', 'City', NULL, 'Joso City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('shirosato-town', 'Shirosato Town', 'Town', NULL, 'Shirosato Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('daigo-town', 'Daigo Town', 'Town', NULL, 'Daigo Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('takahagi-city', 'Takahagi City', 'City', NULL, 'Takahagi City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('chikusei-city', 'Chikusei City', 'City', NULL, 'Chikusei City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('tsukuba-city', 'Tsukuba City', 'City', NULL, 'Tsukuba City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('tsukubamirai-city', 'Tsukubamirai City', 'City', NULL, 'Tsukubamirai City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('tsuchiura-city', 'Tsuchiura City', 'City', NULL, 'Tsuchiura City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('tokai-village', 'Tokai Village', 'City', NULL, 'Tokai Village', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('tone-town', 'Tone Town', 'Town', NULL, 'Tone Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('toride-city', 'Toride City', 'City', NULL, 'Toride City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('naka-city', 'Naka City', 'City', NULL, 'Naka City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('namegata-city', 'Namegata City', 'City', NULL, 'Namegata City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('bando-city', 'Bando City', 'City', NULL, 'Bando City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('hitachiota-city', 'Hitachiota City', 'City', NULL, 'Hitachiota City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('hitachiomiya-city', 'Hitachiomiya City', 'City', NULL, 'Hitachiomiya City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('hitachi-city', 'Hitachi City', 'City', NULL, 'Hitachi City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('hitachinaka-city', 'Hitachinaka City', 'City', NULL, 'Hitachinaka City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('hokota-city', 'Hokota City', 'City', NULL, 'Hokota City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('mito-city', 'Mito City', 'City', NULL, 'Mito City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('miho-village', 'Miho Village', 'City', NULL, 'Miho Village', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('moriya-city', 'Moriya City', 'City', NULL, 'Moriya City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('yachiyo-town', 'Yachiyo Town', 'Town', NULL, 'Yachiyo Town', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('yuki-city', 'Yuki City', 'City', NULL, 'Yuki City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('ryugasaki-city', 'Ryugasaki City', 'City', NULL, 'Ryugasaki City', 'ibaraki', 'kanto', 1, NULL, NULL, 'Published'),
('ashikaga-city', 'Ashikaga City', 'City', NULL, 'Ashikaga City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('ichikai-town', 'Ichikai Town', 'Town', NULL, 'Ichikai Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('utsunomiya-city', 'Utsunomiya City', 'City', NULL, 'Utsunomiya City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('otawara-city', 'Otawara City', 'City', NULL, 'Otawara City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('oyama-city', 'Oyama City', 'City', NULL, 'Oyama City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('kanuma-city', 'Kanuma City', 'City', NULL, 'Kanuma City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('kaminokawa-town', 'Kaminokawa Town', 'Town', NULL, 'Kaminokawa Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('sakura-city', 'Sakura City', 'City', NULL, 'Sakura City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('sano-city', 'Sano City', 'City', NULL, 'Sano City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('shioya-town', 'Shioya Town', 'Town', NULL, 'Shioya Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('shimotsuke-city', 'Shimotsuke City', 'City', NULL, 'Shimotsuke City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('takanezawa-town', 'Takanezawa Town', 'Town', NULL, 'Takanezawa Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('tochigi-city', 'Tochigi City', 'City', NULL, 'Tochigi City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('nasukarasuyama-city', 'Nasukarasuyama City', 'City', NULL, 'Nasukarasuyama City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('nasushiobara-city', 'Nasushiobara City', 'City', NULL, 'Nasushiobara City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('nasu-town', 'Nasu Town', 'Town', NULL, 'Nasu Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('nikko-city', 'Nikko City', 'City', NULL, 'Nikko City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('nogi-town', 'Nogi Town', 'Town', NULL, 'Nogi Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('haga-town', 'Haga Town', 'Town', NULL, 'Haga Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('mashiko-town', 'Mashiko Town', 'Town', NULL, 'Mashiko Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('mibu-town', 'Mibu Town', 'Town', NULL, 'Mibu Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('moka-city', 'Moka City', 'City', NULL, 'Moka City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('motegi-town', 'Motegi Town', 'Town', NULL, 'Motegi Town', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('yaita-city', 'Yaita City', 'City', NULL, 'Yaita City', 'tochigi', 'kanto', 1, NULL, NULL, 'Published'),
('annaka-city', 'Annaka City', 'City', NULL, 'Annaka City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('isesaki-city', 'Isesaki City', 'City', NULL, 'Isesaki City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('itakura-town', 'Itakura Town', 'Town', NULL, 'Itakura Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('ueno-village', 'Ueno Village', 'City', NULL, 'Ueno Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('ora-town', 'Ora Town', 'Town', NULL, 'Ora Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('oizumi-town', 'Oizumi Town', 'Town', NULL, 'Oizumi Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('ota-city', 'Ota City', 'City', NULL, 'Ota City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('katashina-village', 'Katashina Village', 'City', NULL, 'Katashina Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('kawaba-village', 'Kawaba Village', 'City', NULL, 'Kawaba Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('kanna-town', 'Kanna Town', 'Town', NULL, 'Kanna Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('kanra-town', 'Kanra Town', 'Town', NULL, 'Kanra Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('kiryu-city', 'Kiryu City', 'City', NULL, 'Kiryu City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('kusatsu-town', 'Kusatsu Town', 'Town', NULL, 'Kusatsu Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('shibukawa-city', 'Shibukawa City', 'City', NULL, 'Shibukawa City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('shimonita-town', 'Shimonita Town', 'Town', NULL, 'Shimonita Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('shinto-village', 'Shinto Village', 'City', NULL, 'Shinto Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('takasaki-city', 'Takasaki City', 'City', NULL, 'Takasaki City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('takayama-village', 'Takayama Village', 'City', NULL, 'Takayama Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('tatebayashi-city', 'Tatebayashi City', 'City', NULL, 'Tatebayashi City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('tamamura-town', 'Tamamura Town', 'Town', NULL, 'Tamamura Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('chiyoda-town', 'Chiyoda Town', 'Town', NULL, 'Chiyoda Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('tsumagoi-village', 'Tsumagoi Village', 'City', NULL, 'Tsumagoi Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('tomioka-city', 'Tomioka City', 'City', NULL, 'Tomioka City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('nakanojo-town', 'Nakanojo Town', 'Town', NULL, 'Nakanojo Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('naganohara-town', 'Naganohara Town', 'Town', NULL, 'Naganohara Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('nanmoku-village', 'Nanmoku Village', 'City', NULL, 'Nanmoku Village', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('numata-city', 'Numata City', 'City', NULL, 'Numata City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('higashiagatsuma-town', 'Higashiagatsuma Town', 'Town', NULL, 'Higashiagatsuma Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('fujioka-city', 'Fujioka City', 'City', NULL, 'Fujioka City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('maebashi-city', 'Maebashi City', 'City', NULL, 'Maebashi City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('midori-city', 'Midori City', 'City', NULL, 'Midori City', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('minakami-town', 'Minakami Town', 'Town', NULL, 'Minakami Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('meiwa-town', 'Meiwa Town', 'Town', NULL, 'Meiwa Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('yoshioka-town', 'Yoshioka Town', 'Town', NULL, 'Yoshioka Town', 'gunma', 'kanto', 1, NULL, NULL, 'Published'),
('ageo-city', 'Ageo City', 'City', NULL, 'Ageo City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('asaka-city', 'Asaka City', 'City', NULL, 'Asaka City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('ina-town', 'Ina Town', 'Town', NULL, 'Ina Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('iruma-city', 'Iruma City', 'City', NULL, 'Iruma City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('ogano-town', 'Ogano Town', 'Town', NULL, 'Ogano Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('ogawa-town', 'Ogawa Town', 'Town', NULL, 'Ogawa Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('okegawa-city', 'Okegawa City', 'City', NULL, 'Okegawa City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('ogose-town', 'Ogose Town', 'Town', NULL, 'Ogose Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kasukabe-city', 'Kasukabe City', 'City', NULL, 'Kasukabe City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kazo-city', 'Kazo City', 'City', NULL, 'Kazo City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kamisato-town', 'Kamisato Town', 'Town', NULL, 'Kamisato Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kawaguchi-city', 'Kawaguchi City', 'City', NULL, 'Kawaguchi City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kawagoe-city', 'Kawagoe City', 'City', NULL, 'Kawagoe City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kawajima-town', 'Kawajima Town', 'Town', NULL, 'Kawajima Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kitamoto-city', 'Kitamoto City', 'City', NULL, 'Kitamoto City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('gyoda-city', 'Gyoda City', 'City', NULL, 'Gyoda City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kuki-city', 'Kuki City', 'City', NULL, 'Kuki City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('kumagaya-city', 'Kumagaya City', 'City', NULL, 'Kumagaya City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('konosu-city', 'Konosu City', 'City', NULL, 'Konosu City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('koshigaya-city', 'Koshigaya City', 'City', NULL, 'Koshigaya City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('saitama-city', 'Saitama City', 'City', NULL, 'Saitama City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('sakado-city', 'Sakado City', 'City', NULL, 'Sakado City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('satte-city', 'Satte City', 'City', NULL, 'Satte City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('sayama-city', 'Sayama City', 'City', NULL, 'Sayama City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('shiki-city', 'Shiki City', 'City', NULL, 'Shiki City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('shiraoka-city', 'Shiraoka City', 'City', NULL, 'Shiraoka City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('sugito-town', 'Sugito Town', 'Town', NULL, 'Sugito Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('soka-city', 'Soka City', 'City', NULL, 'Soka City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('chichibu-city', 'Chichibu City', 'City', NULL, 'Chichibu City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('tsurugashima-city', 'Tsurugashima City', 'City', NULL, 'Tsurugashima City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('tokigawa-town', 'Tokigawa Town', 'Town', NULL, 'Tokigawa Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('tokorozawa-city', 'Tokorozawa City', 'City', NULL, 'Tokorozawa City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('toda-city', 'Toda City', 'City', NULL, 'Toda City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('nagatoro-town', 'Nagatoro Town', 'Town', NULL, 'Nagatoro Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('namegawa-town', 'Namegawa Town', 'Town', NULL, 'Namegawa Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('niiza-city', 'Niiza City', 'City', NULL, 'Niiza City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('hasuda-city', 'Hasuda City', 'City', NULL, 'Hasuda City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('hatoyama-town', 'Hatoyama Town', 'Town', NULL, 'Hatoyama Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('hanyu-city', 'Hanyu City', 'City', NULL, 'Hanyu City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('hanno-city', 'Hanno City', 'City', NULL, 'Hanno City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('higashichichibu-village', 'Higashichichibu Village', 'City', NULL, 'Higashichichibu Village', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('higashimatsuyama-city', 'Higashimatsuyama City', 'City', NULL, 'Higashimatsuyama City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('hidaka-city', 'Hidaka City', 'City', NULL, 'Hidaka City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('fukaya-city', 'Fukaya City', 'City', NULL, 'Fukaya City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('fujimi-city', 'Fujimi City', 'City', NULL, 'Fujimi City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('fujimino-city', 'Fujimino City', 'City', NULL, 'Fujimino City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('honjo-city', 'Honjo City', 'City', NULL, 'Honjo City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('matsubushi-town', 'Matsubushi Town', 'Town', NULL, 'Matsubushi Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('misato-city', 'Misato City', 'City', NULL, 'Misato City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('minano-town', 'Minano Town', 'Town', NULL, 'Minano Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('miyashiro-town', 'Miyashiro Town', 'Town', NULL, 'Miyashiro Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('miyoshi-town', 'Miyoshi Town', 'Town', NULL, 'Miyoshi Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('moroyama-town', 'Moroyama Town', 'Town', NULL, 'Moroyama Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('yashio-city', 'Yashio City', 'City', NULL, 'Yashio City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('yokoze-town', 'Yokoze Town', 'Town', NULL, 'Yokoze Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('yoshikawa-city', 'Yoshikawa City', 'City', NULL, 'Yoshikawa City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('yoshimi-town', 'Yoshimi Town', 'Town', NULL, 'Yoshimi Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('yorii-town', 'Yorii Town', 'Town', NULL, 'Yorii Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('ranzan-town', 'Ranzan Town', 'Town', NULL, 'Ranzan Town', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('wako-city', 'Wako City', 'City', NULL, 'Wako City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('warabi-city', 'Warabi City', 'City', NULL, 'Warabi City', 'saitama', 'kanto', 1, NULL, NULL, 'Published'),
('asahi-city', 'Asahi City', 'City', NULL, 'Asahi City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('abiko-city', 'Abiko City', 'City', NULL, 'Abiko City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('isumi-city', 'Isumi City', 'City', NULL, 'Isumi City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('ichikawa-city', 'Ichikawa City', 'City', NULL, 'Ichikawa City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('ichinomiya-town', 'Ichinomiya Town', 'Town', NULL, 'Ichinomiya Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('ichihara-city', 'Ichihara City', 'City', NULL, 'Ichihara City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('inzai-city', 'Inzai City', 'City', NULL, 'Inzai City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('urayasu-city', 'Urayasu City', 'City', NULL, 'Urayasu City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('oamishirasato-city', 'Oamishirasato City', 'City', NULL, 'Oamishirasato City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('otaki-town', 'Otaki Town', 'Town', NULL, 'Otaki Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('onjuku-town', 'Onjuku Town', 'Town', NULL, 'Onjuku Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kashiwa-city', 'Kashiwa City', 'City', NULL, 'Kashiwa City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('katsuura-city', 'Katsuura City', 'City', NULL, 'Katsuura City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('katori-city', 'Katori City', 'City', NULL, 'Katori City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kamagaya-city', 'Kamagaya City', 'City', NULL, 'Kamagaya City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kamogawa-city', 'Kamogawa City', 'City', NULL, 'Kamogawa City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kisarazu-city', 'Kisarazu City', 'City', NULL, 'Kisarazu City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kimitsu-city', 'Kimitsu City', 'City', NULL, 'Kimitsu City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kyonan-town', 'Kyonan Town', 'Town', NULL, 'Kyonan Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kujukuri-town', 'Kujukuri Town', 'Town', NULL, 'Kujukuri Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('kozaki-town', 'Kozaki Town', 'Town', NULL, 'Kozaki Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('sakae-town', 'Sakae Town', 'Town', NULL, 'Sakae Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('sammu-city', 'Sammu City', 'City', NULL, 'Sammu City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('shisui-town', 'Shisui Town', 'Town', NULL, 'Shisui Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('shibayama-town', 'Shibayama Town', 'Town', NULL, 'Shibayama Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('shirako-town', 'Shirako Town', 'Town', NULL, 'Shirako Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('shiroi-city', 'Shiroi City', 'City', NULL, 'Shiroi City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('sosa-city', 'Sosa City', 'City', NULL, 'Sosa City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('sodegaura-city', 'Sodegaura City', 'City', NULL, 'Sodegaura City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('tako-town', 'Tako Town', 'Town', NULL, 'Tako Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('tateyama-city', 'Tateyama City', 'City', NULL, 'Tateyama City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('chiba-city', 'Chiba City', 'City', NULL, 'Chiba City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('choshi-city', 'Choshi City', 'City', NULL, 'Choshi City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('chosei-village', 'Chosei Village', 'City', NULL, 'Chosei Village', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('chonan-town', 'Chonan Town', 'Town', NULL, 'Chonan Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('togane-city', 'Togane City', 'City', NULL, 'Togane City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('tonosho-town', 'Tonosho Town', 'Town', NULL, 'Tonosho Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('tomisato-city', 'Tomisato City', 'City', NULL, 'Tomisato City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('nagara-town', 'Nagara Town', 'Town', NULL, 'Nagara Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('nagareyama-city', 'Nagareyama City', 'City', NULL, 'Nagareyama City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('narashino-city', 'Narashino City', 'City', NULL, 'Narashino City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('narita-city', 'Narita City', 'City', NULL, 'Narita City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('noda-city', 'Noda City', 'City', NULL, 'Noda City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('futtsu-city', 'Futtsu City', 'City', NULL, 'Futtsu City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('funabashi-city', 'Funabashi City', 'City', NULL, 'Funabashi City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('matsudo-city', 'Matsudo City', 'City', NULL, 'Matsudo City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('minamiboso-city', 'Minamiboso City', 'City', NULL, 'Minamiboso City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('mutsuzawa-town', 'Mutsuzawa Town', 'Town', NULL, 'Mutsuzawa Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('mobara-city', 'Mobara City', 'City', NULL, 'Mobara City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('yachimata-city', 'Yachimata City', 'City', NULL, 'Yachimata City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('yachiyo-city', 'Yachiyo City', 'City', NULL, 'Yachiyo City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('yokoshibahikari-town', 'Yokoshibahikari Town', 'Town', NULL, 'Yokoshibahikari Town', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('yotsukaido-city', 'Yotsukaido City', 'City', NULL, 'Yotsukaido City', 'chiba', 'kanto', 1, NULL, NULL, 'Published'),
('aikawa-town', 'Aikawa Town', 'Town', NULL, 'Aikawa Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('atsugi-city', 'Atsugi City', 'City', NULL, 'Atsugi City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('ayase-city', 'Ayase City', 'City', NULL, 'Ayase City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('isehara-city', 'Isehara City', 'City', NULL, 'Isehara City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('ebina-city', 'Ebina City', 'City', NULL, 'Ebina City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('oiso-town', 'Oiso Town', 'Town', NULL, 'Oiso Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('oi-town', 'Oi Town', 'Town', NULL, 'Oi Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('odawara-city', 'Odawara City', 'City', NULL, 'Odawara City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('kaisei-town', 'Kaisei Town', 'Town', NULL, 'Kaisei Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('kamakura-city', 'Kamakura City', 'City', NULL, 'Kamakura City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('kawasaki-city', 'Kawasaki City', 'City', NULL, 'Kawasaki City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('kiyokawa-village', 'Kiyokawa Village', 'City', NULL, 'Kiyokawa Village', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('sagamihara-city', 'Sagamihara City', 'City', NULL, 'Sagamihara City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('zama-city', 'Zama City', 'City', NULL, 'Zama City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('samukawa-town', 'Samukawa Town', 'Town', NULL, 'Samukawa Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('zushi-city', 'Zushi City', 'City', NULL, 'Zushi City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('chigasaki-city', 'Chigasaki City', 'City', NULL, 'Chigasaki City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('nakai-town', 'Nakai Town', 'Town', NULL, 'Nakai Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('ninomiya-town', 'Ninomiya Town', 'Town', NULL, 'Ninomiya Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('hakone-town', 'Hakone Town', 'Town', NULL, 'Hakone Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('hadano-city', 'Hadano City', 'City', NULL, 'Hadano City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('hayama-town', 'Hayama Town', 'Town', NULL, 'Hayama Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('hiratsuka-city', 'Hiratsuka City', 'City', NULL, 'Hiratsuka City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('fujisawa-city', 'Fujisawa City', 'City', NULL, 'Fujisawa City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('matsuda-town', 'Matsuda Town', 'Town', NULL, 'Matsuda Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('manazuru-town', 'Manazuru Town', 'Town', NULL, 'Manazuru Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('miura-city', 'Miura City', 'City', NULL, 'Miura City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('minamiashigara-city', 'Minamiashigara City', 'City', NULL, 'Minamiashigara City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('yamakita-town', 'Yamakita Town', 'Town', NULL, 'Yamakita Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('yamato-city', 'Yamato City', 'City', NULL, 'Yamato City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('yugawara-town', 'Yugawara Town', 'Town', NULL, 'Yugawara Town', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('yokosuka-city', 'Yokosuka City', 'City', NULL, 'Yokosuka City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('yokohama-city', 'Yokohama City', 'City', NULL, 'Yokohama City', 'kanagawa', 'kanto', 1, NULL, NULL, 'Published'),
('aogashima-village', 'Aogashima Village', 'City', NULL, 'Aogashima Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('akishima-city', 'Akishima City', 'City', NULL, 'Akishima City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('akiruno-city', 'Akiruno City', 'City', NULL, 'Akiruno City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('adachi-ward', 'Adachi Ward', 'Area', NULL, 'Adachi Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('arakawa-ward', 'Arakawa Ward', 'Area', NULL, 'Arakawa Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('itabashi-ward', 'Itabashi Ward', 'Area', NULL, 'Itabashi Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('inagi-city', 'Inagi City', 'City', NULL, 'Inagi City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('edogawa-ward', 'Edogawa Ward', 'Area', NULL, 'Edogawa Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('ome-city', 'Ome City', 'City', NULL, 'Ome City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('oshima-town', 'Oshima Town', 'Town', NULL, 'Oshima Town', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('ota-ward', 'Ota Ward', 'Area', NULL, 'Ota Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('ogasawara-village', 'Ogasawara Village', 'City', NULL, 'Ogasawara Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('okutama-town', 'Okutama Town', 'Town', NULL, 'Okutama Town', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('katsushika-ward', 'Katsushika Ward', 'Area', NULL, 'Katsushika Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kita-ward', 'Kita Ward', 'Area', NULL, 'Kita Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kiyose-city', 'Kiyose City', 'City', NULL, 'Kiyose City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kunitachi-city', 'Kunitachi City', 'City', NULL, 'Kunitachi City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kozushima-village', 'Kozushima Village', 'City', NULL, 'Kozushima Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('koto-ward', 'Koto Ward', 'Area', NULL, 'Koto Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('koganei-city', 'Koganei City', 'City', NULL, 'Koganei City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kokubunji-city', 'Kokubunji City', 'City', NULL, 'Kokubunji City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('kodaira-city', 'Kodaira City', 'City', NULL, 'Kodaira City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('komae-city', 'Komae City', 'City', NULL, 'Komae City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('shinagawa-ward', 'Shinagawa Ward', 'Area', NULL, 'Shinagawa Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('shibuya-ward', 'Shibuya Ward', 'Area', NULL, 'Shibuya Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('shinjuku-ward', 'Shinjuku Ward', 'Area', NULL, 'Shinjuku Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('suginami-ward', 'Suginami Ward', 'Area', NULL, 'Suginami Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('sumida-ward', 'Sumida Ward', 'Area', NULL, 'Sumida Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('setagaya-ward', 'Setagaya Ward', 'Area', NULL, 'Setagaya Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('taito-ward', 'Taito Ward', 'Area', NULL, 'Taito Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('tachikawa-city', 'Tachikawa City', 'City', NULL, 'Tachikawa City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('tama-city', 'Tama City', 'City', NULL, 'Tama City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('chuo-ward', 'Chuo Ward', 'Area', NULL, 'Chuo Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('chofu-city', 'Chofu City', 'City', NULL, 'Chofu City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('chiyoda-ward', 'Chiyoda Ward', 'Area', NULL, 'Chiyoda Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('toshima-ward', 'Toshima Ward', 'Area', NULL, 'Toshima Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('toshima-village', 'Toshima Village', 'City', NULL, 'Toshima Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('nakano-ward', 'Nakano Ward', 'Area', NULL, 'Nakano Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('niijima-village', 'Niijima Village', 'City', NULL, 'Niijima Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('nishitokyo-city', 'Nishitokyo City', 'City', NULL, 'Nishitokyo City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('nerima-ward', 'Nerima Ward', 'Area', NULL, 'Nerima Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hachioji-city', 'Hachioji City', 'City', NULL, 'Hachioji City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hachijo-town', 'Hachijo Town', 'Town', NULL, 'Hachijo Town', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hamura-city', 'Hamura City', 'City', NULL, 'Hamura City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('higashikurume-city', 'Higashikurume City', 'City', NULL, 'Higashikurume City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('higashimurayama-city', 'Higashimurayama City', 'City', NULL, 'Higashimurayama City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('higashiyamato-city', 'Higashiyamato City', 'City', NULL, 'Higashiyamato City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hino-city', 'Hino City', 'City', NULL, 'Hino City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hinode-town', 'Hinode Town', 'Town', NULL, 'Hinode Town', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('hinohara-village', 'Hinohara Village', 'City', NULL, 'Hinohara Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('fuchu-city', 'Fuchu City', 'City', NULL, 'Fuchu City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('fussa-city', 'Fussa City', 'City', NULL, 'Fussa City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('bunkyo-ward', 'Bunkyo Ward', 'Area', NULL, 'Bunkyo Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('machida-city', 'Machida City', 'City', NULL, 'Machida City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('mikurajima-village', 'Mikurajima Village', 'City', NULL, 'Mikurajima Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('mizuho-town', 'Mizuho Town', 'Town', NULL, 'Mizuho Town', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('mitaka-city', 'Mitaka City', 'City', NULL, 'Mitaka City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('minato-ward', 'Minato Ward', 'Area', NULL, 'Minato Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('miyake-village', 'Miyake Village', 'City', NULL, 'Miyake Village', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('musashino-city', 'Musashino City', 'City', NULL, 'Musashino City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('musashimurayama-city', 'Musashimurayama City', 'City', NULL, 'Musashimurayama City', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('meguro-ward', 'Meguro Ward', 'Area', NULL, 'Meguro Ward', 'tokyo', 'kanto', 1, NULL, NULL, 'Published'),
('agano-city', 'Agano City', 'City', NULL, 'Agano City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('aga-town', 'Aga Town', 'Town', NULL, 'Aga Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('awashimaura-village', 'Awashimaura Village', 'City', NULL, 'Awashimaura Village', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('izumozaki-town', 'Izumozaki Town', 'Town', NULL, 'Izumozaki Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('itoigawa-city', 'Itoigawa City', 'City', NULL, 'Itoigawa City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('uonuma-city', 'Uonuma City', 'City', NULL, 'Uonuma City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('ojiya-city', 'Ojiya City', 'City', NULL, 'Ojiya City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('kashiwazaki-city', 'Kashiwazaki City', 'City', NULL, 'Kashiwazaki City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('kamo-city', 'Kamo City', 'City', NULL, 'Kamo City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('kariwa-village', 'Kariwa Village', 'City', NULL, 'Kariwa Village', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('gosen-city', 'Gosen City', 'City', NULL, 'Gosen City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('sado-city', 'Sado City', 'City', NULL, 'Sado City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('sanjo-city', 'Sanjo City', 'City', NULL, 'Sanjo City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('shibata-city', 'Shibata City', 'City', NULL, 'Shibata City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('joetsu-city', 'Joetsu City', 'City', NULL, 'Joetsu City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('seiro-town', 'Seiro Town', 'Town', NULL, 'Seiro Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('sekikawa-village', 'Sekikawa Village', 'City', NULL, 'Sekikawa Village', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('tainai-city', 'Tainai City', 'City', NULL, 'Tainai City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('tagami-town', 'Tagami Town', 'Town', NULL, 'Tagami Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('tsunan-town', 'Tsunan Town', 'Town', NULL, 'Tsunan Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('tsubame-city', 'Tsubame City', 'City', NULL, 'Tsubame City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('tokamachi-city', 'Tokamachi City', 'City', NULL, 'Tokamachi City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('nagaoka-city', 'Nagaoka City', 'City', NULL, 'Nagaoka City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('niigata-city', 'Niigata City', 'City', NULL, 'Niigata City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('mitsuke-city', 'Mitsuke City', 'City', NULL, 'Mitsuke City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('minamiuonuma-city', 'Minamiuonuma City', 'City', NULL, 'Minamiuonuma City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('myoko-city', 'Myoko City', 'City', NULL, 'Myoko City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('murakami-city', 'Murakami City', 'City', NULL, 'Murakami City', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('yahiko-village', 'Yahiko Village', 'City', NULL, 'Yahiko Village', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('yuzawa-town', 'Yuzawa Town', 'Town', NULL, 'Yuzawa Town', 'niigata', 'chubu', 1, NULL, NULL, 'Published'),
('imizu-city', 'Imizu City', 'City', NULL, 'Imizu City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('uozu-city', 'Uozu City', 'City', NULL, 'Uozu City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('oyabe-city', 'Oyabe City', 'City', NULL, 'Oyabe City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('kamiichi-town', 'Kamiichi Town', 'Town', NULL, 'Kamiichi Town', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('kurobe-city', 'Kurobe City', 'City', NULL, 'Kurobe City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('takaoka-city', 'Takaoka City', 'City', NULL, 'Takaoka City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('tateyama-town', 'Tateyama Town', 'Town', NULL, 'Tateyama Town', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('tonami-city', 'Tonami City', 'City', NULL, 'Tonami City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('toyama-city', 'Toyama City', 'City', NULL, 'Toyama City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('namerikawa-city', 'Namerikawa City', 'City', NULL, 'Namerikawa City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('nanto-city', 'Nanto City', 'City', NULL, 'Nanto City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('nyuzen-town', 'Nyuzen Town', 'Town', NULL, 'Nyuzen Town', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('himi-city', 'Himi City', 'City', NULL, 'Himi City', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('funahashi-village', 'Funahashi Village', 'City', NULL, 'Funahashi Village', 'toyama', 'chubu', 1, NULL, NULL, 'Published'),
('anamizu-town', 'Anamizu Town', 'Town', NULL, 'Anamizu Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('uchinada-town', 'Uchinada Town', 'Town', NULL, 'Uchinada Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('kaga-city', 'Kaga City', 'City', NULL, 'Kaga City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('kanazawa-city', 'Kanazawa City', 'City', NULL, 'Kanazawa City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('kahoku-city', 'Kahoku City', 'City', NULL, 'Kahoku City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('kawakita-town', 'Kawakita Town', 'Town', NULL, 'Kawakita Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('komatsu-city', 'Komatsu City', 'City', NULL, 'Komatsu City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('shika-town', 'Shika Town', 'Town', NULL, 'Shika Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('suzu-city', 'Suzu City', 'City', NULL, 'Suzu City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('tsubata-town', 'Tsubata Town', 'Town', NULL, 'Tsubata Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('nakanoto-town', 'Nakanoto Town', 'Town', NULL, 'Nakanoto Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('nanao-city', 'Nanao City', 'City', NULL, 'Nanao City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('noto-town', 'Noto Town', 'Town', NULL, 'Noto Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('nonoichi-city', 'Nonoichi City', 'City', NULL, 'Nonoichi City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('nomi-city', 'Nomi City', 'City', NULL, 'Nomi City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('hakui-city', 'Hakui City', 'City', NULL, 'Hakui City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('hakusan-city', 'Hakusan City', 'City', NULL, 'Hakusan City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('hodatsushimizu-town', 'Hodatsushimizu Town', 'Town', NULL, 'Hodatsushimizu Town', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('wajima-city', 'Wajima City', 'City', NULL, 'Wajima City', 'ishikawa', 'chubu', 1, NULL, NULL, 'Published'),
('awara-city', 'Awara City', 'City', NULL, 'Awara City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('eiheiji-town', 'Eiheiji Town', 'Town', NULL, 'Eiheiji Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('echizen-city', 'Echizen City', 'City', NULL, 'Echizen City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('echizen-town', 'Echizen Town', 'Town', NULL, 'Echizen Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('ono-city', 'Ono City', 'City', NULL, 'Ono City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('obama-city', 'Obama City', 'City', NULL, 'Obama City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('katsuyama-city', 'Katsuyama City', 'City', NULL, 'Katsuyama City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('sakai-city', 'Sakai City', 'City', NULL, 'Sakai City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('sabae-city', 'Sabae City', 'City', NULL, 'Sabae City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('takahama-town', 'Takahama Town', 'Town', NULL, 'Takahama Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('tsuruga-city', 'Tsuruga City', 'City', NULL, 'Tsuruga City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('fukui-city', 'Fukui City', 'City', NULL, 'Fukui City', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('minamiechizen-town', 'Minamiechizen Town', 'Town', NULL, 'Minamiechizen Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('mihama-town', 'Mihama Town', 'Town', NULL, 'Mihama Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('wakasa-town', 'Wakasa Town', 'Town', NULL, 'Wakasa Town', 'fukui', 'chubu', 1, NULL, NULL, 'Published'),
('ichikawamisato-town', 'Ichikawamisato Town', 'Town', NULL, 'Ichikawamisato Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('uenohara-city', 'Uenohara City', 'City', NULL, 'Uenohara City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('otsuki-city', 'Otsuki City', 'City', NULL, 'Otsuki City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('oshino-village', 'Oshino Village', 'City', NULL, 'Oshino Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('kai-city', 'Kai City', 'City', NULL, 'Kai City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('koshu-city', 'Koshu City', 'City', NULL, 'Koshu City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('kofu-city', 'Kofu City', 'City', NULL, 'Kofu City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('kosuge-village', 'Kosuge Village', 'City', NULL, 'Kosuge Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('showa-town', 'Showa Town', 'Town', NULL, 'Showa Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('tabayama-village', 'Tabayama Village', 'City', NULL, 'Tabayama Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('chuo-city', 'Chuo City', 'City', NULL, 'Chuo City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('tsuru-city', 'Tsuru City', 'City', NULL, 'Tsuru City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('doshi-village', 'Doshi Village', 'City', NULL, 'Doshi Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('narusawa-village', 'Narusawa Village', 'City', NULL, 'Narusawa Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('nishikatsura-town', 'Nishikatsura Town', 'Town', NULL, 'Nishikatsura Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('nirasaki-city', 'Nirasaki City', 'City', NULL, 'Nirasaki City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('hayakawa-town', 'Hayakawa Town', 'Town', NULL, 'Hayakawa Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('fuefuki-city', 'Fuefuki City', 'City', NULL, 'Fuefuki City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('fujikawaguchiko-town', 'Fujikawaguchiko Town', 'Town', NULL, 'Fujikawaguchiko Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('fujikawa-town', 'Fujikawa Town', 'Town', NULL, 'Fujikawa Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('fujiyoshida-city', 'Fujiyoshida City', 'City', NULL, 'Fujiyoshida City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('minami-alps-city', 'Minami-Alps City', 'City', NULL, 'Minami-Alps City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('minobu-town', 'Minobu Town', 'Town', NULL, 'Minobu Town', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('yamanakako-village', 'Yamanakako Village', 'City', NULL, 'Yamanakako Village', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('yamanashi-city', 'Yamanashi City', 'City', NULL, 'Yamanashi City', 'yamanashi', 'chubu', 1, NULL, NULL, 'Published'),
('aoki-village', 'Aoki Village', 'City', NULL, 'Aoki Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('agematsu-town', 'Agematsu Town', 'Town', NULL, 'Agematsu Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('asahi-village', 'Asahi Village', 'City', NULL, 'Asahi Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('achi-village', 'Achi Village', 'City', NULL, 'Achi Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('azumino-city', 'Azumino City', 'City', NULL, 'Azumino City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('anan-town', 'Anan Town', 'Town', NULL, 'Anan Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('iijima-town', 'Iijima Town', 'Town', NULL, 'Iijima Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('iida-city', 'Iida City', 'City', NULL, 'Iida City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('iizuna-town', 'Iizuna Town', 'Town', NULL, 'Iizuna Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('iiyama-city', 'Iiyama City', 'City', NULL, 'Iiyama City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('ikusaka-village', 'Ikusaka Village', 'City', NULL, 'Ikusaka Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('ina-city', 'Ina City', 'City', NULL, 'Ina City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('ueda-city', 'Ueda City', 'City', NULL, 'Ueda City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('urugi-village', 'Urugi Village', 'City', NULL, 'Urugi Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('otaki-village', 'Otaki Village', 'City', NULL, 'Otaki Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('okuwa-village', 'Okuwa Village', 'City', NULL, 'Okuwa Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('oshika-village', 'Oshika Village', 'City', NULL, 'Oshika Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('omachi-city', 'Omachi City', 'City', NULL, 'Omachi City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('okaya-city', 'Okaya City', 'City', NULL, 'Okaya City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('ogawa-village', 'Ogawa Village', 'City', NULL, 'Ogawa Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('otari-village', 'Otari Village', 'City', NULL, 'Otari Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('obuse-town', 'Obuse Town', 'Town', NULL, 'Obuse Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('omi-village', 'Omi Village', 'City', NULL, 'Omi Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('karuizawa-town', 'Karuizawa Town', 'Town', NULL, 'Karuizawa Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('kawakami-village', 'Kawakami Village', 'City', NULL, 'Kawakami Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('kijimadaira-village', 'Kijimadaira Village', 'City', NULL, 'Kijimadaira Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('kiso-town', 'Kiso Town', 'Town', NULL, 'Kiso Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('kiso-village', 'Kiso Village', 'City', NULL, 'Kiso Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('kitaaiki-village', 'Kitaaiki Village', 'City', NULL, 'Kitaaiki Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('koumi-town', 'Koumi Town', 'Town', NULL, 'Koumi Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('komagane-city', 'Komagane City', 'City', NULL, 'Komagane City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('komoro-city', 'Komoro City', 'City', NULL, 'Komoro City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('sakae-village', 'Sakae Village', 'City', NULL, 'Sakae Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('sakaki-town', 'Sakaki Town', 'Town', NULL, 'Sakaki Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('saku-city', 'Saku City', 'City', NULL, 'Saku City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('sakuho-town', 'Sakuho Town', 'Town', NULL, 'Sakuho Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('shiojiri-city', 'Shiojiri City', 'City', NULL, 'Shiojiri City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('shinano-town', 'Shinano Town', 'Town', NULL, 'Shinano Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('shimojo-village', 'Shimojo Village', 'City', NULL, 'Shimojo Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('shimosuwa-town', 'Shimosuwa Town', 'Town', NULL, 'Shimosuwa Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('suzaka-city', 'Suzaka City', 'City', NULL, 'Suzaka City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('suwa-city', 'Suwa City', 'City', NULL, 'Suwa City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('takagi-village', 'Takagi Village', 'City', NULL, 'Takagi Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('takamori-town', 'Takamori Town', 'Town', NULL, 'Takamori Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('tatsuno-town', 'Tatsuno Town', 'Town', NULL, 'Tatsuno Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('tateshina-town', 'Tateshina Town', 'Town', NULL, 'Tateshina Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('chikuhoku-village', 'Chikuhoku Village', 'City', NULL, 'Chikuhoku Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('chikuma-city', 'Chikuma City', 'City', NULL, 'Chikuma City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('chino-city', 'Chino City', 'City', NULL, 'Chino City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('tenryu-village', 'Tenryu Village', 'City', NULL, 'Tenryu Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('tomi-city', 'Tomi City', 'City', NULL, 'Tomi City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('toyooka-village', 'Toyooka Village', 'City', NULL, 'Toyooka Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nakagawa-village', 'Nakagawa Village', 'City', NULL, 'Nakagawa Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nagano-city', 'Nagano City', 'City', NULL, 'Nagano City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nakano-city', 'Nakano City', 'City', NULL, 'Nakano City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nagawa-town', 'Nagawa Town', 'Town', NULL, 'Nagawa Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nagiso-town', 'Nagiso Town', 'Town', NULL, 'Nagiso Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('neba-village', 'Neba Village', 'City', NULL, 'Neba Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('nozawaonsen-village', 'Nozawaonsen Village', 'City', NULL, 'Nozawaonsen Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('hakuba-village', 'Hakuba Village', 'City', NULL, 'Hakuba Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('hara-village', 'Hara Village', 'City', NULL, 'Hara Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('hiraya-village', 'Hiraya Village', 'City', NULL, 'Hiraya Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('fujimi-town', 'Fujimi Town', 'Town', NULL, 'Fujimi Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('matsukawa-town', 'Matsukawa Town', 'Town', NULL, 'Matsukawa Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('matsukawa-village', 'Matsukawa Village', 'City', NULL, 'Matsukawa Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('matsumoto-city', 'Matsumoto City', 'City', NULL, 'Matsumoto City', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('minamiaiki-village', 'Minamiaiki Village', 'City', NULL, 'Minamiaiki Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('minamimaki-village', 'Minamimaki Village', 'City', NULL, 'Minamimaki Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('minamiminowa-village', 'Minamiminowa Village', 'City', NULL, 'Minamiminowa Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('minowa-town', 'Minowa Town', 'Town', NULL, 'Minowa Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('miyada-village', 'Miyada Village', 'City', NULL, 'Miyada Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('miyota-town', 'Miyota Town', 'Town', NULL, 'Miyota Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('yasuoka-village', 'Yasuoka Village', 'City', NULL, 'Yasuoka Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('yamagata-village', 'Yamagata Village', 'City', NULL, 'Yamagata Village', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('yamanouchi-town', 'Yamanouchi Town', 'Town', NULL, 'Yamanouchi Town', 'nagano', 'chubu', 1, NULL, NULL, 'Published'),
('anpachi-town', 'Anpachi Town', 'Town', NULL, 'Anpachi Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('ibigawa-town', 'Ibigawa Town', 'Town', NULL, 'Ibigawa Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('ena-city', 'Ena City', 'City', NULL, 'Ena City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('ogaki-city', 'Ogaki City', 'City', NULL, 'Ogaki City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kaizu-city', 'Kaizu City', 'City', NULL, 'Kaizu City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kakamigahara-city', 'Kakamigahara City', 'City', NULL, 'Kakamigahara City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kasamatsu-town', 'Kasamatsu Town', 'Town', NULL, 'Kasamatsu Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kani-city', 'Kani City', 'City', NULL, 'Kani City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kawabe-town', 'Kawabe Town', 'Town', NULL, 'Kawabe Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('kitagata-town', 'Kitagata Town', 'Town', NULL, 'Kitagata Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('ginan-town', 'Ginan Town', 'Town', NULL, 'Ginan Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('gifu-city', 'Gifu City', 'City', NULL, 'Gifu City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('gujo-city', 'Gujo City', 'City', NULL, 'Gujo City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('gero-city', 'Gero City', 'City', NULL, 'Gero City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('godo-town', 'Godo Town', 'Town', NULL, 'Godo Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('sakahogi-town', 'Sakahogi Town', 'Town', NULL, 'Sakahogi Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('shirakawa-town', 'Shirakawa Town', 'Town', NULL, 'Shirakawa Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('shirakawa-village', 'Shirakawa Village', 'City', NULL, 'Shirakawa Village', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('sekigahara-town', 'Sekigahara Town', 'Town', NULL, 'Sekigahara Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('seki-city', 'Seki City', 'City', NULL, 'Seki City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('takayama-city', 'Takayama City', 'City', NULL, 'Takayama City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('tajimi-city', 'Tajimi City', 'City', NULL, 'Tajimi City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('tarui-town', 'Tarui Town', 'Town', NULL, 'Tarui Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('toki-city', 'Toki City', 'City', NULL, 'Toki City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('tomika-town', 'Tomika Town', 'Town', NULL, 'Tomika Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('nakatsugawa-city', 'Nakatsugawa City', 'City', NULL, 'Nakatsugawa City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('hashima-city', 'Hashima City', 'City', NULL, 'Hashima City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('higashishirakawa-village', 'Higashishirakawa Village', 'City', NULL, 'Higashishirakawa Village', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('hida-city', 'Hida City', 'City', NULL, 'Hida City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('hichiso-town', 'Hichiso Town', 'Town', NULL, 'Hichiso Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('mizunami-city', 'Mizunami City', 'City', NULL, 'Mizunami City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('mizuho-city', 'Mizuho City', 'City', NULL, 'Mizuho City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('mitake-town', 'Mitake Town', 'Town', NULL, 'Mitake Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('minokamo-city', 'Minokamo City', 'City', NULL, 'Minokamo City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('mino-city', 'Mino City', 'City', NULL, 'Mino City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('motosu-city', 'Motosu City', 'City', NULL, 'Motosu City', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('yaotsu-town', 'Yaotsu Town', 'Town', NULL, 'Yaotsu Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('yoro-town', 'Yoro Town', 'Town', NULL, 'Yoro Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('wanouchi-town', 'Wanouchi Town', 'Town', NULL, 'Wanouchi Town', 'gifu', 'chubu', 1, NULL, NULL, 'Published'),
('atami-city', 'Atami City', 'City', NULL, 'Atami City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('izu-city', 'Izu City', 'City', NULL, 'Izu City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('izunokuni-city', 'Izunokuni City', 'City', NULL, 'Izunokuni City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('ito-city', 'Ito City', 'City', NULL, 'Ito City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('iwata-city', 'Iwata City', 'City', NULL, 'Iwata City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('omaezaki-city', 'Omaezaki City', 'City', NULL, 'Omaezaki City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('oyama-town', 'Oyama Town', 'Town', NULL, 'Oyama Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kakegawa-city', 'Kakegawa City', 'City', NULL, 'Kakegawa City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kawazu-town', 'Kawazu Town', 'Town', NULL, 'Kawazu Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kawanehon-town', 'Kawanehon Town', 'Town', NULL, 'Kawanehon Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kannami-town', 'Kannami Town', 'Town', NULL, 'Kannami Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kikugawa-city', 'Kikugawa City', 'City', NULL, 'Kikugawa City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('kosai-city', 'Kosai City', 'City', NULL, 'Kosai City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('gotemba-city', 'Gotemba City', 'City', NULL, 'Gotemba City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('shizuoka-city', 'Shizuoka City', 'City', NULL, 'Shizuoka City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('shimada-city', 'Shimada City', 'City', NULL, 'Shimada City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('shimoda-city', 'Shimoda City', 'City', NULL, 'Shimoda City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('susono-city', 'Susono City', 'City', NULL, 'Susono City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('nagaizumi-town', 'Nagaizumi Town', 'Town', NULL, 'Nagaizumi Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('nishiizu-town', 'Nishiizu Town', 'Town', NULL, 'Nishiizu Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('numazu-city', 'Numazu City', 'City', NULL, 'Numazu City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('hamamatsu-city', 'Hamamatsu City', 'City', NULL, 'Hamamatsu City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('higashiizu-town', 'Higashiizu Town', 'Town', NULL, 'Higashiizu Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('fukuroi-city', 'Fukuroi City', 'City', NULL, 'Fukuroi City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('fujieda-city', 'Fujieda City', 'City', NULL, 'Fujieda City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('fuji-city', 'Fuji City', 'City', NULL, 'Fuji City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('fujinomiya-city', 'Fujinomiya City', 'City', NULL, 'Fujinomiya City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('makinohara-city', 'Makinohara City', 'City', NULL, 'Makinohara City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('matsuzaki-town', 'Matsuzaki Town', 'Town', NULL, 'Matsuzaki Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('mishima-city', 'Mishima City', 'City', NULL, 'Mishima City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('minamiizu-town', 'Minamiizu Town', 'Town', NULL, 'Minamiizu Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('yaizu-city', 'Yaizu City', 'City', NULL, 'Yaizu City', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('yoshida-town', 'Yoshida Town', 'Town', NULL, 'Yoshida Town', 'shizuoka', 'chubu', 1, NULL, NULL, 'Published'),
('aisai-city', 'Aisai City', 'City', NULL, 'Aisai City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('agui-town', 'Agui Town', 'Town', NULL, 'Agui Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('ama-city', 'Ama City', 'City', NULL, 'Ama City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('anjo-city', 'Anjo City', 'City', NULL, 'Anjo City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('ichinomiya-city', 'Ichinomiya City', 'City', NULL, 'Ichinomiya City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('inazawa-city', 'Inazawa City', 'City', NULL, 'Inazawa City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('inuyama-city', 'Inuyama City', 'City', NULL, 'Inuyama City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('iwakura-city', 'Iwakura City', 'City', NULL, 'Iwakura City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('oguchi-town', 'Oguchi Town', 'Town', NULL, 'Oguchi Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('oharu-town', 'Oharu Town', 'Town', NULL, 'Oharu Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('obu-city', 'Obu City', 'City', NULL, 'Obu City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('okazaki-city', 'Okazaki City', 'City', NULL, 'Okazaki City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('owariasahi-city', 'Owariasahi City', 'City', NULL, 'Owariasahi City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kasugai-city', 'Kasugai City', 'City', NULL, 'Kasugai City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kanie-town', 'Kanie Town', 'Town', NULL, 'Kanie Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('gamagori-city', 'Gamagori City', 'City', NULL, 'Gamagori City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kariya-city', 'Kariya City', 'City', NULL, 'Kariya City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kitanagoya-city', 'Kitanagoya City', 'City', NULL, 'Kitanagoya City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kiyosu-city', 'Kiyosu City', 'City', NULL, 'Kiyosu City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('kota-town', 'Kota Town', 'Town', NULL, 'Kota Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('konan-city', 'Konan City', 'City', NULL, 'Konan City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('komaki-city', 'Komaki City', 'City', NULL, 'Komaki City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('shitara-town', 'Shitara Town', 'Town', NULL, 'Shitara Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('shinshiro-city', 'Shinshiro City', 'City', NULL, 'Shinshiro City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('seto-city', 'Seto City', 'City', NULL, 'Seto City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('takahama-city', 'Takahama City', 'City', NULL, 'Takahama City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('taketoyo-town', 'Taketoyo Town', 'Town', NULL, 'Taketoyo Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('tahara-city', 'Tahara City', 'City', NULL, 'Tahara City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('chita-city', 'Chita City', 'City', NULL, 'Chita City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('chiryu-city', 'Chiryu City', 'City', NULL, 'Chiryu City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('tsushima-city', 'Tsushima City', 'City', NULL, 'Tsushima City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toei-town', 'Toei Town', 'Town', NULL, 'Toei Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('tokai-city', 'Tokai City', 'City', NULL, 'Tokai City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('togo-town', 'Togo Town', 'Town', NULL, 'Togo Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('tokoname-city', 'Tokoname City', 'City', NULL, 'Tokoname City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('tobishima-village', 'Tobishima Village', 'City', NULL, 'Tobishima Village', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyoake-city', 'Toyoake City', 'City', NULL, 'Toyoake City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyokawa-city', 'Toyokawa City', 'City', NULL, 'Toyokawa City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyota-city', 'Toyota City', 'City', NULL, 'Toyota City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyone-village', 'Toyone Village', 'City', NULL, 'Toyone Village', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyohashi-city', 'Toyohashi City', 'City', NULL, 'Toyohashi City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('toyoyama-town', 'Toyoyama Town', 'Town', NULL, 'Toyoyama Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('nagakute-city', 'Nagakute City', 'City', NULL, 'Nagakute City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('nagoya-city', 'Nagoya City', 'City', NULL, 'Nagoya City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('nishio-city', 'Nishio City', 'City', NULL, 'Nishio City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('nisshin-city', 'Nisshin City', 'City', NULL, 'Nisshin City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('handa-city', 'Handa City', 'City', NULL, 'Handa City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('higashiura-town', 'Higashiura Town', 'Town', NULL, 'Higashiura Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('fuso-town', 'Fuso Town', 'Town', NULL, 'Fuso Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('hekinan-city', 'Hekinan City', 'City', NULL, 'Hekinan City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('minamichita-town', 'Minamichita Town', 'Town', NULL, 'Minamichita Town', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('miyoshi-city', 'Miyoshi City', 'City', NULL, 'Miyoshi City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('yatomi-city', 'Yatomi City', 'City', NULL, 'Yatomi City', 'aichi', 'chubu', 1, NULL, NULL, 'Published'),
('iga-city', 'Iga City', 'City', NULL, 'Iga City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('ise-city', 'Ise City', 'City', NULL, 'Ise City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('inabe-city', 'Inabe City', 'City', NULL, 'Inabe City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('odai-town', 'Odai Town', 'Town', NULL, 'Odai Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('owase-city', 'Owase City', 'City', NULL, 'Owase City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kameyama-city', 'Kameyama City', 'City', NULL, 'Kameyama City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kawagoe-town', 'Kawagoe Town', 'Town', NULL, 'Kawagoe Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kisosaki-town', 'Kisosaki Town', 'Town', NULL, 'Kisosaki Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kiho-town', 'Kiho Town', 'Town', NULL, 'Kiho Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kihoku-town', 'Kihoku Town', 'Town', NULL, 'Kihoku Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kumano-city', 'Kumano City', 'City', NULL, 'Kumano City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('kuwana-city', 'Kuwana City', 'City', NULL, 'Kuwana City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('komono-town', 'Komono Town', 'Town', NULL, 'Komono Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('shima-city', 'Shima City', 'City', NULL, 'Shima City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('suzuka-city', 'Suzuka City', 'City', NULL, 'Suzuka City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('taki-town', 'Taki Town', 'Town', NULL, 'Taki Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('tamaki-town', 'Tamaki Town', 'Town', NULL, 'Tamaki Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('tsu-city', 'Tsu City', 'City', NULL, 'Tsu City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('toin-town', 'Toin Town', 'Town', NULL, 'Toin Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('toba-city', 'Toba City', 'City', NULL, 'Toba City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('nabari-city', 'Nabari City', 'City', NULL, 'Nabari City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('matsusaka-city', 'Matsusaka City', 'City', NULL, 'Matsusaka City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('minamiise-town', 'Minamiise Town', 'Town', NULL, 'Minamiise Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('yokkaichi-city', 'Yokkaichi City', 'City', NULL, 'Yokkaichi City', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('watarai-town', 'Watarai Town', 'Town', NULL, 'Watarai Town', 'mie', 'kansai', 1, NULL, NULL, 'Published'),
('aisho-town', 'Aisho Town', 'Town', NULL, 'Aisho Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('omihachiman-city', 'Omihachiman City', 'City', NULL, 'Omihachiman City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('otsu-city', 'Otsu City', 'City', NULL, 'Otsu City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('kusatsu-city', 'Kusatsu City', 'City', NULL, 'Kusatsu City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('koka-city', 'Koka City', 'City', NULL, 'Koka City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('kora-town', 'Kora Town', 'Town', NULL, 'Kora Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('takashima-city', 'Takashima City', 'City', NULL, 'Takashima City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('taga-town', 'Taga Town', 'Town', NULL, 'Taga Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('toyosato-town', 'Toyosato Town', 'Town', NULL, 'Toyosato Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('nagahama-city', 'Nagahama City', 'City', NULL, 'Nagahama City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('higashiomi-city', 'Higashiomi City', 'City', NULL, 'Higashiomi City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('hikone-city', 'Hikone City', 'City', NULL, 'Hikone City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('hino-town', 'Hino Town', 'Town', NULL, 'Hino Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('maibara-city', 'Maibara City', 'City', NULL, 'Maibara City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('moriyama-city', 'Moriyama City', 'City', NULL, 'Moriyama City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('yasu-city', 'Yasu City', 'City', NULL, 'Yasu City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('ritto-city', 'Ritto City', 'City', NULL, 'Ritto City', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('ryuo-town', 'Ryuo Town', 'Town', NULL, 'Ryuo Town', 'shiga', 'kansai', 1, NULL, NULL, 'Published'),
('ayabe-city', 'Ayabe City', 'City', NULL, 'Ayabe City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('ide-town', 'Ide Town', 'Town', NULL, 'Ide Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('ine-town', 'Ine Town', 'Town', NULL, 'Ine Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('uji-city', 'Uji City', 'City', NULL, 'Uji City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('ujitawara-town', 'Ujitawara Town', 'Town', NULL, 'Ujitawara Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('oyamazaki-town', 'Oyamazaki Town', 'Town', NULL, 'Oyamazaki Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kasagi-town', 'Kasagi Town', 'Town', NULL, 'Kasagi Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kameoka-city', 'Kameoka City', 'City', NULL, 'Kameoka City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kizugawa-city', 'Kizugawa City', 'City', NULL, 'Kizugawa City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kyotanabe-city', 'Kyotanabe City', 'City', NULL, 'Kyotanabe City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kyotango-city', 'Kyotango City', 'City', NULL, 'Kyotango City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kyotamba-town', 'Kyotamba Town', 'Town', NULL, 'Kyotamba Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kyoto-city', 'Kyoto City', 'City', NULL, 'Kyoto City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('kumiyama-town', 'Kumiyama Town', 'Town', NULL, 'Kumiyama Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('joyo-city', 'Joyo City', 'City', NULL, 'Joyo City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('seika-town', 'Seika Town', 'Town', NULL, 'Seika Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('nagaokakyo-city', 'Nagaokakyo City', 'City', NULL, 'Nagaokakyo City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('nantan-city', 'Nantan City', 'City', NULL, 'Nantan City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('fukuchiyama-city', 'Fukuchiyama City', 'City', NULL, 'Fukuchiyama City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('maizuru-city', 'Maizuru City', 'City', NULL, 'Maizuru City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('minamiyamashiro-village', 'Minamiyamashiro Village', 'City', NULL, 'Minamiyamashiro Village', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('miyazu-city', 'Miyazu City', 'City', NULL, 'Miyazu City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('muko-city', 'Muko City', 'City', NULL, 'Muko City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('yawata-city', 'Yawata City', 'City', NULL, 'Yawata City', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('yosano-town', 'Yosano Town', 'Town', NULL, 'Yosano Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('wazuka-town', 'Wazuka Town', 'Town', NULL, 'Wazuka Town', 'kyoto', 'kansai', 1, NULL, NULL, 'Published'),
('ikeda-city', 'Ikeda City', 'City', NULL, 'Ikeda City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('izumiotsu-city', 'Izumiotsu City', 'City', NULL, 'Izumiotsu City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('izumisano-city', 'Izumisano City', 'City', NULL, 'Izumisano City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('izumi-city', 'Izumi City', 'City', NULL, 'Izumi City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('ibaraki-city', 'Ibaraki City', 'City', NULL, 'Ibaraki City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('osakasayama-city', 'Osakasayama City', 'City', NULL, 'Osakasayama City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('osaka-city', 'Osaka City', 'City', NULL, 'Osaka City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kaizuka-city', 'Kaizuka City', 'City', NULL, 'Kaizuka City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kashiwara-city', 'Kashiwara City', 'City', NULL, 'Kashiwara City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('katano-city', 'Katano City', 'City', NULL, 'Katano City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kadoma-city', 'Kadoma City', 'City', NULL, 'Kadoma City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kanan-town', 'Kanan Town', 'Town', NULL, 'Kanan Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kawachinagano-city', 'Kawachinagano City', 'City', NULL, 'Kawachinagano City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kishiwada-city', 'Kishiwada City', 'City', NULL, 'Kishiwada City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('kumatori-town', 'Kumatori Town', 'Town', NULL, 'Kumatori Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('shijonawate-city', 'Shijonawate City', 'City', NULL, 'Shijonawate City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('shimamoto-town', 'Shimamoto Town', 'Town', NULL, 'Shimamoto Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('suita-city', 'Suita City', 'City', NULL, 'Suita City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('settsu-city', 'Settsu City', 'City', NULL, 'Settsu City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('sennan-city', 'Sennan City', 'City', NULL, 'Sennan City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('taishi-town', 'Taishi Town', 'Town', NULL, 'Taishi Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('daito-city', 'Daito City', 'City', NULL, 'Daito City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('takaishi-city', 'Takaishi City', 'City', NULL, 'Takaishi City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('takatsuki-city', 'Takatsuki City', 'City', NULL, 'Takatsuki City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('tajiri-town', 'Tajiri Town', 'Town', NULL, 'Tajiri Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('tadaoka-town', 'Tadaoka Town', 'Town', NULL, 'Tadaoka Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('chihayaakasaka-village', 'Chihayaakasaka Village', 'City', NULL, 'Chihayaakasaka Village', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('toyonaka-city', 'Toyonaka City', 'City', NULL, 'Toyonaka City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('toyono-town', 'Toyono Town', 'Town', NULL, 'Toyono Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('tondabayashi-city', 'Tondabayashi City', 'City', NULL, 'Tondabayashi City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('neyagawa-city', 'Neyagawa City', 'City', NULL, 'Neyagawa City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('nose-town', 'Nose Town', 'Town', NULL, 'Nose Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('habikino-city', 'Habikino City', 'City', NULL, 'Habikino City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('hannan-city', 'Hannan City', 'City', NULL, 'Hannan City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('higashiosaka-city', 'Higashiosaka City', 'City', NULL, 'Higashiosaka City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('hirakata-city', 'Hirakata City', 'City', NULL, 'Hirakata City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('fujiidera-city', 'Fujiidera City', 'City', NULL, 'Fujiidera City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('matsubara-city', 'Matsubara City', 'City', NULL, 'Matsubara City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('misaki-town', 'Misaki Town', 'Town', NULL, 'Misaki Town', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('minoh-city', 'Minoh City', 'City', NULL, 'Minoh City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('moriguchi-city', 'Moriguchi City', 'City', NULL, 'Moriguchi City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('yao-city', 'Yao City', 'City', NULL, 'Yao City', 'osaka', 'kansai', 1, NULL, NULL, 'Published'),
('aioi-city', 'Aioi City', 'City', NULL, 'Aioi City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('akashi-city', 'Akashi City', 'City', NULL, 'Akashi City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('ako-city', 'Ako City', 'City', NULL, 'Ako City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('asago-city', 'Asago City', 'City', NULL, 'Asago City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('ashiya-city', 'Ashiya City', 'City', NULL, 'Ashiya City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('amagasaki-city', 'Amagasaki City', 'City', NULL, 'Amagasaki City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('awaji-city', 'Awaji City', 'City', NULL, 'Awaji City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('itami-city', 'Itami City', 'City', NULL, 'Itami City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('ichikawa-town', 'Ichikawa Town', 'Town', NULL, 'Ichikawa Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('inagawa-town', 'Inagawa Town', 'Town', NULL, 'Inagawa Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('inami-town', 'Inami Town', 'Town', NULL, 'Inami Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kakogawa-city', 'Kakogawa City', 'City', NULL, 'Kakogawa City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kasai-city', 'Kasai City', 'City', NULL, 'Kasai City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kato-city', 'Kato City', 'City', NULL, 'Kato City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kamigori-town', 'Kamigori Town', 'Town', NULL, 'Kamigori Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kawanishi-city', 'Kawanishi City', 'City', NULL, 'Kawanishi City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('kobe-city', 'Kobe City', 'City', NULL, 'Kobe City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('sayo-town', 'Sayo Town', 'Town', NULL, 'Sayo Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('sanda-city', 'Sanda City', 'City', NULL, 'Sanda City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('shiso-city', 'Shiso City', 'City', NULL, 'Shiso City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('shinonsen-town', 'Shinonsen Town', 'Town', NULL, 'Shinonsen Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('sumoto-city', 'Sumoto City', 'City', NULL, 'Sumoto City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('takasago-city', 'Takasago City', 'City', NULL, 'Takasago City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('taka-town', 'Taka Town', 'Town', NULL, 'Taka Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('takarazuka-city', 'Takarazuka City', 'City', NULL, 'Takarazuka City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('tatsuno-city', 'Tatsuno City', 'City', NULL, 'Tatsuno City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('tamba-sasayama-city', 'Tamba Sasayama City', 'City', NULL, 'Tamba Sasayama City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('tamba-city', 'Tamba City', 'City', NULL, 'Tamba City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('toyooka-city', 'Toyooka City', 'City', NULL, 'Toyooka City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('nishinomiya-city', 'Nishinomiya City', 'City', NULL, 'Nishinomiya City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('nishiwaki-city', 'Nishiwaki City', 'City', NULL, 'Nishiwaki City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('harima-town', 'Harima Town', 'Town', NULL, 'Harima Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('himeji-city', 'Himeji City', 'City', NULL, 'Himeji City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('fukusaki-town', 'Fukusaki Town', 'Town', NULL, 'Fukusaki Town', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('miki-city', 'Miki City', 'City', NULL, 'Miki City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('minamiawaji-city', 'Minamiawaji City', 'City', NULL, 'Minamiawaji City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('yabu-city', 'Yabu City', 'City', NULL, 'Yabu City', 'hyogo', 'kansai', 1, NULL, NULL, 'Published'),
('asuka-village', 'Asuka Village', 'City', NULL, 'Asuka Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('ando-town', 'Ando Town', 'Town', NULL, 'Ando Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('ikaruga-town', 'Ikaruga Town', 'Town', NULL, 'Ikaruga Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('ikoma-city', 'Ikoma City', 'City', NULL, 'Ikoma City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('uda-city', 'Uda City', 'City', NULL, 'Uda City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('oji-town', 'Oji Town', 'Town', NULL, 'Oji Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('oyodo-town', 'Oyodo Town', 'Town', NULL, 'Oyodo Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kashiba-city', 'Kashiba City', 'City', NULL, 'Kashiba City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kashihara-city', 'Kashihara City', 'City', NULL, 'Kashihara City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('katsuragi-city', 'Katsuragi City', 'City', NULL, 'Katsuragi City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kamikitayama-village', 'Kamikitayama Village', 'City', NULL, 'Kamikitayama Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kawai-town', 'Kawai Town', 'Town', NULL, 'Kawai Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kanmaki-town', 'Kanmaki Town', 'Town', NULL, 'Kanmaki Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('kurotaki-village', 'Kurotaki Village', 'City', NULL, 'Kurotaki Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('koryo-town', 'Koryo Town', 'Town', NULL, 'Koryo Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('gojo-city', 'Gojo City', 'City', NULL, 'Gojo City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('gose-city', 'Gose City', 'City', NULL, 'Gose City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('sakurai-city', 'Sakurai City', 'City', NULL, 'Sakurai City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('sango-town', 'Sango Town', 'Town', NULL, 'Sango Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('shimoichi-town', 'Shimoichi Town', 'Town', NULL, 'Shimoichi Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('shimokitayama-village', 'Shimokitayama Village', 'City', NULL, 'Shimokitayama Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('soni-village', 'Soni Village', 'City', NULL, 'Soni Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('takatori-town', 'Takatori Town', 'Town', NULL, 'Takatori Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('tawaramoto-town', 'Tawaramoto Town', 'Town', NULL, 'Tawaramoto Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('tenkawa-village', 'Tenkawa Village', 'City', NULL, 'Tenkawa Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('tenri-city', 'Tenri City', 'City', NULL, 'Tenri City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('totsukawa-village', 'Totsukawa Village', 'City', NULL, 'Totsukawa Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('nara-city', 'Nara City', 'City', NULL, 'Nara City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('nosegawa-village', 'Nosegawa Village', 'City', NULL, 'Nosegawa Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('higashiyoshino-village', 'Higashiyoshino Village', 'City', NULL, 'Higashiyoshino Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('heguri-town', 'Heguri Town', 'Town', NULL, 'Heguri Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('mitsue-village', 'Mitsue Village', 'City', NULL, 'Mitsue Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('miyake-town', 'Miyake Town', 'Town', NULL, 'Miyake Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('yamazoe-village', 'Yamazoe Village', 'City', NULL, 'Yamazoe Village', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('yamatokoriyama-city', 'Yamatokoriyama City', 'City', NULL, 'Yamatokoriyama City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('yamatotakada-city', 'Yamatotakada City', 'City', NULL, 'Yamatotakada City', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('yoshino-town', 'Yoshino Town', 'Town', NULL, 'Yoshino Town', 'nara', 'kansai', 1, NULL, NULL, 'Published'),
('aridagawa-town', 'Aridagawa Town', 'Town', NULL, 'Aridagawa Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('arida-city', 'Arida City', 'City', NULL, 'Arida City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('iwade-city', 'Iwade City', 'City', NULL, 'Iwade City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kainan-city', 'Kainan City', 'City', NULL, 'Kainan City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('katsuragi-town', 'Katsuragi Town', 'Town', NULL, 'Katsuragi Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kamitonda-town', 'Kamitonda Town', 'Town', NULL, 'Kamitonda Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kitayama-village', 'Kitayama Village', 'City', NULL, 'Kitayama Village', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kinokawa-city', 'Kinokawa City', 'City', NULL, 'Kinokawa City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kimino-town', 'Kimino Town', 'Town', NULL, 'Kimino Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kushimoto-town', 'Kushimoto Town', 'Town', NULL, 'Kushimoto Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kudoyama-town', 'Kudoyama Town', 'Town', NULL, 'Kudoyama Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('koya-town', 'Koya Town', 'Town', NULL, 'Koya Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('kozagawa-town', 'Kozagawa Town', 'Town', NULL, 'Kozagawa Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('gobo-city', 'Gobo City', 'City', NULL, 'Gobo City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('shirahama-town', 'Shirahama Town', 'Town', NULL, 'Shirahama Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('shingu-city', 'Shingu City', 'City', NULL, 'Shingu City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('susami-town', 'Susami Town', 'Town', NULL, 'Susami Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('taiji-town', 'Taiji Town', 'Town', NULL, 'Taiji Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('tanabe-city', 'Tanabe City', 'City', NULL, 'Tanabe City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('nachikatsuura-town', 'Nachikatsuura Town', 'Town', NULL, 'Nachikatsuura Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('hashimoto-city', 'Hashimoto City', 'City', NULL, 'Hashimoto City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('hidakagawa-town', 'Hidakagawa Town', 'Town', NULL, 'Hidakagawa Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('hirogawa-town', 'Hirogawa Town', 'Town', NULL, 'Hirogawa Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('minabe-town', 'Minabe Town', 'Town', NULL, 'Minabe Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('yuasa-town', 'Yuasa Town', 'Town', NULL, 'Yuasa Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('yura-town', 'Yura Town', 'Town', NULL, 'Yura Town', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('wakayama-city', 'Wakayama City', 'City', NULL, 'Wakayama City', 'wakayama', 'kansai', 1, NULL, NULL, 'Published'),
('iwami-town', 'Iwami Town', 'Town', NULL, 'Iwami Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('kurayoshi-city', 'Kurayoshi City', 'City', NULL, 'Kurayoshi City', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('kofu-town', 'Kofu Town', 'Town', NULL, 'Kofu Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('kotoura-town', 'Kotoura Town', 'Town', NULL, 'Kotoura Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('sakaiminato-city', 'Sakaiminato City', 'City', NULL, 'Sakaiminato City', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('daisen-town', 'Daisen Town', 'Town', NULL, 'Daisen Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('chizu-town', 'Chizu Town', 'Town', NULL, 'Chizu Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('tottori-city', 'Tottori City', 'City', NULL, 'Tottori City', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('nichinan-town', 'Nichinan Town', 'Town', NULL, 'Nichinan Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('hiezu-village', 'Hiezu Village', 'City', NULL, 'Hiezu Village', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('hoki-town', 'Hoki Town', 'Town', NULL, 'Hoki Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('hokuei-town', 'Hokuei Town', 'Town', NULL, 'Hokuei Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('misasa-town', 'Misasa Town', 'Town', NULL, 'Misasa Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('yazu-town', 'Yazu Town', 'Town', NULL, 'Yazu Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('yurihama-town', 'Yurihama Town', 'Town', NULL, 'Yurihama Town', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('yonago-city', 'Yonago City', 'City', NULL, 'Yonago City', 'tottori', 'chugoku', 1, NULL, NULL, 'Published'),
('ama-town', 'Ama Town', 'Town', NULL, 'Ama Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('iinan-town', 'Iinan Town', 'Town', NULL, 'Iinan Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('izumo-city', 'Izumo City', 'City', NULL, 'Izumo City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('unnan-city', 'Unnan City', 'City', NULL, 'Unnan City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('oda-city', 'Oda City', 'City', NULL, 'Oda City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('onan-town', 'Onan Town', 'Town', NULL, 'Onan Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('okinoshima-town', 'Okinoshima Town', 'Town', NULL, 'Okinoshima Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('okuizumo-town', 'Okuizumo Town', 'Town', NULL, 'Okuizumo Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('kawamoto-town', 'Kawamoto Town', 'Town', NULL, 'Kawamoto Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('gotsu-city', 'Gotsu City', 'City', NULL, 'Gotsu City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('chibu-village', 'Chibu Village', 'City', NULL, 'Chibu Village', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('tsuwano-town', 'Tsuwano Town', 'Town', NULL, 'Tsuwano Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('nishinoshima-town', 'Nishinoshima Town', 'Town', NULL, 'Nishinoshima Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('hamada-city', 'Hamada City', 'City', NULL, 'Hamada City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('masuda-city', 'Masuda City', 'City', NULL, 'Masuda City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('matsue-city', 'Matsue City', 'City', NULL, 'Matsue City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('yasugi-city', 'Yasugi City', 'City', NULL, 'Yasugi City', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('yoshika-town', 'Yoshika Town', 'Town', NULL, 'Yoshika Town', 'shimane', 'chugoku', 1, NULL, NULL, 'Published'),
('akaiwa-city', 'Akaiwa City', 'City', NULL, 'Akaiwa City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('asakuchi-city', 'Asakuchi City', 'City', NULL, 'Asakuchi City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('ibara-city', 'Ibara City', 'City', NULL, 'Ibara City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('okayama-city', 'Okayama City', 'City', NULL, 'Okayama City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('kagamino-town', 'Kagamino Town', 'Town', NULL, 'Kagamino Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('kasaoka-city', 'Kasaoka City', 'City', NULL, 'Kasaoka City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('kibichuo-town', 'Kibichuo Town', 'Town', NULL, 'Kibichuo Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('kumenan-town', 'Kumenan Town', 'Town', NULL, 'Kumenan Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('kurashiki-city', 'Kurashiki City', 'City', NULL, 'Kurashiki City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('satosho-town', 'Satosho Town', 'Town', NULL, 'Satosho Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('shoo-town', 'Shoo Town', 'Town', NULL, 'Shoo Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('shinjo-village', 'Shinjo Village', 'City', NULL, 'Shinjo Village', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('setouchi-city', 'Setouchi City', 'City', NULL, 'Setouchi City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('soja-city', 'Soja City', 'City', NULL, 'Soja City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('takahashi-city', 'Takahashi City', 'City', NULL, 'Takahashi City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('tamano-city', 'Tamano City', 'City', NULL, 'Tamano City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('tsuyama-city', 'Tsuyama City', 'City', NULL, 'Tsuyama City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('nagi-town', 'Nagi Town', 'Town', NULL, 'Nagi Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('niimi-city', 'Niimi City', 'City', NULL, 'Niimi City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('nishiawakura-village', 'Nishiawakura Village', 'City', NULL, 'Nishiawakura Village', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('hayashima-town', 'Hayashima Town', 'Town', NULL, 'Hayashima Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('bizen-city', 'Bizen City', 'City', NULL, 'Bizen City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('maniwa-city', 'Maniwa City', 'City', NULL, 'Maniwa City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('mimasaka-city', 'Mimasaka City', 'City', NULL, 'Mimasaka City', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('yakage-town', 'Yakage Town', 'Town', NULL, 'Yakage Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('wake-town', 'Wake Town', 'Town', NULL, 'Wake Town', 'okayama', 'chugoku', 1, NULL, NULL, 'Published'),
('akiota-town', 'Akiota Town', 'Town', NULL, 'Akiota Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('akitakata-city', 'Akitakata City', 'City', NULL, 'Akitakata City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('etajima-city', 'Etajima City', 'City', NULL, 'Etajima City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('osakikamijima-town', 'Osakikamijima Town', 'Town', NULL, 'Osakikamijima Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('otake-city', 'Otake City', 'City', NULL, 'Otake City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('onomichi-city', 'Onomichi City', 'City', NULL, 'Onomichi City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('kaita-town', 'Kaita Town', 'Town', NULL, 'Kaita Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('kitahiroshima-town', 'Kitahiroshima Town', 'Town', NULL, 'Kitahiroshima Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('kumano-town', 'Kumano Town', 'Town', NULL, 'Kumano Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('kure-city', 'Kure City', 'City', NULL, 'Kure City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('saka-town', 'Saka Town', 'Town', NULL, 'Saka Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('shobara-city', 'Shobara City', 'City', NULL, 'Shobara City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('jinsekikogen-town', 'Jinsekikogen Town', 'Town', NULL, 'Jinsekikogen Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('sera-town', 'Sera Town', 'Town', NULL, 'Sera Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('takehara-city', 'Takehara City', 'City', NULL, 'Takehara City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('hatsukaichi-city', 'Hatsukaichi City', 'City', NULL, 'Hatsukaichi City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('higashihiroshima-city', 'Higashihiroshima City', 'City', NULL, 'Higashihiroshima City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('hiroshima-city', 'Hiroshima City', 'City', NULL, 'Hiroshima City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('fukuyama-city', 'Fukuyama City', 'City', NULL, 'Fukuyama City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('fuchu-town', 'Fuchu Town', 'Town', NULL, 'Fuchu Town', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('mihara-city', 'Mihara City', 'City', NULL, 'Mihara City', 'hiroshima', 'chugoku', 1, NULL, NULL, 'Published'),
('abu-town', 'Abu Town', 'Town', NULL, 'Abu Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('iwakuni-city', 'Iwakuni City', 'City', NULL, 'Iwakuni City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('ube-city', 'Ube City', 'City', NULL, 'Ube City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('kaminoseki-town', 'Kaminoseki Town', 'Town', NULL, 'Kaminoseki Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('kudamatsu-city', 'Kudamatsu City', 'City', NULL, 'Kudamatsu City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('sanyo-onoda-city', 'Sanyo-Onoda City', 'City', NULL, 'Sanyo-Onoda City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('shimonoseki-city', 'Shimonoseki City', 'City', NULL, 'Shimonoseki City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('shunan-city', 'Shunan City', 'City', NULL, 'Shunan City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('suo-oshima-town', 'Suo-Oshima Town', 'Town', NULL, 'Suo-Oshima Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('tabuse-town', 'Tabuse Town', 'Town', NULL, 'Tabuse Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('nagato-city', 'Nagato City', 'City', NULL, 'Nagato City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('hagi-city', 'Hagi City', 'City', NULL, 'Hagi City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('hikari-city', 'Hikari City', 'City', NULL, 'Hikari City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('hirao-town', 'Hirao Town', 'Town', NULL, 'Hirao Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('hofu-city', 'Hofu City', 'City', NULL, 'Hofu City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('mine-city', 'Mine City', 'City', NULL, 'Mine City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('yanai-city', 'Yanai City', 'City', NULL, 'Yanai City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('yamaguchi-city', 'Yamaguchi City', 'City', NULL, 'Yamaguchi City', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('waki-town', 'Waki Town', 'Town', NULL, 'Waki Town', 'yamaguchi', 'chugoku', 1, NULL, NULL, 'Published'),
('aizumi-town', 'Aizumi Town', 'Town', NULL, 'Aizumi Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('anan-city', 'Anan City', 'City', NULL, 'Anan City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('awa-city', 'Awa City', 'City', NULL, 'Awa City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('ishii-town', 'Ishii Town', 'Town', NULL, 'Ishii Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('itano-town', 'Itano Town', 'Town', NULL, 'Itano Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('kaiyo-town', 'Kaiyo Town', 'Town', NULL, 'Kaiyo Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('katsuura-town', 'Katsuura Town', 'Town', NULL, 'Katsuura Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('kamiita-town', 'Kamiita Town', 'Town', NULL, 'Kamiita Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('kamikatsu-town', 'Kamikatsu Town', 'Town', NULL, 'Kamikatsu Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('kamiyama-town', 'Kamiyama Town', 'Town', NULL, 'Kamiyama Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('kitajima-town', 'Kitajima Town', 'Town', NULL, 'Kitajima Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('komatsushima-city', 'Komatsushima City', 'City', NULL, 'Komatsushima City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('sanagochi-village', 'Sanagochi Village', 'City', NULL, 'Sanagochi Village', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('tsurugi-town', 'Tsurugi Town', 'Town', NULL, 'Tsurugi Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('tokushima-city', 'Tokushima City', 'City', NULL, 'Tokushima City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('naka-town', 'Naka Town', 'Town', NULL, 'Naka Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('naruto-city', 'Naruto City', 'City', NULL, 'Naruto City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('higashimiyoshi-town', 'Higashimiyoshi Town', 'Town', NULL, 'Higashimiyoshi Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('matsushige-town', 'Matsushige Town', 'Town', NULL, 'Matsushige Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('minami-town', 'Minami Town', 'Town', NULL, 'Minami Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('mima-city', 'Mima City', 'City', NULL, 'Mima City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('mugi-town', 'Mugi Town', 'Town', NULL, 'Mugi Town', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('yoshinogawa-city', 'Yoshinogawa City', 'City', NULL, 'Yoshinogawa City', 'tokushima', 'shikoku', 1, NULL, NULL, 'Published'),
('ayagawa-town', 'Ayagawa Town', 'Town', NULL, 'Ayagawa Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('utazu-town', 'Utazu Town', 'Town', NULL, 'Utazu Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('kanonji-city', 'Kanonji City', 'City', NULL, 'Kanonji City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('kotohira-town', 'Kotohira Town', 'Town', NULL, 'Kotohira Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('sakaide-city', 'Sakaide City', 'City', NULL, 'Sakaide City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('sanuki-city', 'Sanuki City', 'City', NULL, 'Sanuki City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('shodoshima-town', 'Shodoshima Town', 'Town', NULL, 'Shodoshima Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('zentsuji-city', 'Zentsuji City', 'City', NULL, 'Zentsuji City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('takamatsu-city', 'Takamatsu City', 'City', NULL, 'Takamatsu City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('tadotsu-town', 'Tadotsu Town', 'Town', NULL, 'Tadotsu Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('naoshima-town', 'Naoshima Town', 'Town', NULL, 'Naoshima Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('higashikagawa-city', 'Higashikagawa City', 'City', NULL, 'Higashikagawa City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('marugame-city', 'Marugame City', 'City', NULL, 'Marugame City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('manno-town', 'Manno Town', 'Town', NULL, 'Manno Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('miki-town', 'Miki Town', 'Town', NULL, 'Miki Town', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('mitoyo-city', 'Mitoyo City', 'City', NULL, 'Mitoyo City', 'kagawa', 'shikoku', 1, NULL, NULL, 'Published'),
('ainan-town', 'Ainan Town', 'Town', NULL, 'Ainan Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('ikata-town', 'Ikata Town', 'Town', NULL, 'Ikata Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('imabari-city', 'Imabari City', 'City', NULL, 'Imabari City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('iyo-city', 'Iyo City', 'City', NULL, 'Iyo City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('uchiko-town', 'Uchiko Town', 'Town', NULL, 'Uchiko Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('uwajima-city', 'Uwajima City', 'City', NULL, 'Uwajima City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('ozu-city', 'Ozu City', 'City', NULL, 'Ozu City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('kamijima-town', 'Kamijima Town', 'Town', NULL, 'Kamijima Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('kumakogen-town', 'Kumakogen Town', 'Town', NULL, 'Kumakogen Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('saijo-city', 'Saijo City', 'City', NULL, 'Saijo City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('shikokuchuo-city', 'Shikokuchuo City', 'City', NULL, 'Shikokuchuo City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('seiyo-city', 'Seiyo City', 'City', NULL, 'Seiyo City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('toon-city', 'Toon City', 'City', NULL, 'Toon City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('tobe-town', 'Tobe Town', 'Town', NULL, 'Tobe Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('niihama-city', 'Niihama City', 'City', NULL, 'Niihama City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('masaki-town', 'Masaki Town', 'Town', NULL, 'Masaki Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('matsuno-town', 'Matsuno Town', 'Town', NULL, 'Matsuno Town', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('matsuyama-city', 'Matsuyama City', 'City', NULL, 'Matsuyama City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('yawatahama-city', 'Yawatahama City', 'City', NULL, 'Yawatahama City', 'ehime', 'shikoku', 1, NULL, NULL, 'Published'),
('aki-city', 'Aki City', 'City', NULL, 'Aki City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('ino-town', 'Ino Town', 'Town', NULL, 'Ino Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('umaji-village', 'Umaji Village', 'City', NULL, 'Umaji Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('okawa-village', 'Okawa Village', 'City', NULL, 'Okawa Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('otsuki-town', 'Otsuki Town', 'Town', NULL, 'Otsuki Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('otoyo-town', 'Otoyo Town', 'Town', NULL, 'Otoyo Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('ochi-town', 'Ochi Town', 'Town', NULL, 'Ochi Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('kami-city', 'Kami City', 'City', NULL, 'Kami City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('kitagawa-village', 'Kitagawa Village', 'City', NULL, 'Kitagawa Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('kuroshio-town', 'Kuroshio Town', 'Town', NULL, 'Kuroshio Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('geisei-village', 'Geisei Village', 'City', NULL, 'Geisei Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('kochi-city', 'Kochi City', 'City', NULL, 'Kochi City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('sakawa-town', 'Sakawa Town', 'Town', NULL, 'Sakawa Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('shimanto-city', 'Shimanto City', 'City', NULL, 'Shimanto City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('shimanto-town', 'Shimanto Town', 'Town', NULL, 'Shimanto Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('sukumo-city', 'Sukumo City', 'City', NULL, 'Sukumo City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('susaki-city', 'Susaki City', 'City', NULL, 'Susaki City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('tano-town', 'Tano Town', 'Town', NULL, 'Tano Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('tsuno-town', 'Tsuno Town', 'Town', NULL, 'Tsuno Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('toyo-town', 'Toyo Town', 'Town', NULL, 'Toyo Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('tosa-city', 'Tosa City', 'City', NULL, 'Tosa City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('tosashimizu-city', 'Tosashimizu City', 'City', NULL, 'Tosashimizu City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('tosa-town', 'Tosa Town', 'Town', NULL, 'Tosa Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('nakatosa-town', 'Nakatosa Town', 'Town', NULL, 'Nakatosa Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('nahari-town', 'Nahari Town', 'Town', NULL, 'Nahari Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('nankoku-city', 'Nankoku City', 'City', NULL, 'Nankoku City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('niyodogawa-town', 'Niyodogawa Town', 'Town', NULL, 'Niyodogawa Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('hidaka-village', 'Hidaka Village', 'City', NULL, 'Hidaka Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('mihara-village', 'Mihara Village', 'City', NULL, 'Mihara Village', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('muroto-city', 'Muroto City', 'City', NULL, 'Muroto City', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('motoyama-town', 'Motoyama Town', 'Town', NULL, 'Motoyama Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('yasuda-town', 'Yasuda Town', 'Town', NULL, 'Yasuda Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('yusuhara-town', 'Yusuhara Town', 'Town', NULL, 'Yusuhara Town', 'kochi', 'shikoku', 1, NULL, NULL, 'Published'),
('aka-village', 'Aka Village', 'City', NULL, 'Aka Village', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('asakura-city', 'Asakura City', 'City', NULL, 'Asakura City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ashiya-town', 'Ashiya Town', 'Town', NULL, 'Ashiya Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('iizuka-city', 'Iizuka City', 'City', NULL, 'Iizuka City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('itoshima-city', 'Itoshima City', 'City', NULL, 'Itoshima City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('itoda-town', 'Itoda Town', 'Town', NULL, 'Itoda Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ukiha-city', 'Ukiha City', 'City', NULL, 'Ukiha City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('umi-town', 'Umi Town', 'Town', NULL, 'Umi Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('okawa-city', 'Okawa City', 'City', NULL, 'Okawa City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('oki-town', 'Oki Town', 'Town', NULL, 'Oki Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('oto-town', 'Oto Town', 'Town', NULL, 'Oto Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('onojo-city', 'Onojo City', 'City', NULL, 'Onojo City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('omuta-city', 'Omuta City', 'City', NULL, 'Omuta City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('okagaki-town', 'Okagaki Town', 'Town', NULL, 'Okagaki Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ogori-city', 'Ogori City', 'City', NULL, 'Ogori City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('onga-town', 'Onga Town', 'Town', NULL, 'Onga Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kasuga-city', 'Kasuga City', 'City', NULL, 'Kasuga City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kasuya-town', 'Kasuya Town', 'Town', NULL, 'Kasuya Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kama-city', 'Kama City', 'City', NULL, 'Kama City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kawara-town', 'Kawara Town', 'Town', NULL, 'Kawara Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kanda-town', 'Kanda Town', 'Town', NULL, 'Kanda Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kitakyushu-city', 'Kitakyushu City', 'City', NULL, 'Kitakyushu City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kurate-town', 'Kurate Town', 'Town', NULL, 'Kurate Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kurume-city', 'Kurume City', 'City', NULL, 'Kurume City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('keisen-town', 'Keisen Town', 'Town', NULL, 'Keisen Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('koge-town', 'Koge Town', 'Town', NULL, 'Koge Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kotake-town', 'Kotake Town', 'Town', NULL, 'Kotake Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('sasaguri-town', 'Sasaguri Town', 'Town', NULL, 'Sasaguri Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shime-town', 'Shime Town', 'Town', NULL, 'Shime Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shingu-town', 'Shingu Town', 'Town', NULL, 'Shingu Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('sue-town', 'Sue Town', 'Town', NULL, 'Sue Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('soeda-town', 'Soeda Town', 'Town', NULL, 'Soeda Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tagawa-city', 'Tagawa City', 'City', NULL, 'Tagawa City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('dazaifu-city', 'Dazaifu City', 'City', NULL, 'Dazaifu City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tachiarai-town', 'Tachiarai Town', 'Town', NULL, 'Tachiarai Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('chikugo-city', 'Chikugo City', 'City', NULL, 'Chikugo City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('chikushino-city', 'Chikushino City', 'City', NULL, 'Chikushino City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('chikujo-town', 'Chikujo Town', 'Town', NULL, 'Chikujo Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('chikuzen-town', 'Chikuzen Town', 'Town', NULL, 'Chikuzen Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('toho-village', 'Toho Village', 'City', NULL, 'Toho Village', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nakagawa-city', 'Nakagawa City', 'City', NULL, 'Nakagawa City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nakama-city', 'Nakama City', 'City', NULL, 'Nakama City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nogata-city', 'Nogata City', 'City', NULL, 'Nogata City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hisayama-town', 'Hisayama Town', 'Town', NULL, 'Hisayama Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hirokawa-town', 'Hirokawa Town', 'Town', NULL, 'Hirokawa Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('fukuoka-city', 'Fukuoka City', 'City', NULL, 'Fukuoka City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('fukuchi-town', 'Fukuchi Town', 'Town', NULL, 'Fukuchi Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('fukutsu-city', 'Fukutsu City', 'City', NULL, 'Fukutsu City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('buzen-city', 'Buzen City', 'City', NULL, 'Buzen City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mizumaki-town', 'Mizumaki Town', 'Town', NULL, 'Mizumaki Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyako-town', 'Miyako Town', 'Town', NULL, 'Miyako Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyama-city', 'Miyama City', 'City', NULL, 'Miyama City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyawaka-city', 'Miyawaka City', 'City', NULL, 'Miyawaka City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('munakata-city', 'Munakata City', 'City', NULL, 'Munakata City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yanagawa-city', 'Yanagawa City', 'City', NULL, 'Yanagawa City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yame-city', 'Yame City', 'City', NULL, 'Yame City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yukuhashi-city', 'Yukuhashi City', 'City', NULL, 'Yukuhashi City', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yoshitomi-town', 'Yoshitomi Town', 'Town', NULL, 'Yoshitomi Town', 'fukuoka', 'kyuushuu', 1, NULL, NULL, 'Published'),
('arita-town', 'Arita Town', 'Town', NULL, 'Arita Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('imari-city', 'Imari City', 'City', NULL, 'Imari City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ureshino-city', 'Ureshino City', 'City', NULL, 'Ureshino City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('omachi-town', 'Omachi Town', 'Town', NULL, 'Omachi Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ogi-city', 'Ogi City', 'City', NULL, 'Ogi City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kamimine-town', 'Kamimine Town', 'Town', NULL, 'Kamimine Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('karatsu-city', 'Karatsu City', 'City', NULL, 'Karatsu City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kanzaki-city', 'Kanzaki City', 'City', NULL, 'Kanzaki City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kiyama-town', 'Kiyama Town', 'Town', NULL, 'Kiyama Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('genkai-town', 'Genkai Town', 'Town', NULL, 'Genkai Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kohoku-town', 'Kohoku Town', 'Town', NULL, 'Kohoku Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('saga-city', 'Saga City', 'City', NULL, 'Saga City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shiroishi-town', 'Shiroishi Town', 'Town', NULL, 'Shiroishi Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('taku-city', 'Taku City', 'City', NULL, 'Taku City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('takeo-city', 'Takeo City', 'City', NULL, 'Takeo City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tara-town', 'Tara Town', 'Town', NULL, 'Tara Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tosu-city', 'Tosu City', 'City', NULL, 'Tosu City', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyaki-town', 'Miyaki Town', 'Town', NULL, 'Miyaki Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yoshinogari-town', 'Yoshinogari Town', 'Town', NULL, 'Yoshinogari Town', 'saga', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nagasaki-city', 'Nagasaki City', 'City', NULL, 'Nagasaki City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('sasebo-city', 'Sasebo City', 'City', NULL, 'Sasebo City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('isahaya-city', 'Isahaya City', 'City', NULL, 'Isahaya City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mura-city', 'Ōmura City', 'City', NULL, 'Ōmura City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shimabara-city', 'Shimabara City', 'City', NULL, 'Shimabara City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamishimabara-city', 'Minamishimabara City', 'City', NULL, 'Minamishimabara City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hirado-city', 'Hirado City', 'City', NULL, 'Hirado City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('iki-city', 'Iki City', 'City', NULL, 'Iki City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('matsuura-city', 'Matsuura City', 'City', NULL, 'Matsuura City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('got-city', 'Gotō City', 'City', NULL, 'Gotō City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('saikai-city', 'Saikai City', 'City', NULL, 'Saikai City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('unzen-city', 'Unzen City', 'City', NULL, 'Unzen City', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nagayo-town', 'Nagayo Town', 'Town', NULL, 'Nagayo Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('togitsu-town', 'Togitsu Town', 'Town', NULL, 'Togitsu Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('higashisonogi-town', 'Higashisonogi Town', 'Town', NULL, 'Higashisonogi Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kawatana-town', 'Kawatana Town', 'Town', NULL, 'Kawatana Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hasami-town', 'Hasami Town', 'Town', NULL, 'Hasami Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ojika-town', 'Ojika Town', 'Town', NULL, 'Ojika Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('saza-town', 'Saza Town', 'Town', NULL, 'Saza Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shinkamigoto-town', 'Shinkamigoto Town', 'Town', NULL, 'Shinkamigoto Town', 'nagasaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kumamoto-city', 'Kumamoto City', 'City', NULL, 'Kumamoto City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yatsushiro-city', 'Yatsushiro City', 'City', NULL, 'Yatsushiro City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('amakusa-city', 'Amakusa City', 'City', NULL, 'Amakusa City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tamana-city', 'Tamana City', 'City', NULL, 'Tamana City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('k-shi-city', 'Kōshi City', 'City', NULL, 'Kōshi City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('uki-city', 'Uki City', 'City', NULL, 'Uki City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('aso-city', 'Aso City', 'City', NULL, 'Aso City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hitoyoshi-city', 'Hitoyoshi City', 'City', NULL, 'Hitoyoshi City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kami-amakusa-city', 'Kami-Amakusa City', 'City', NULL, 'Kami-Amakusa City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kikuchi-city', 'Kikuchi City', 'City', NULL, 'Kikuchi City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamata-city', 'Minamata City', 'City', NULL, 'Minamata City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('uto-city', 'Uto City', 'City', NULL, 'Uto City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yamaga-city', 'Yamaga City', 'City', NULL, 'Yamaga City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('arao-city', 'Arao City', 'City', NULL, 'Arao City', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mashiki-town', 'Mashiki Town', 'Town', NULL, 'Mashiki Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mifune-town', 'Mifune Town', 'Town', NULL, 'Mifune Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamioguni-town', 'Minamioguni Town', 'Town', NULL, 'Minamioguni Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nagasu-town', 'Nagasu Town', 'Town', NULL, 'Nagasu Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nagomi-town', 'Nagomi Town', 'Town', NULL, 'Nagomi Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nankan-town', 'Nankan Town', 'Town', NULL, 'Nankan Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nishiki-town', 'Nishiki Town', 'Town', NULL, 'Nishiki Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ozu-town', 'Ozu Town', 'Town', NULL, 'Ozu Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kikuyo-town', 'Kikuyo Town', 'Town', NULL, 'Kikuyo Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kosa-town', 'Kosa Town', 'Town', NULL, 'Kosa Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yamato-town', 'Yamato Town', 'Town', NULL, 'Yamato Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hikawa-town', 'Hikawa Town', 'Town', NULL, 'Hikawa Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ashikita-town', 'Ashikita Town', 'Town', NULL, 'Ashikita Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tsunagi-town', 'Tsunagi Town', 'Town', NULL, 'Tsunagi Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('asagiri-town', 'Asagiri Town', 'Town', NULL, 'Asagiri Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('taragi-town', 'Taragi Town', 'Town', NULL, 'Taragi Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yunomae-town', 'Yunomae Town', 'Town', NULL, 'Yunomae Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mizukami-village', 'Mizukami Village', 'City', NULL, 'Mizukami Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('sagara-village', 'Sagara Village', 'City', NULL, 'Sagara Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('itsuki-village', 'Itsuki Village', 'City', NULL, 'Itsuki Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yamae-village', 'Yamae Village', 'City', NULL, 'Yamae Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kuma-village', 'Kuma Village', 'City', NULL, 'Kuma Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('reihoku-town', 'Reihoku Town', 'Town', NULL, 'Reihoku Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nishihara-village', 'Nishihara Village', 'City', NULL, 'Nishihara Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamiaso-village', 'Minamiaso Village', 'City', NULL, 'Minamiaso Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ubuyama-village', 'Ubuyama Village', 'City', NULL, 'Ubuyama Village', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('gyokuto-town', 'Gyokuto Town', 'Town', NULL, 'Gyokuto Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kashima-town', 'Kashima Town', 'Town', NULL, 'Kashima Town', 'kumamoto', 'kyuushuu', 1, NULL, NULL, 'Published'),
('beppu-city', 'Beppu City', 'City', NULL, 'Beppu City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('bungo-no-city', 'Bungo-Ōno City', 'City', NULL, 'Bungo-Ōno City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('bungotakada-city', 'Bungotakada City', 'City', NULL, 'Bungotakada City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hita-city', 'Hita City', 'City', NULL, 'Hita City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kitsuki-city', 'Kitsuki City', 'City', NULL, 'Kitsuki City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kunisaki-city', 'Kunisaki City', 'City', NULL, 'Kunisaki City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nakatsu-city', 'Nakatsu City', 'City', NULL, 'Nakatsu City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ita-city', 'Ōita City', 'City', NULL, 'Ōita City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('saiki-city', 'Saiki City', 'City', NULL, 'Saiki City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('taketa-city', 'Taketa City', 'City', NULL, 'Taketa City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tsukumi-city', 'Tsukumi City', 'City', NULL, 'Tsukumi City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('usa-city', 'Usa City', 'City', NULL, 'Usa City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('usuki-city', 'Usuki City', 'City', NULL, 'Usuki City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yufu-city', 'Yufu City', 'City', NULL, 'Yufu City', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hiji-town', 'Hiji Town', 'Town', NULL, 'Hiji Town', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('himeshima-village', 'Himeshima Village', 'City', NULL, 'Himeshima Village', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kokonoe-town', 'Kokonoe Town', 'Town', NULL, 'Kokonoe Town', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kusu-town', 'Kusu Town', 'Town', NULL, 'Kusu Town', 'oita', 'kyuushuu', 1, NULL, NULL, 'Published'),
('aya-town', 'Aya Town', 'Town', NULL, 'Aya Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ebino-city', 'Ebino City', 'City', NULL, 'Ebino City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kadogawa-town', 'Kadogawa Town', 'Town', NULL, 'Kadogawa Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kawaminami-town', 'Kawaminami Town', 'Town', NULL, 'Kawaminami Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kijo-town', 'Kijo Town', 'Town', NULL, 'Kijo Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kushima-city', 'Kushima City', 'City', NULL, 'Kushima City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kunitomi-town', 'Kunitomi Town', 'Town', NULL, 'Kunitomi Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('gokase-town', 'Gokase Town', 'Town', NULL, 'Gokase Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kobayashi-city', 'Kobayashi City', 'City', NULL, 'Kobayashi City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('saito-city', 'Saito City', 'City', NULL, 'Saito City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shiiba-village', 'Shiiba Village', 'City', NULL, 'Shiiba Village', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shintomi-town', 'Shintomi Town', 'Town', NULL, 'Shintomi Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('takachiho-town', 'Takachiho Town', 'Town', NULL, 'Takachiho Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('takanabe-town', 'Takanabe Town', 'Town', NULL, 'Takanabe Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('takaharu-town', 'Takaharu Town', 'Town', NULL, 'Takaharu Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nishimera-village', 'Nishimera Village', 'City', NULL, 'Nishimera Village', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nichinan-city', 'Nichinan City', 'City', NULL, 'Nichinan City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nobeoka-city', 'Nobeoka City', 'City', NULL, 'Nobeoka City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hinokage-town', 'Hinokage Town', 'Town', NULL, 'Hinokage Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hyuga-city', 'Hyuga City', 'City', NULL, 'Hyuga City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mimata-town', 'Mimata Town', 'Town', NULL, 'Mimata Town', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyakonojo-city', 'Miyakonojo City', 'City', NULL, 'Miyakonojo City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('miyazaki-city', 'Miyazaki City', 'City', NULL, 'Miyazaki City', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('morotsuka-village', 'Morotsuka Village', 'City', NULL, 'Morotsuka Village', 'miyazaki', 'kyuushuu', 1, NULL, NULL, 'Published'),
('aira-city', 'Aira City', 'City', NULL, 'Aira City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('akune-city', 'Akune City', 'City', NULL, 'Akune City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('amagi-town', 'Amagi Town', 'Town', NULL, 'Amagi Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('amami-city', 'Amami City', 'City', NULL, 'Amami City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('isa-city', 'Isa City', 'City', NULL, 'Isa City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('isen-town', 'Isen Town', 'Town', NULL, 'Isen Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ichikikushikino-city', 'Ichikikushikino City', 'City', NULL, 'Ichikikushikino City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('ibusuki-city', 'Ibusuki City', 'City', NULL, 'Ibusuki City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('uken-village', 'Uken Village', 'City', NULL, 'Uken Village', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('osaki-town', 'Osaki Town', 'Town', NULL, 'Osaki Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kagoshima-city', 'Kagoshima City', 'City', NULL, 'Kagoshima City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kanoya-city', 'Kanoya City', 'City', NULL, 'Kanoya City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kikai-town', 'Kikai Town', 'Town', NULL, 'Kikai Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kimotsuki-town', 'Kimotsuki Town', 'Town', NULL, 'Kimotsuki Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kirishima-city', 'Kirishima City', 'City', NULL, 'Kirishima City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('kinko-town', 'Kinko Town', 'Town', NULL, 'Kinko Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('satsumasendai-city', 'Satsumasendai City', 'City', NULL, 'Satsumasendai City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('satsuma-town', 'Satsuma Town', 'Town', NULL, 'Satsuma Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('shibushi-city', 'Shibushi City', 'City', NULL, 'Shibushi City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('setouchi-town', 'Setouchi Town', 'Town', NULL, 'Setouchi Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('soo-city', 'Soo City', 'City', NULL, 'Soo City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tatsugo-town', 'Tatsugo Town', 'Town', NULL, 'Tatsugo Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tarumizu-city', 'Tarumizu City', 'City', NULL, 'Tarumizu City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('china-town', 'China Town', 'Town', NULL, 'China Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('tokunoshima-town', 'Tokunoshima Town', 'Town', NULL, 'Tokunoshima Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nagashima-town', 'Nagashima Town', 'Town', NULL, 'Nagashima Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nakatane-town', 'Nakatane Town', 'Town', NULL, 'Nakatane Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('nishinoomote-city', 'Nishinoomote City', 'City', NULL, 'Nishinoomote City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('hioki-city', 'Hioki City', 'City', NULL, 'Hioki City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('higashikushira-town', 'Higashikushira Town', 'Town', NULL, 'Higashikushira Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('makurazaki-city', 'Makurazaki City', 'City', NULL, 'Makurazaki City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('mishima-village', 'Mishima Village', 'City', NULL, 'Mishima Village', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamiosumi-town', 'Minamiosumi Town', 'Town', NULL, 'Minamiosumi Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamikyushu-city', 'Minamikyushu City', 'City', NULL, 'Minamikyushu City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamisatsuma-city', 'Minamisatsuma City', 'City', NULL, 'Minamisatsuma City', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('minamitane-town', 'Minamitane Town', 'Town', NULL, 'Minamitane Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yakushima-town', 'Yakushima Town', 'Town', NULL, 'Yakushima Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yamato-village', 'Yamato Village', 'City', NULL, 'Yamato Village', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yusui-town', 'Yusui Town', 'Town', NULL, 'Yusui Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('yoron-town', 'Yoron Town', 'Town', NULL, 'Yoron Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('wadomari-town', 'Wadomari Town', 'Town', NULL, 'Wadomari Town', 'kagoshima', 'kyuushuu', 1, NULL, NULL, 'Published'),
('aguni-village', 'Aguni Village', 'City', NULL, 'Aguni Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('ie-village', 'Ie Village', 'City', NULL, 'Ie Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('ishigaki-city', 'Ishigaki City', 'City', NULL, 'Ishigaki City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('izena-village', 'Izena Village', 'City', NULL, 'Izena Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('itoman-city', 'Itoman City', 'City', NULL, 'Itoman City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('iheya-village', 'Iheya Village', 'City', NULL, 'Iheya Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('urasoe-city', 'Urasoe City', 'City', NULL, 'Urasoe City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('uruma-city', 'Uruma City', 'City', NULL, 'Uruma City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('ogimi-village', 'Ogimi Village', 'City', NULL, 'Ogimi Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('okinawa-city', 'Okinawa City', 'City', NULL, 'Okinawa City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('onna-village', 'Onna Village', 'City', NULL, 'Onna Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kadena-town', 'Kadena Town', 'Town', NULL, 'Kadena Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kitadaito-village', 'Kitadaito Village', 'City', NULL, 'Kitadaito Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kitanakagusuku-village', 'Kitanakagusuku Village', 'City', NULL, 'Kitanakagusuku Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('ginoza-village', 'Ginoza Village', 'City', NULL, 'Ginoza Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('ginowan-city', 'Ginowan City', 'City', NULL, 'Ginowan City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kin-town', 'Kin Town', 'Town', NULL, 'Kin Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kunigami-village', 'Kunigami Village', 'City', NULL, 'Kunigami Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('kumejima-town', 'Kumejima Town', 'Town', NULL, 'Kumejima Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('zamami-village', 'Zamami Village', 'City', NULL, 'Zamami Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('taketomi-town', 'Taketomi Town', 'Town', NULL, 'Taketomi Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('tarama-village', 'Tarama Village', 'City', NULL, 'Tarama Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('chatan-town', 'Chatan Town', 'Town', NULL, 'Chatan Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('tokashiki-village', 'Tokashiki Village', 'City', NULL, 'Tokashiki Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('tonaki-village', 'Tonaki Village', 'City', NULL, 'Tonaki Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('tomigusuku-city', 'Tomigusuku City', 'City', NULL, 'Tomigusuku City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('nakagusuku-village', 'Nakagusuku Village', 'City', NULL, 'Nakagusuku Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('nakijin-village', 'Nakijin Village', 'City', NULL, 'Nakijin Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('nago-city', 'Nago City', 'City', NULL, 'Nago City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('naha-city', 'Naha City', 'City', NULL, 'Naha City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('nanjo-city', 'Nanjo City', 'City', NULL, 'Nanjo City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('nishihara-town', 'Nishihara Town', 'Town', NULL, 'Nishihara Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('haebaru-town', 'Haebaru Town', 'Town', NULL, 'Haebaru Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('higashi-village', 'Higashi Village', 'City', NULL, 'Higashi Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('minamidaito-village', 'Minamidaito Village', 'City', NULL, 'Minamidaito Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('miyakojima-city', 'Miyakojima City', 'City', NULL, 'Miyakojima City', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('motobu-town', 'Motobu Town', 'Town', NULL, 'Motobu Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('yaese-town', 'Yaese Town', 'Town', NULL, 'Yaese Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('yonaguni-town', 'Yonaguni Town', 'Town', NULL, 'Yonaguni Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('yonabaru-town', 'Yonabaru Town', 'Town', NULL, 'Yonabaru Town', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published'),
('yomitan-village', 'Yomitan Village', 'City', NULL, 'Yomitan Village', 'okinawa', 'okinawa', 1, NULL, NULL, 'Published')
ON CONFLICT (location_id) DO UPDATE SET location_name = EXCLUDED.location_name, content_status = EXCLUDED.content_status;

-- 4. DISHES
INSERT INTO dishes (dish_id, dish_name, japanese_name, region_id, primary_prefecture_id, summary, seasons, tags, dietary_guidance, price_min, price_max, content_status, home_filter_tags, vegetarian_status, halal_status, featured, origin_history_preview, origin_history_full, did_you_know, key_ingredients, pronunciation_phonetic, pronunciation_audio_url, visual_cues, google_maps_query) VALUES
('aochu', 'Aochu', '青酎', 'kanto', 'tokyo', 'A rare artisanal sweet potato shochu distilled exclusively on the isolated volcanic island of Aogashima. Crafted by local islanders using indigenous yeast strains and sweet potatoes, it delivers a robust earthy aroma with a complex, velvety finish.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains none. Vegan-friendly.', 2000, 5000, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Distilled since the Edo period by island women as a household drink, it evolved into a prized craft spirit shaped by the island''s fertile volcanic soil and subtropical climate.', NULL, 'Because production is strictly limited to Aogashima''s tiny population, it is nationally revered as the phantom shochu.', ARRAY['{"01 Local Sweet Potatoes
Sun-ripened sweet potatoes harvested from the rich volcanic soil of Aogashima.

02 Barley Koji
Steamed barley inoculated with koji mold to initiate natural starch conversion.

03 Volcanic Basalt Water
Pure rainfall filtered through porous subterranean layers of volcanic basalt rock."}']::text[], 'ah-oh-choo', NULL, ARRAY[]::text[], NULL),
('hingya-no-shio', 'Hingya no Shio', 'ひんぎゃの塩', 'kanto', 'tokyo', 'A mineral-rich gourmet sea salt crystallized using the natural geothermal steam of Aogashima volcano. Deep Kuroshio ocean water is slowly evaporated over gentle volcanic steam vents to yield crunchy, savory salt pyramids.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains none. Vegan-friendly.', 600, 1500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The name ''Hingya'' refers to the volcanic steam vents on the island. This salt-making method harnesses the island''s natural geothermal energy, a practice deeply tied to Aogashima''s volcanic landscape.', NULL, 'It takes weeks of slow evaporation over the volcanic vents to produce this salt, resulting in its signature large, crunchy crystals.', ARRAY['{"01 Kuroshio Pacific Water
Pure deep ocean water drawn directly from the swift Pacific Kuroshio current.

02 Natural Sea Minerals
Naturally occurring calcium and magnesium retained during low-temperature evaporation."}']::text[], 'heen-gyah no shee-oh', NULL, ARRAY[]::text[], NULL),
('haijima-highball', 'Haijima Highball', '拝島ハイボール', 'kanto', 'tokyo', 'A signature local highball crafted in Akishima City using crisp underground spring water. Mixed with quality Japanese whisky and effervescent soda, it offers a clean, ultra-refreshing taste.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains none. Vegetarian-friendly.', 500, 900, 'Published', ARRAY['{"Vegetarian","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Created to celebrate the local drinking culture around Haijima Station, this highball has become a beloved staple in the area''s izakayas.', NULL, 'Akishima is famous for being the only municipality in Tokyo providing 100% pure underground water for tap supply.', ARRAY['{"01 Japanese Blended Whisky
Smooth oak-aged Japanese malt whisky selected for clean aromatic balance.

02 Akishima Spring Water Soda
Highly carbonated sparkling water crafted from pure Akishima deep subterranean wells.

03 Fresh Lemon Wedge
Freshly sliced citrus wedge adding bright acidity and aromatic zest."}']::text[], 'hah-ee-jee-mah hye-bohl', NULL, ARRAY[]::text[], NULL),
('haijima-negi-miso', 'Haijima Negi Miso', '拝島ねぎみそ', 'kanto', 'tokyo', 'A rich savory condiment prepared by sautéing locally grown green onions with aromatic fermented miso paste. It delivers an intense umami punch with sweet caramelized onion notes perfect over warm rice.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains Soy, Sesame. Vegan-friendly.', 450, 850, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Originating as a farmstead preserving method in western Tokyo to extend the shelf life of seasonal scallion harvests.', NULL, 'This versatile miso paste is commonly spread over rice balls before charcoal grilling to create fragrant yaki-onigiri.', ARRAY['{"01 Fresh Haijima Scallions
Locally harvested sweet green onions chopped fine for tender texture.

02 Fermented Rice Miso
Aged red and white soy miso paste delivering deep savory depth.

03 Toasted Sesame Oil
Pure roasted sesame oil added during pan-sautéing for nutty fragrance."}']::text[], 'hah-ee-jee-mah neh-gee mee-so', NULL, ARRAY[]::text[], NULL),
('akigawa-sweet-corn', 'Akigawa Sweet Corn', '秋川とうもろこし', 'kanto', 'tokyo', 'Exceptionally sweet and juicy corn cultivated along the fertile riverbanks of the Akigawa Valley in Akiruno City. Plucked early in the morning, these golden kernels are so crisp and sweet they can even be enjoyed raw.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains none. Vegan-friendly.', 250, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The pure waters of the Akigawa River and the valley''s distinct temperature differences create the perfect environment for cultivating this premium corn.', NULL, 'During the summer harvest season, you''ll find local farmers boiling or grilling these sweet cobs right by the roadside!', ARRAY['{"01 Fresh Sweet Corn Ears
Morning-harvested sweet corn grown in river mineral soils.

02 Sweet Butter Dip
Creamy Hokkaido butter melted over grilled cob ears.

03 Soy Sauce Drizzle
Aged soy sauce brushed over open flame for savory glaze."}']::text[], 'ah-kee-gah-wah toh-moh-roh-koh-she', NULL, ARRAY[]::text[], NULL),
('norabou-na', 'Norabou-na', 'のらぼう菜', 'kanto', 'tokyo', 'A tender local leafy green with crisp stems and a mild, sweet flavor, traditionally grown in western Tokyo. Norabou-na is valued for its edible stems and leaves and is commonly prepared simply by boiling, blanching, or stir-frying so its fresh green flavor remains clear.', ARRAY['{"Spring"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 150, 400, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Norabou-na is an old Tokyo-area vegetable associated with western suburban farming and has been cultivated in the Akiruno area for generations. Its continued use reflects traditional household vegetable growing and seasonal spring cooking rather than a single inventor.', NULL, 'The stalks and leaves can be eaten together, making it less wasteful than greens that require extensive trimming. Harvested stems are especially prized for their tender bite.', ARRAY['{"01 Norabou-na Leaves
 Tender leaves provide a mild green flavor and soft texture.
 

 02 Norabou-na Stems
 The thick stems add crispness and remain pleasantly firm after brief cooking.
 

 03 Light Seasoning
 Soy sauce, sesame, or simple dashi-based seasoning lets the vegetable''s sweetness remain noticeable."}']::text[], 'noh-rah-boh-nah', NULL, ARRAY[]::text[], NULL),
('bunka-fry', 'Bunka Fry', '文化フライ', 'kanto', 'tokyo', 'A distinctive Adachi street snack made from seasoned wheat dough shaped into a flat, sandal-like form, coated with breadcrumbs, and deep-fried. The finished fritter is lightly sweet, crisp outside, soft inside, and traditionally served hot with a generous amount of special sauce.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy', 100, 300, 'Published', ARRAY['{"Quick bite"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Bunka Fry was devised by Hasegawa Shoten in Umeda, Adachi Ward, and became a familiar festival-stall snack in the postwar period. It survived mainly through local memory after regular street-stall production declined around 2001.', NULL, 'Despite its name, Bunka Fry contains no meat or fish in the basic preparation. It is a flour-based snack whose character comes from the crisp coating, slight sweetness, and savory sauce.', ARRAY['{"01 Wheat Dough
 A simple wheat-flour dough forms the soft, chewy center.
 

 02 Breadcrumbs
 Breadcrumbs create the crisp fried shell and browned exterior.
 

 03 Special Sauce
 The signature sauce adds sweetness, saltiness, and concentrated savory flavor."}']::text[], 'boon-kah foo-rye', NULL, ARRAY[]::text[], NULL),
('senju-no-suzumeyaki', 'Senju no Suzumeyaki', '千住のすずめ焼き', 'kanto', 'tokyo', 'A traditional Senju-style small-fish dish in which whole small fish are skewered and grilled with a savory-sweet glaze. The name refers to their small, sparrow-like appearance, while the preparation belongs to the old river-and-market food culture of the Senju area.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy', 500, 1200, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Suzumeyaki is associated with the historic food culture around Senju, where small freshwater fish were preserved and sold as a practical local food. The surviving style reflects Edo-period riverine cooking rather than a single documented inventor.', NULL, 'The name evokes grilled sparrows, but it describes the fish''s small appearance, not the bird itself. Eating it with the glaze highlights the contrast between crisp edges and tender fish.', ARRAY['{"01 Small Freshwater Fish
 Small fish such as crucian carp or similar local species form the traditional base.
 

 02 Soy Sauce-Based Glaze
 Soy sauce provides saltiness and umami while developing a dark finish during grilling.
 

 03 Sweet Cooking Seasoning
 Sugar or mirin balances the glaze and helps it adhere to the fish."}']::text[], 'sen-joo no soo-zoo-meh-yah-kee', NULL, ARRAY[]::text[], NULL),
('yarikake-dango', 'Yarikake Dango', '槍かけだんご', 'kanto', 'tokyo', 'A traditional rice dumpling specialty associated with Senju, formed from chewy rice-flour dumplings on skewers and finished with a sweet or savory topping. The name is linked to a local story about resting a spear, while the dumplings are enjoyed as a simple old-fashioned snack.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 150, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Yarikake Dango is tied to the old Senju travel and lodging area and its famous legend about a spear being rested nearby. The dumpling tradition belongs to the historic neighborhood food culture and is preserved through long-running local confectionery shops.', NULL, 'The name connects the confection to a travel-era story rather than to an ingredient. Freshly made dumplings are at their best while the surface is still soft and the glaze glossy.', ARRAY['{"01 Rice Flour Dumplings
 Steamed and shaped rice dough provides the soft, chewy body.
 

 02 Sweet Bean or Soy-Based Topping
 Depending on the style, the dumplings may be finished with sweet red bean paste or a savory-sweet glaze.
 

 03 Sugar
 Sugar balances the toppings and gives the finished skewer its characteristic sweetness."}']::text[], 'yah-ree-kah-keh dahn-goh', NULL, ARRAY[]::text[], NULL),
('yuyu-toden-wagashi', 'Yuyu Toden - Wagashi', 'ゆうゆう都電（和菓子）', 'kanto', 'tokyo', 'A traditional Japanese confection shaped like the tramcars of the Toden Arakawa Line, created as a playful local souvenir from Arakawa. Sold as a shop-exclusive wagashi in Machiya, it connects a familiar streetcar image with a soft, sweet confectionary format.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat', 200, 600, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Yuyu Toden was developed as a confection associated with the Toden Arakawa Line and is sold exclusively at the Machiya shop of Chikuryuan Okano. Its design turns a well-known Arakawa transport symbol into a local sweet.', NULL, 'The confection is especially popular with children because the tram shape is easy to recognize. It is also a local souvenir tied directly to the neighborhood where the streetcar runs.', ARRAY['{"01 Sweet Bean Filling
 Sweet bean paste provides the familiar wagashi center.
 

 02 Rice-Based Confectionery Dough
 A soft Japanese confectionery exterior holds the molded tram shape.
 

 03 Sugar
 Sugar provides the characteristic sweetness of the finished wagashi."}']::text[], 'yoo-yoo toh-den wah-gah-she', NULL, ARRAY[]::text[], NULL),
('arakawa-monja', 'Arakawa Monja', 'あらかわもんじゃ', 'kanto', 'tokyo', 'A sizzling monjayaki style associated with Arakawa Ward, where a thin dashi-rich batter cooks into a loose, savory mixture on a hot griddle. Cabbage and other ingredients are cooked together, producing the soft texture and concentrated browned edges that define monjayaki.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, various toppings', 800, 2000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Monjayaki became deeply established in Tokyo''s working-class neighborhoods, and Arakawa developed its own local eating culture around the dish. The ward''s style reflects the broader shitamachi tradition rather than a single inventor.', NULL, 'A tiny metal spatula is used both to cook and eat monjayaki. The most prized bites are often the small, crisp pieces that form against the griddle.', ARRAY['{"01 Dashi-Flavored Batter
 A thin mixture of flour and dashi creates the characteristic loose texture.
 

 02 Cabbage
 Finely chopped cabbage adds sweetness, moisture, and texture.
 

 03 Local Toppings
 Seafood, meat, vegetables, cheese, or other additions create the chosen flavor profile."}']::text[], 'ah-rah-kah-wah mon-jah', NULL, ARRAY[]::text[], NULL),
('okara-soy-milk-karinto', 'Okara & Soy Milk Karinto', 'おからと豆乳のかりんとう', 'kanto', 'tokyo', 'A crunchy karinto made with okara and soy milk, turning familiar soybean by-products into a sweet, crisp snack. The version produced by Nakano Confectionery in Itabashi is recognized locally for its practical use of soy ingredients and its light, pleasantly crumbly bite.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains soy, wheat', 300, 700, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The product is made by Nakano Confectionery and is listed among Itabashi''s recognized local specialty foods. Its concept combines traditional karinto-making with okara and soy milk, reflecting an effort to use more of the soybean after tofu production.', NULL, 'Okara is the soybean pulp left after making soy milk or tofu. Using it in confectionery gives the snack a distinctive crumb and turns a tofu-making by-product into part of the finished food.', ARRAY['{"01 Okara
 Soybean pulp adds body and a slightly nutty, crumbly character.
 

 02 Soy Milk
 Soy milk enriches the dough and reinforces the soybean flavor.
 

 03 Wheat Flour and Sugar
 Flour provides structure while sugar supplies the characteristic sweetness of karinto."}']::text[], 'oh-kah-rah to toh-nyoo no kah-reen-toh', NULL, ARRAY[]::text[], NULL),
('niku-no-marusan-homemade-ham-cutlet', 'Niku no Marusan Homemade Ham Cutlet', '肉のマルサン 自家製ハムカツ', 'kanto', 'tokyo', 'A thick, butcher-shop-style ham cutlet made from a substantial slice of ham, coated and fried until the outside is crisp and golden. Niku no Marusan in Kamitabashi sells this house-made version as one of the products recognized by the Itabashi local specialty program.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains meat, wheat, egg', 150, 400, 'Published', ARRAY['{"Quick bite"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Ham cutlets became a familiar Japanese butcher-shop food during the twentieth century, and Niku no Marusan developed its own house-made version for its Kamitabashi customers. The shop''s cutlet was later selected for Itabashi''s local specialty program.', NULL, 'Niku no Marusan is a neighborhood butcher that also prepares cooked foods in-house. The ham cutlet is designed as an everyday, ready-to-eat side rather than a formal restaurant dish.', ARRAY['{"01 Ham
 A thick slice of cured ham supplies the savory center.
 

 02 Egg and Flour
 The standard cutlet coating uses flour and egg to help the crumbs adhere.
 

 03 Panko Breadcrumbs
 Japanese breadcrumbs create the crisp, light-textured crust after frying."}']::text[], 'nee-koo no mah-roo-sahn hah-moo-kah-tsoo', NULL, ARRAY[]::text[], NULL),
('inagi-pears', 'Inagi Pears', '稲城の梨', 'kanto', 'tokyo', 'Large, juicy Japanese pears grown in Inagi, a long-established pear-growing area in Tokyo. Local fruit is prized for abundant juice, pronounced sweetness, and a crisp texture, with farm stands becoming especially busy during the harvest period from late summer into autumn.', ARRAY['{"Fall"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 3000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Pear cultivation in Inagi is traced by the city to the Genroku era, when two local men are said to have brought back a pear cultivar from the Kyoto region. Commercial production became established later in the nineteenth century, leading to today''s regional brand.', NULL, 'The city says local pear stalls begin appearing prominently around mid-August. Inagi pears are also widely purchased as gifts and shipped outside Tokyo during the harvest season.', ARRAY['{"01 Japanese Pears
 Crisp Japanese pears provide the signature juicy sweetness and clean aroma.
 

 02 Orchard Fruit
 Fruit is harvested at orchard ripeness for direct sale and local distribution.
 

 03 Natural Fruit Juice
 The pear''s high natural juice content creates the refreshing texture associated with the Inagi brand."}']::text[], 'ee-nah-gee no nah-she', NULL, ARRAY[]::text[], NULL),
('inagi-mukashibanashi-manju', 'Inagi Mukashibanashi Manju', '稲城の昔ばなしまんじゅう', 'kanto', 'tokyo', 'A soft Japanese steamed bun created as an Inagi souvenir around local folktales and storytelling. The confection pairs a tender outer cake with a sweet filling, turning the city''s traditional narratives into a compact gift suitable for visitors and everyday tea service.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat', 150, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The confection was developed as a local Inagi souvenir inspired by the city''s traditional folktales. Its purpose is cultural as well as culinary, using wagashi to give local stories a portable form.', NULL, 'The phrase old folktales refers to traditional local stories passed between generations. The manju turns that cultural theme into a food souvenir rather than representing a single historic recipe.', ARRAY['{"01 Wheat Flour
 Flour forms the soft steamed outer cake.
 

 02 Sweet Bean Filling
 Sweet bean paste supplies the traditional wagashi-style filling.
 

 03 Sugar
 Sugar balances the filling and dough and gives the manju its gentle sweetness."}']::text[], 'ee-nah-gee moo-kah-she-bah-nah-she mahn-joo', NULL, ARRAY[]::text[], NULL),
('komatsuna', 'Komatsuna', '小松菜', 'kanto', 'tokyo', 'A dark green leafy vegetable strongly associated with Edogawa, where the Komatsugawa area gave the crop its name. Komatsuna has crisp stems and a mild sweetness, and today it is grown year-round, although its original peak season is winter when cool weather intensifies its flavor.', ARRAY['{"Winter"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 100, 300, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Komatsuna''s name is traditionally linked to the eighth shogun Tokugawa Yoshimune, who is said to have eaten local winter greens during a hawking visit and named them after Komatsugawa. Historical texts later confirm the reputation of the vegetable in the area.', NULL, 'Komatsuna can be harvested several times a year in modern cultivation, but winter remains its traditional season. Frost is said to make the leaves sweeter and more flavorful.', ARRAY['{"01 Komatsuna Leaves
 The dark leaves provide a mild mustardy note and high vegetable freshness.
 

 02 Komatsuna Stems
 Crisp stems give the vegetable its characteristic crunch.
 

 03 Natural Vegetable Sugars
 Cool-season growth concentrates sweetness, especially in traditional winter crops."}']::text[], 'koh-mah-tsoo-nah', NULL, ARRAY[]::text[], NULL),
('salad-komatsuna', 'Salad Komatsuna', 'サラダ小松菜', 'kanto', 'tokyo', 'A tender, mild form of komatsuna developed specifically for comfortable raw eating, with less bitterness and more perceived sweetness than traditional mature greens. The product was developed through an Edogawa agricultural-academic-public partnership and is marketed for salads, juices, and other uncooked uses.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 150, 400, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Salad Komatsuna was developed through a joint Edogawa agricultural, academic, and public-sector project studying the safety and nutritional value of eating komatsuna raw. After two years of research, the product was commercialized as a milder salad-oriented form.', NULL, 'The project specifically tested raw-eating suitability, which is why this version is much less assertive in taste than mature cooking greens. It can also be blended directly into juice.', ARRAY['{"01 Salad Komatsuna
 Tender leaves provide a mild flavor designed for raw eating.
 

 02 Crisp Stems
 The young stems add fresh crunch without requiring boiling.
 

 03 Natural Vegetable Sugars
 A sweeter taste helps the greens work in salads and fresh juices."}']::text[], 'sah-rah-dah koh-mah-tsoo-nah', NULL, ARRAY[]::text[], NULL),
('ome-senbei', 'Ome Senbei', '青梅せんべい', 'kanto', 'tokyo', 'A traditional rice-cracker-style confection associated with Ome, known for its light sweetness and crisp, delicate bite. The local souvenir is shaped and baked into thin pieces that travel well, making it a familiar tea-time gift from western Tokyo.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat', 300, 1000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Ome Senbei is a long-standing local confection associated with the city''s souvenir culture rather than a single documented inventor. Its style reflects the broader Japanese tradition of crisp baked sweets made for tea and gifting.', NULL, 'The crackers are particularly suited to tea because their modest sweetness lets the roasted grain aroma remain noticeable. Their dry texture also makes them easy to carry as a travel souvenir.', ARRAY['{"01 Rice Flour
 Rice provides the crisp, light structure associated with senbei.
 

 02 Wheat Flour
 A small amount of wheat-based flour contributes structure in the local recipe.
 

 03 Sugar
 Sugar gives the cracker its gently sweet finish."}']::text[], 'oh-meh sen-bay', NULL, ARRAY[]::text[], NULL),
('noshikon', 'Noshikon', 'のしこん', 'kanto', 'tokyo', 'A locally made konnyaku specialty associated with Ome, produced in thin rolled sheets rather than the standard rectangular blocks. The translucent pieces have a springy, pleasantly firm texture and are typically served chilled with a savory sauce or alongside other simple Japanese foods.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 200, 500, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Noshikon is a specialized local konnyaku product whose name comes from its rolled form. It belongs to Ome''s regional food tradition of working with konnyaku as a practical, low-cost staple ingredient.', NULL, 'Konnyaku has almost no inherent flavor, so texture is the main attraction. Chilling the slices and adding a concentrated dipping sauce makes the springy bite more pronounced.', ARRAY['{"01 Konnyaku Flour
 Konnyaku powder provides the gelatinous, elastic base.
 

 02 Water
 Water hydrates the konnyaku flour and creates the final firm gel texture.
 

 03 Alkaline Setting Agent
 A traditional alkaline ingredient helps the konnyaku mixture set into a stable gel."}']::text[], 'noh-she-kon', NULL, ARRAY[]::text[], NULL),
('bekko-sushi', 'Bekko Sushi', 'べっこう寿司', 'kanto', 'tokyo', 'A distinctive island sushi from Izu Oshima made by marinating slices of local fish in a sweet-savory soy sauce before placing them over vinegared rice. The marinade gives the fish a glossy amber-brown appearance, which explains the name referring to tortoiseshell.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy', 1000, 2000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Bekko sushi developed as a practical island preparation for seasoning fish with soy sauce and keeping its flavor appealing. The style became characteristic of Oshima''s food culture and is now treated as one of the island''s representative dishes.', NULL, 'The name bekko refers to tortoiseshell, a reference to the amber-brown shine created by the soy marinade. In Oshima, mustard is traditionally preferred with the sushi instead of wasabi.', ARRAY['{"01 Local White Fish
 Fish such as sawara is sliced thinly for marinating.
 

 02 Soy Sauce Marinade
 Soy sauce provides saltiness, umami, and the characteristic amber color.
 

 03 Vinegared Sushi Rice
 Lightly sweetened vinegared rice balances the savory fish and marinade."}']::text[], 'bek-koh zoo-she', NULL, ARRAY[]::text[], NULL),
('zako-teishoku', 'Zako Teishoku', 'ざこ定食', 'kanto', 'tokyo', 'A casual island set meal built around small local fish, often served grilled, fried, or simmered with rice and everyday side dishes. The concept reflects Oshima''s practical seafood cooking, where modest catches are turned into a satisfying complete meal rather than treated as luxury ingredients.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy', 800, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Zako teishoku is best understood as a local set-meal style using small fish rather than as one fixed historical recipe. Its roots lie in Oshima''s fishing households and the practical use of readily available catches.', NULL, 'The word zako refers broadly to small fish rather than one exact species. Because the term is flexible, the fish and preparation can vary with the day''s catch and the restaurant.', ARRAY['{"01 Small Local Fish
 The day''s small catch provides the central protein and can be grilled, fried, or simmered.
 

 02 Steamed Rice
 Plain rice provides a neutral base for the strongly flavored fish.
 

 03 Miso Soup and Seasonal Sides
 Soup and small vegetable dishes complete the balanced set-meal format."}']::text[], 'zah-koh tay-shoh-koo', NULL, ARRAY[]::text[], NULL),
('gyunu-senbei', 'Gyunu Senbei', '牛乳せんべい', 'kanto', 'tokyo', 'A crisp, lightly sweet milk biscuit from Izu Oshima, made into thin baked pieces that pair naturally with tea or coffee. The simple recipe reflects the island''s dairy connection and produces a dry, fragrant snack with a delicate snap.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains dairy, wheat, egg', 400, 1000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Milk Senbei became established as an Oshima souvenir using the island''s dairy connection and the Japanese tradition of producing crisp baked gift sweets. The exact commercial origin is associated with local confectionery makers rather than a single national inventor.', NULL, 'Despite its name, milk senbei is closer to a thin sweet biscuit than a savory rice cracker. The milky aroma becomes more noticeable when the biscuit is eaten with a warm drink.', ARRAY['{"01 Wheat Flour
 Wheat flour provides the biscuit''s structure.
 

 02 Milk
 Milk gives the cracker its gentle dairy aroma and pale finish.
 

 03 Sugar
 Sugar adds the restrained sweetness typical of the confection."}']::text[], 'gyoo-nyoo sen-bay', NULL, ARRAY[]::text[], NULL),
('omori-nori', 'Omori Nori', '大森の海苔', 'kanto', 'tokyo', 'A historic nori-producing tradition from Omori, where calm, nutrient-rich Tokyo Bay waters once supported one of Japan''s major seaweed-growing areas. Although cultivation ended in the 1960s, Omori remains a major center for nori wholesalers, grading, processing, and distribution.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 3000, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Nori cultivation began along the Omori-to-Shinagawa coast about three centuries ago, and Omori became a leading production area from the Meiji era through the early Showa period. Cultivation ended in 1963 after fishing rights were relinquished amid coastal development, but the local trade continued.', NULL, 'Omori was once important enough to spread nori cultivation and processing techniques to other parts of Japan. Today the area''s nori wholesalers still judge and process seaweed from production regions around the country.', ARRAY['{"01 Edible Seaweed
 Porphyra-type seaweed forms the raw material for dried nori sheets.
 

 02 Seawater Minerals
 The sea environment influences the mineral content and flavor of the growing seaweed.
 

 03 Toasting
 Gentle roasting develops the characteristic crisp texture and nutty aroma."}']::text[], 'oh-moh-ree no-ree', NULL, ARRAY[]::text[], NULL),
('shima-zushi', 'Shima-zushi', '島寿司', 'kanto', 'tokyo', 'A classic Ogasawara island sushi made with slices of local fish marinated in soy sauce and mirin before being placed over mildly sweet vinegared rice. Traditionally served with mustard instead of wasabi, the style is defined by its glossy fish, sweet-savory seasoning, and strong island identity.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains soy, gluten, fish', 1000, 2500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Shima-zushi grew from the island food culture of the Ogasawara Islands, where fish was seasoned before serving to suit island conditions and local tastes. The technique is a part of the broader Japanese island sushi tradition rather than a recipe credited to one inventor.', NULL, 'Ogasawara''s official tourism association specifically notes mustard rather than wasabi as the traditional accompaniment. The sweet vinegared rice helps balance the soy-based fish marinade.', ARRAY['{"01 Local White Fish
 Fish such as sawara is sliced for the soy-based marinade.
 

 02 Soy Sauce and Mirin
 The marinade gives the fish its savory sweetness and characteristic glossy color.
 

 03 Vinegared Rice
 Mildly sweetened sushi rice provides balance and structure."}']::text[], 'shee-mah zoo-she', NULL, ARRAY[]::text[], NULL),
('kame-ni', 'Kame-ni', '亀煮', 'kanto', 'tokyo', 'A traditional Ogasawara preparation of sea turtle cooked slowly with a savory-sweet seasoning until the meat becomes tender. It reflects the islands'' historical use of marine resources and is now best understood as part of Ogasawara''s heritage cuisine rather than an everyday food.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains turtle meat', 800, 2000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Kame-ni belongs to the traditional food culture of Ogasawara, where sea turtle was historically harvested and cooked as a local resource. Modern discussion of the dish is closely linked to the islands'' cultural history and contemporary wildlife protections.', NULL, 'The name simply means turtle simmered or braised. Because sea turtles are protected wildlife, this dish should not be treated as an ordinary freely available menu item.', ARRAY['{"01 Sea Turtle
 Historically harvested turtle provided the central meat, although present-day access is governed by conservation rules.
 

 02 Soy Sauce
 Soy sauce supplies the deep savory base of the braising liquid.
 

 03 Sugar and Sake
 Sweet and aromatic cooking seasonings balance the strong marine flavor."}']::text[], 'kah-meh nee', NULL, ARRAY[]::text[], NULL),
('same-burger', 'Same Burger', 'サメバーガー', 'kanto', 'tokyo', 'A modern Ogasawara specialty that replaces ordinary burger meat with locally caught shark, creating a firm, lean seafood filling inside a soft bun. The format turns a traditional island catch into an approachable contemporary street-food style and highlights the archipelago''s strong connection with fishing.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, gluten, egg', 600, 1200, 'Published', ARRAY['{"Quick bite","Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Shark burgers are a modern island-food development rather than an Edo-period traditional dish. The concept reflects Ogasawara''s contemporary effort to use local seafood in accessible dishes while giving visitors a distinctive taste of the islands.', NULL, 'Shark has a firmer texture than many mild white fish, which is why sauces and a soft bun work well with it. The burger format makes an unfamiliar island ingredient easier for visitors to try.', ARRAY['{"01 Local Shark
 Lean shark meat provides the firm seafood center.
 

 02 Wheat Burger Bun
 The soft bun balances the denser texture of the seafood.
 

 03 Sauce and Salad Vegetables
 Sauce, lettuce, or other toppings add moisture and freshness to the sandwich."}']::text[], 'sah-meh bah-gah', NULL, ARRAY[]::text[], NULL),
('shikaku-mame-tempura', 'Shikaku-mame Tempura', '四角豆の天ぷら', 'kanto', 'tokyo', 'A crisp vegetable tempura featuring winged bean, a warm-climate crop suited to the subtropical Ogasawara Islands. The beans are lightly battered and fried so their ridged, star-like cross-section stays visible, producing a delicate shell around a fresh, slightly grassy interior.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains gluten, fried in oil', 500, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite","Dine-in","Seasonal peak"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Winged bean is among the subtropical vegetables grown in Ogasawara, and tempura is a straightforward local way to showcase the crop. The dish reflects island adaptation to warm-climate agriculture rather than a single documented invention.', NULL, 'The winged ridges of the bean are edible, so the vegetable keeps an unusual sculptural appearance after frying. A light batter lets the fresh vegetable flavor remain noticeable.', ARRAY['{"01 Winged Beans
 Young winged beans provide the crisp, fresh vegetable center.
 

 02 Tempura Batter
 A light flour-and-water batter forms the delicate fried coating.
 

 03 Frying Oil
 Hot oil quickly sets the batter while keeping the interior fresh and green."}']::text[], 'she-kah-koo mah-meh ten-poo-rah', NULL, ARRAY[]::text[], NULL),
('akaba-miso-soup', 'Akaba Miso Soup', 'アカバの味噌汁', 'kanto', 'tokyo', 'A deeply savory fish soup made with akabha, the local name for red-spotted grouper, a prized reef fish of the Ogasawara Islands. The fish is simmered with miso to create a rich broth that combines a clean marine sweetness with the fermented depth of Japanese miso.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy', 600, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Akabha miso soup is a recognized Ogasawara island dish made from the fish locally called akabha, or red-spotted grouper. Its roots lie in island fishing cuisine and the practical use of prized reef fish in a nourishing soup.', NULL, 'The fish is considered a high-value local catch, so using it in miso soup turns bones and flavorful pieces into a particularly rich broth. The local name akabha refers to the red grouper family fish used in the dish.', ARRAY['{"01 Red-Spotted Grouper
 Akabha provides the fish''s clean marine sweetness and gelatin-rich texture.
 

 02 Miso
 Fermented soybean paste forms the salty, savory soup base.
 

 03 Dashi and Aromatics
 Stock ingredients and simple aromatics deepen the broth without masking the fish."}']::text[], 'ah-kah-bah mee-so soo-poo', NULL, ARRAY[]::text[], NULL),
('shima-lemon-jelly', 'Shima Lemon Jelly', '島レモンゼリー', 'kanto', 'tokyo', 'A bright jelly dessert made with Ogasawara''s distinctive island lemon, prized for its rounded shape, lively aroma, and relatively gentle acidity. The fruit is especially well suited to jelly because its juice and fragrant peel create a clean, refreshing citrus character.', ARRAY['{"Fall"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan (if agar used)', 300, 600, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Island lemon, also known as Kikuji lemon, was introduced to Ogasawara from Hachijojima after the islands returned to Japan. Local producers later developed products such as jelly and jam to showcase the fruit''s unusually mild acidity and fragrance.', NULL, 'Ogasawara island lemons are about one and a half times the size of ordinary lemons and can be eaten while still green. Their rounded shape and gentler acidity make them especially versatile for sweets.', ARRAY['{"01 Island Lemon Juice
 Fresh lemon juice supplies the bright citrus aroma and balanced acidity.
 

 02 Lemon Zest
 Finely grated peel intensifies the fragrance of the fruit.
 

 03 Gelatin or Jelly Setting Agent
 The setting ingredient creates the clean, trembling texture of the dessert."}']::text[], 'she-mah reh-mon zeh-ree', NULL, ARRAY[]::text[], NULL),
('okutama-yamame', 'Okutama Yamame', '奥多摩やまめ', 'kanto', 'tokyo', 'A farmed yamame trout specialty from the Okutama mountains, where clear, cold water supports the production of prized landlocked trout. The fish has a clean flavor and delicate flesh and is commonly served grilled, especially with salt, to preserve its subtle mountain-stream character.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish', 1000, 3000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Okutama Yamame is a regional aquaculture product developed around the area''s cold, clean mountain water. Modern hatchery production allows the local specialty to be supplied consistently while retaining the characteristics associated with mountain trout.', NULL, 'Yamame is a landlocked salmonid related to other Japanese trout. It is especially good grilled over charcoal or wood, where the skin develops a crisp aromatic edge.', ARRAY['{"01 Yamame Trout
 Freshwater trout supplies the delicate, clean-tasting flesh.
 

 02 Salt
 Salt is the classic seasoning for highlighting the fish''s subtle flavor.
 

 03 Mountain Water
 Cold, clean water is central to the character and production environment of the local fish."}']::text[], 'oh-koo-tah-mah yah-mah-meh', NULL, ARRAY[]::text[], NULL),
('okutama-wasabi', 'Okutama Wasabi', '奥多摩わさび', 'kanto', 'tokyo', 'A fragrant Japanese wasabi grown in the clean spring waters of Okutama, one of western Tokyo''s mountain food regions. The root has a fresh, green aroma and a brief, penetrating heat that is prized when freshly grated rather than stored for long periods.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 2000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Wasabi has been cultivated in Okutama''s cool mountain streams and spring-water environments as part of the region''s long agricultural tradition. The specialty depends on clean flowing water and shaded growing conditions rather than ordinary field cultivation.', NULL, 'Freshly grated wasabi delivers a short, nasal heat that fades much faster than the burn of dried horseradish powder. The finest aroma is noticeable immediately after grating.', ARRAY['{"01 Wasabi Rhizome
 The grated rhizome provides the signature green aroma and sharp heat.
 

 02 Clean Spring Water
 Cold, clear flowing water creates the conditions needed for high-quality wasabi cultivation.
 

 03 Wasabi Leaves and Stems
 The plant''s above-ground parts are also edible in local cooking and preserves."}']::text[], 'oh-koo-tah-mah wah-sah-bee', NULL, ARRAY[]::text[], NULL),
('sashimi-konnyaku', 'Sashimi Konnyaku', '刺身こんにゃく', 'kanto', 'tokyo', 'A chilled konnyaku preparation cut into thin slices and served like sashimi, prized more for its springy texture than for a strong flavor. The translucent pieces are usually paired with a savory dipping sauce, making the dish a light, refreshing counterpoint to richer mountain foods.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free (depending on sauce)', 400, 900, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Sashimi konnyaku comes from Japan''s long tradition of using konnyaku as a preserved mountain food. The Okutama version fits the area''s broader konnyaku-making culture, where clean water and locally processed konnyaku are valued regional foods.', NULL, 'Because konnyaku is mild on its own, the dipping sauce determines much of the finished flavor. Chilling the slices makes their springy texture especially refreshing.', ARRAY['{"01 Konnyaku
 Set konnyaku jelly provides the distinctive elastic texture.
 

 02 Clean Water
 Water is essential to the hydration and setting of the konnyaku.
 

 03 Miso or Soy-Based Sauce
 A savory dipping sauce supplies most of the dish''s salt, umami, and aroma."}']::text[], 'sah-shee-mee kon-nyah-koo', NULL, ARRAY[]::text[], NULL),
('kusa-dango', 'Kusa Dango', '草だんご', 'kanto', 'tokyo', 'A chewy rice dumpling flavored with aromatic yomogi leaves, traditionally served as a simple Japanese sweet with red bean paste. In Tokyo''s old neighborhood confectionery tradition, kusa dango is prized for its fresh green color, herbal fragrance, and pleasantly elastic bite.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free (typically)', 150, 600, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Kusa dango is a long-established Japanese wagashi style, traditionally made by mixing yomogi with pounded rice dough. Tokyo examples became associated with temple districts and long-running confectionery shops rather than one single inventor.', NULL, 'Yomogi gives kusa dango a grassy, slightly bitter fragrance that balances sweet bean paste. The strongest aroma is usually noticeable when the dumplings are freshly made.', ARRAY['{"01 Glutinous Rice Flour
 Rice flour creates the soft, chewy dumpling texture.
 

 02 Yomogi
 Mugwort provides the herbal fragrance and natural green color.
 

 03 Sweet Red Bean Paste
 Anko supplies the principal sweetness and creamy contrast."}']::text[], 'koo-sah dahn-goh', NULL, ARRAY[]::text[], NULL),
('kawazakana-ryori', 'Kawazakana Ryori', '川魚料理', 'kanto', 'tokyo', 'A broad style of freshwater fish cooking associated with Tokyo''s river communities, especially the mountain and waterside districts. Dishes vary by the catch and season but often emphasize simple grilling, simmering, or frying so the clean flavor of river fish remains central.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy, wheat', 2500, 6000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'River-fish cooking is much older than the modern municipality boundaries of Tokyo and grew from the practical use of local streams and rivers. The contemporary regional style preserves methods such as salt grilling, simmering, and frying rather than a single fixed recipe.', NULL, 'Freshwater fish are often best with restrained seasoning because their flavor is delicate. Eating the fish soon after cooking keeps the skin crisp and the flesh moist.', ARRAY['{"01 Freshwater Fish
 Trout, sweetfish, carp, or other river fish provide the central protein depending on location and season.
 

 02 Salt
 Salt grilling is one of the simplest traditional preparations.
 

 03 Soy or Miso Seasoning
 Simmered versions use savory Japanese seasonings instead of heavy spices."}']::text[], 'kah-wah-zah-kah-nah ryoh-ree', NULL, ARRAY[]::text[], NULL),
('motsuyaki', 'Motsuyaki', 'もつ焼き', 'kanto', 'tokyo', 'A classic Tokyo neighborhood dish of skewered pork offal grilled over high heat, especially associated with working-class drinking districts. The pieces are lightly charred and commonly seasoned with salt or a savory tare, giving them a smoky, intensely savory flavor.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains meat (pork/beef)', 100, 500, 'Published', ARRAY['{"Quick bite","Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Motsuyaki grew from the urban izakaya and street-food culture of twentieth-century Japan, where inexpensive offal was grilled quickly and served with drinks. Tokyo neighborhood shops developed their own sauces, cuts, and preferred grilling styles.', NULL, 'Different cuts have dramatically different textures, from tender liver to chewy intestine. Regular customers often have a favorite cut and seasoning, so mixed skewers are a useful introduction.', ARRAY['{"01 Pork Offal
 Intestine, liver, stomach, and other edible cuts provide the distinctive range of textures.
 

 02 Salt
 Salt highlights the natural savory flavor and grilled aroma.
 

 03 Sweet-Savory Tare
 A soy-based tare adds sweetness, umami, and a glossy charred finish."}']::text[], 'moh-tsoo-yah-kee', NULL, ARRAY[]::text[], NULL),
('takinogawa-gobo', 'Takinogawa Gobo', '滝野川ごぼう', 'kanto', 'tokyo', 'A historic long-rooted burdock associated with the Takinogawa area of northern Tokyo, known for its strong aroma and firm, flavorful flesh. The local variety became famous as a traditional vegetable and is valued in simmered dishes, kinpira, and other preparations that reward its distinctive bite.', ARRAY['{"Fall"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 1500, 'Published', ARRAY['{"Vegetarian","Halal","Dine-in","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Takinogawa burdock was cultivated in Edo-period Tokyo and became a recognized local vegetable of the Takinogawa district. The variety is part of the city''s heritage vegetable tradition and later declined as modern compact varieties became more convenient for growers.', NULL, 'The long roots can be difficult to harvest without specialized soil preparation. Their firm texture makes them particularly good for simmering and kinpira-style cooking.', ARRAY['{"01 Takinogawa Burdock
 The heritage root provides a firm bite and deep earthy aroma.
 

 02 Water
 Soaking the cut root in water helps manage browning and prepares it for cooking.
 

 03 Soy-Based Seasoning
 Soy sauce, sugar, or mirin brings out the burdock''s savory-sweet character."}']::text[], 'tah-kee-noh-gah-wah goh-boh', NULL, ARRAY[]::text[], NULL),
('kiyose-bo', 'Kiyose Bo', 'きよせ棒', 'kanto', 'tokyo', 'A crunchy vegetable snack from Kiyose made with local carrot and burdock powders, created around the city''s strong root-vegetable production. The kinpira-burdock flavor combines savory seasoning with a light, crisp texture, making the snack suitable for casual eating, drinks, or souvenirs.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains soy, wheat', 410, 410, 'Published', ARRAY['{"Quick bite"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Kiyose Bo was launched to mark the centenary of Kiyose Station and uses powders made from locally associated carrots and burdock. The product was designed as a contemporary souvenir that turns local produce into a shelf-stable snack.', NULL, 'The original kinpira-burdock flavor uses both carrot and burdock powders, linking the snack to Kiyose''s vegetable-growing identity. A later corn-potage version was also introduced using local corn.', ARRAY['{"01 Burdock Powder
 Burdock supplies the earthy, savory vegetable character.
 

 02 Carrot Powder
 Carrot adds gentle sweetness and reinforces the local root-vegetable theme.
 

 03 Kinpira Seasoning
 Soy-based savory seasoning gives the snack its familiar Japanese side-dish flavor."}']::text[], 'kee-yoh-seh boh', NULL, ARRAY[]::text[], NULL),
('kiyose-man', 'Kiyose Man', '清瀬まん', 'kanto', 'tokyo', 'A chilled savory bun from Kiyose filled with spiced keema-style curry and local corn, with a later version adding Kiyose-grown carrots. The result combines warm curry spices with the natural sweetness of local vegetables in a convenient steamed-bun format.', ARRAY['{"Fall"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, meat, soy', 350, 350, 'Published', ARRAY['{"Quick bite","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Kiyose Man was launched by the Kiyose Tourism Association as a regional product using Kiyose-grown ingredients. The revived version added local carrots to the earlier corn-and-keema curry filling to soften the spice and increase vegetable depth.', NULL, 'The current version uses the sweet kernels of locally grown corn and carrot to mellow the curry''s spice. The product became popular enough in its first release to sell out quickly.', ARRAY['{"01 Keema Curry Filling
 Spiced minced-meat curry provides the savory center.
 

 02 Kiyose Corn
 Fresh local corn adds sweetness and texture.
 

 03 Kiyose Carrot
 Carrot contributes sweetness, color, and a gentle finish that softens the spice."}']::text[], 'kee-yoh-seh mahn', NULL, ARRAY[]::text[], NULL),
('kunitachi-brewery-craft-beer', 'Kunitachi Brewery Craft Beer', 'くにぶる', 'kanto', 'tokyo', 'A craft beer brewed by KUNITACHI BREWERY, Kunitachi''s first craft brewery, established in 2020 by the long-running local sake retailer Sekiya. The brewery explores classic beer styles and experimental small-batch ideas, including beers inspired by Kunitachi''s history and urban identity.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan', 600, 1500, 'Published', ARRAY['{"Vegetarian","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'KUNITACHI BREWERY was established in 2020 by Sekiya, a sake retailer with more than a century of history. The brewery was created under the philosophy that old traditions can support new experiments in local brewing.', NULL, 'One of its beers, 1926, takes its name and design cues from Kunitachi Station''s historic station building. The brewery therefore uses local history as part of the beer''s identity.', ARRAY['{"01 Malted Barley
 Malted grain provides fermentable sugars and the malt backbone of the beer.
 

 02 Hops
 Hops contribute bitterness and aromatic character according to the style.
 

 03 Brewing Water
 Water provides the base for fermentation and influences the beer''s final balance."}']::text[], 'koo-nee-boo-roo', NULL, ARRAY[]::text[], NULL),
('kinmedai-no-nitsuke', 'Kinmedai no Nitsuke', '金目鯛の煮付け', 'kanto', 'tokyo', 'A classic island preparation of splendid alfonsino simmered slowly in a sweet-savory soy broth until the flesh becomes tender and aromatic. On the Izu Islands, the dish highlights a prized local catch with a gentle balance of soy, sugar, and cooking sake.', ARRAY['{"Winter"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy, wheat', 2000, 5000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Simmered kinmedai is rooted in Izu island fishing cuisine, where the fish has long been treated as a valuable catch. The technique is a traditional Japanese method rather than a dish credited to a single inventor.', NULL, 'The dark red skin is one reason kinmedai is visually distinctive before cooking. Simmering with a sweet soy broth also helps keep the delicate flesh moist.', ARRAY['{"01 Splendid Alfonsino
 Kinmedai provides tender, mildly sweet meat with a rich gelatinous skin.
 

 02 Soy Sauce
 Soy sauce forms the savory base of the braising liquid.
 

 03 Sugar and Cooking Sake
 Sweetness and sake balance the saltiness and round out the fish''s flavor."}']::text[], 'keen-meh-dye no nee-tsoo-keh', NULL, ARRAY[]::text[], NULL),
('toyosu-market-kaisendon', 'Toyosu Market Kaisendon', '豊洲市場の海鮮丼', 'kanto', 'tokyo', 'A market-style seafood rice bowl built around fresh sashimi toppings served over seasoned rice at Toyosu Market. Menus vary by shop and catch, but the concept emphasizes abundant seafood, careful selection, and the energetic atmosphere of Tokyo''s wholesale market.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy, wheat', 2000, 6000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Seafood rice bowls are a modern market dining tradition that developed around Tokyo''s wholesale seafood trade. At Toyosu, restaurants continue the tradition established at the former Tsukiji market, including shops with histories extending back more than a century.', NULL, 'Some Toyosu seafood bowl shops trace their business history to the old Nihonbashi and Tsukiji markets. The actual seafood selection changes with market supply, so there is no single fixed topping list.', ARRAY['{"01 Sushi Rice
 Seasoned rice provides the neutral, lightly acidic base.
 

 02 Fresh Sashimi Seafood
 Tuna and other market seafood provide the main flavor and visual variety.
 

 03 Soy Sauce
 A small amount of soy sauce seasons the seafood and rice at the table."}']::text[], 'toh-yoh-soo ee-chee-bah no kye-sen-don', NULL, ARRAY[]::text[], NULL),
('koganei-sakura-junmai-ginjo', 'Koganei Sakura Junmai Ginjo', '小金井桜純米吟醸', 'kanto', 'tokyo', 'A junmai ginjo sake associated with Koganei''s celebrated cherry-blossom landscape, combining polished rice with the fragrant, clean style expected from ginjo brewing. The local branding connects the sake with Koganei''s historic cherry trees and the city''s broader cultural identity.', ARRAY['{"Spring"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 1500, 4000, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The sake was developed as a local regional product linking Koganei with its famous cherry-tree heritage. Its identity is cultural and contemporary, drawing on the city''s historic cherry landscape rather than an ancient sake recipe.', NULL, 'Junmai ginjo is brewed from rice, koji, and water without added distilled alcohol, with rice polished to the ginjo range. Serving it slightly chilled generally makes its aroma easier to appreciate.', ARRAY['{"01 Polished Rice
 Highly polished sake rice provides a clean fermentation base.
 

 02 Rice Koji
 Koji converts rice starch into fermentable sugars during brewing.
 

 03 Brewing Water
 Water shapes the fermentation and final texture of the sake."}']::text[], 'koh-gah-nay sah-koo-rah joon-my geen-joh', NULL, ARRAY[]::text[], NULL),
('fight-monaka', 'Fight Monaka', 'ファイトもなか', 'kanto', 'tokyo', 'A playful monaka confection from Kokubunji built around the city''s local identity and the idea of encouragement. Crisp wafer shells hold a sweet filling, creating the familiar contrast of delicate shell, smooth center, and a compact shape designed for gifting.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat', 200, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Fight Monaka is a locally branded Kokubunji confection rather than a historic Edo recipe. Its concept uses the familiar Japanese monaka format to create a positive, memorable regional souvenir.', NULL, 'Monaka wafers become crisper when kept dry, while humidity quickly softens them. Eating the confection soon after opening preserves the best shell-to-filling contrast.', ARRAY['{"01 Glutinous Rice Wafer
 Thin rice wafers form the crisp outer shell.
 

 02 Sweet Bean Paste
 Smooth or lightly textured anko provides the creamy filling.
 

 03 Sugar
 Sugar balances the filling and contributes to the traditional wagashi sweetness."}']::text[], 'fye-toh moh-nah-kah', NULL, ARRAY[]::text[], NULL),
('kate-udon', 'Kate Udon', '糧うどん', 'kanto', 'tokyo', 'A traditional Musashino-style noodle meal in which thick wheat noodles are eaten with a warm dipping broth enriched by seasonal vegetables. Known as a filling rural food, Kate Udon reflects the old practice of pairing hand-made noodles with whatever vegetables and pantry ingredients were available.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, fish (broth)', 800, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Kate Udon developed from the everyday food culture of the Musashino farming area, where wheat noodles were paired with vegetables to create a filling household meal. The name refers to food or provisions served with the noodles rather than to one single historical recipe.', NULL, 'Traditional versions use abundant vegetables because the noodles were designed to stretch a meal with farm produce. The contrast between firm noodles and hot dipping broth is central to the style.', ARRAY['{"01 Wheat Noodles
 Hand-made wheat noodles provide the firm, chewy base.
 

 02 Seasonal Vegetables
 Leafy greens and root vegetables add sweetness, texture, and nutrition.
 

 03 Soy-Based Dipping Broth
 Dashi, soy sauce, and cooking seasonings create the warm savory sauce."}']::text[], 'kah-teh oo-don', NULL, ARRAY[]::text[], NULL),
('komae-honey', 'Komae Honey', '狛江はちみつ', 'kanto', 'tokyo', 'A locally harvested honey from urban hives in Komae, produced from nectar collected around the city''s gardens, farms, and streets. Its flavor varies with the flowering season and neighborhood forage, giving the honey a distinctly local character rather than a fixed single-flower profile.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegetarian, Gluten-free', 800, 2500, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Komae Honey emerged from local beekeeping and community efforts to connect urban agriculture with the city''s flowering landscape. It is a contemporary regional product rather than an old recipe, with character shaped by the plants visited by local bees.', NULL, 'Because bees forage across changing flowers, the flavor can shift from batch to batch and season to season. This is one reason locally harvested urban honey can taste different from supermarket blended honey.', ARRAY['{"01 Flower Nectar
 Nectar from local blossoms provides the sugars and aromatic compounds that define the honey.
 

 02 Honeycomb
 Bees naturally process stored nectar in the comb before it is harvested.
 

 03 Seasonal Floral Sources
 Cherry, acacia, fruit trees, garden flowers, and other blossoms can influence the final profile."}']::text[], 'koh-mah-eh hah-chee-mee-tsoo', NULL, ARRAY[]::text[], NULL),
('sable-manju-komae', 'Sable Manju Komae', 'サブレー万頭こまえ', 'kanto', 'tokyo', 'A Komae souvenir confection that combines the buttery texture of a sablé-style cookie with the soft filled form of a manju. The hybrid design gives the sweet a crisp, rich exterior and a smooth center while serving as a compact edible symbol of the city.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 150, 400, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Sablé Manju Komae is a modern regional confection developed as part of Komae''s local gift program. It deliberately combines two familiar Japanese and Western-style confectionery ideas to create a product identified with the city.', NULL, 'The name describes the hybrid concept: sablé texture outside and manju-style filling inside. It is best eaten at room temperature so the aroma of the buttery shell can open fully.', ARRAY['{"01 Wheat Flour
 Flour forms the sablé-style outer shell.
 

 02 Butter
 Butter creates the rich aroma and crumbly cookie texture.
 

 03 Sweet Filling
 A smooth bean or confectionery filling supplies the soft center and sweetness."}']::text[], 'sah-boo-reh mahn-joo koh-mah-eh', NULL, ARRAY[]::text[], NULL),
('komae-jomon-madeleine', 'Komae Jomon Madeleine', 'こまえ縄文マドレーヌ', 'kanto', 'tokyo', 'A Komae souvenir madeleine inspired by the city''s Jomon archaeological heritage, combining a familiar French-style baked cake with a local historical motif. The result is a moist, buttery sweet designed as a cultural gift linking modern baking with the city''s prehistoric identity.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 200, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Jomon Madeleine was developed as a Komae regional souvenir that connects modern confectionery with the city''s archaeological identity. The concept is contemporary and commemorative rather than an ancient Jomon food recreation.', NULL, 'The product should not be confused with an archaeological reconstruction of Jomon cuisine. Its purpose is to use a familiar Western-style cake to tell a local historical story.', ARRAY['{"01 Wheat Flour
 Flour provides the basic cake structure.
 

 02 Egg
 Egg gives the madeleine its tender, rich crumb.
 

 03 Butter and Sugar
 Butter supplies aroma while sugar provides the characteristic sweetness and browning."}']::text[], 'koh-mah-eh joh-mon mah-doh-reh-noo', NULL, ARRAY[]::text[], NULL),
('oden-croquette', 'Oden Croquette', 'おでんコロッケ', 'kanto', 'tokyo', 'A creative Shinagawa snack that folds familiar oden-style ingredients into a crisp croquette. The filling is soft and savory, echoing the broth-rich flavor of oden while the breadcrumb crust adds the crunch expected from a freshly fried korokke.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, egg, soy, fish', 150, 300, 'Published', ARRAY['{"Quick bite"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Oden croquette is a modern local-food idea associated with Shinagawa''s long history as a lodging and transport district. It adapts two familiar Japanese comfort foods into one portable snack rather than tracing to a single traditional inventor.', NULL, 'The most recognizable feature is the contrast between oden''s soft, broth-seasoned filling and the crisp croquette crust. It is a useful example of contemporary Tokyo fusion within everyday street food.', ARRAY['{"01 Potato or Croquette Base
 Mashed potato or another starchy base binds the filling.
 

 02 Oden Ingredients
 Daikon, fish cake, konnyaku, or similar cooked items carry the oden-inspired flavor.
 

 03 Panko Breadcrumbs
 Japanese breadcrumbs create the crisp fried shell."}']::text[], 'oh-den koh-rok-keh', NULL, ARRAY[]::text[], NULL),
('edomae-anago', 'Edomae Anago', '江戸前穴子', 'kanto', 'tokyo', 'A Tokyo-style preparation of conger eel harvested from the bay and traditionally simmered, grilled, or served over rice. Edomae anago is prized for its tender flesh and clean marine sweetness, while careful simmering or glazing creates the soft, glossy texture associated with classic Tokyo sushi and tempura shops.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy, wheat', 1500, 4000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Edomae anago belongs to the broader Edo-period practice of using seafood caught in Tokyo Bay close to the capital. The tradition developed through Tokyo''s sushi, tempura, and eel shops rather than around one single named creator.', NULL, 'The term Edomae refers to seafood associated with the waters in front of old Edo. Anago is generally milder and less oily than unagi, which is why it works especially well with light simmering and sushi.', ARRAY['{"01 Conger Eel
 Edomae anago supplies tender, mildly sweet white flesh.
 

 02 Soy-Based Tare
 A sweet-savory sauce adds gloss and concentrated umami.
 

 03 Cooking Sake and Sugar
 These seasonings soften the flavor and build the classic glazed finish."}']::text[], 'eh-doh-mah-eh ah-nah-goh', NULL, ARRAY[]::text[], NULL),
('harajuku-crepe', 'Harajuku Crepe', '原宿クレープ', 'kanto', 'tokyo', 'A thin, flexible French-style crepe transformed into a colorful Harajuku street sweet, commonly filled with whipped cream, fruit, ice cream, chocolate, or other toppings. Marion Crepes helped establish the wrapped, take-away format that became one of Harajuku''s most recognizable youth-culture foods.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains gluten, dairy, egg', 500, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Marion Crepes opened in Harajuku in 1976 and became an important part of the neighborhood''s crepe culture. The company developed its take-away presentation around Harajuku''s growing youth fashion and shopping scene.', NULL, 'The paper-wrapped cone is a key part of the experience because it turns a dessert into a portable street snack. Seasonal fruit and changing fashion trends have continually influenced the fillings sold in Harajuku.', ARRAY['{"01 Wheat-Flour Crepe
 A thin batter forms the flexible pancake wrapper.
 

 02 Whipped Cream
 Cream adds richness and a light texture to sweet versions.
 

 03 Fresh Fruit and Dessert Toppings
 Fruit, chocolate, custard, ice cream, or other toppings create the layered flavor and visual appeal."}']::text[], 'hah-rah-joo-koo koo-reh-poo', NULL, ARRAY[]::text[], NULL),
('omoide-yokocho-yakitori', 'Omoide Yokocho Yakitori', '焼き鳥（思い出横丁）', 'kanto', 'tokyo', 'A quintessential grilled-chicken street food associated with Shinjuku''s compact Omoide Yokocho lanes, where small yakitori counters cook skewers over intense charcoal heat. The atmosphere is as important as the food, with smoke, red lanterns, and tiny seats reinforcing the district''s nostalgic postwar izakaya character.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains meat (chicken), soy (if tare glaze used)', 150, 500, 'Published', ARRAY['{"Quick bite","Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Omoide Yokocho developed in the postwar period as a compact drinking and food district near Shinjuku Station. Yakitori became a defining part of the lane''s everyday dining culture, with many small shops specializing in grilled skewers.', NULL, 'The lanes are famous for very small restaurants, many seating only a handful of customers. Ordering a few skewers with a cold drink is the classic way to experience the district''s food culture.', ARRAY['{"01 Chicken Cuts
 Thigh, skin, liver, heart, and other cuts provide different textures and levels of richness.
 

 02 Bamboo Skewers
 Skewers hold the pieces together for quick, high-heat grilling.
 

 03 Salt or Tare
 Seasoning highlights the char while adding either clean savoriness or sweet-salty depth."}']::text[], 'yah-kee-toh-ree', NULL, ARRAY[]::text[], NULL),
('ogikubo-ramen', 'Ogikubo Ramen', '荻窪ラーメン', 'kanto', 'tokyo', 'A Tokyo ramen style from Ogikubo known for a dark, aromatic soy-based broth and straightforward noodle-and-topping presentation. The style grew around neighborhood Chinese restaurants and ramen shops, developing a reputation for a clean yet deeply savory soup rather than the heavier richness of later regional ramen forms.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains gluten, pork, fish, soy', 800, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Ogikubo ramen emerged in the early twentieth-century neighborhood restaurant culture of western Tokyo and became especially established after the war. It is associated with small local ramen shops and a soy-forward Tokyo style rather than a single inventor.', NULL, 'The style is often described as lighter and more soy-focused than creamy regional ramen. The flavor is especially apparent when the broth is served hot and the noodles are eaten immediately.', ARRAY['{"01 Wheat Ramen Noodles
 Wheat noodles provide the chewy base.
 

 02 Soy-Based Broth
 Chicken, fish, or other stock is seasoned with soy sauce for the signature savory depth.
 

 03 Pork and Aromatic Toppings
 Chashu, menma, scallions, and nori provide texture and fragrance."}']::text[], 'oh-gee-koo-boh rah-men', NULL, ARRAY[]::text[], NULL),
('chanko-nabe', 'Chanko Nabe', 'ちゃんこ鍋', 'kanto', 'tokyo', 'A substantial hot pot associated with sumo wrestlers and the Ryogoku district, combining meat, seafood, tofu, and vegetables in a shared simmering broth. Rather than one fixed recipe, chanko is a flexible protein-rich meal whose exact ingredients and seasoning vary by stable and restaurant.', ARRAY['{"Winter"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains meat, fish (broth), soy, wheat', 2000, 6000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Chanko developed as the communal cooking of sumo stables, where wrestlers needed hearty, balanced meals in large quantities. As professional sumo became closely associated with Ryogoku, chanko restaurants brought the style to a wider public.', NULL, 'There is no single official chanko recipe: salt, soy, miso, and other broths are all used. Many restaurants finish the meal with rice or noodles after the main ingredients are eaten.', ARRAY['{"01 Chicken or Seafood
 Protein-rich meat and fish form the foundation of the hot pot.
 

 02 Seasonal Vegetables
 Cabbage, negi, mushrooms, carrots, and other vegetables add sweetness and texture.
 

 03 Dashi-Based Broth
 Dashi with salt, soy sauce, or miso creates the flavorful cooking medium."}']::text[], 'chahn-koh nah-beh', NULL, ARRAY[]::text[], NULL),
('chomeiji-sakura-mochi', 'Chomeiji Sakura Mochi', '長命寺桜もち', 'kanto', 'tokyo', 'A delicate Tokyo-style sakura mochi consisting of sweet bean paste wrapped in a thin pink crepe-like rice layer and enclosed in a fragrant salted cherry leaf. Chomeiji''s version is especially famous for its thin wrapping, subtle saltiness, and long association with Mukojima''s cherry-blossom season.', ARRAY['{"Spring"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Contains wheat', 200, 500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Chomeiji Sakura Mochi is associated with Yamamoto Shinroku, who is traditionally credited with creating it at the Chomeiji temple area in the early Edo period. The confection was developed as a sweet accompaniment to the area''s famous cherry blossoms.', NULL, 'The salted leaf is edible and is traditionally eaten with the confection, although some diners prefer to remove it. Its gentle saltiness keeps the sweet bean filling from becoming overly rich.', ARRAY['{"01 Sweet Bean Paste
 Smooth anko provides the main sweetness and creamy center.
 

 02 Thin Rice Flour Wrapper
 The pale pink wrapper forms a delicate, crepe-like shell around the bean paste.
 

 03 Salted Sakura Leaf
 Pickled cherry leaves contribute aroma and a gentle salty accent."}']::text[], 'choh-may-jee sah-koo-rah moh-chee', NULL, ARRAY[]::text[], NULL),
('daikan-mochi', 'Daikan Mochi', '代官餅', 'kanto', 'tokyo', 'A local mochi specialty associated with Setagaya''s Daikan tradition, made from soft pounded rice and typically finished with sweet or savory toppings. Its appeal lies in the fresh, stretchy texture of freshly made mochi and the contrast between the neutral rice base and rich toppings.', ARRAY['{"Only available Dec 15-16 and Jan 15-16"}']::text[], ARRAY['{"local specialty"}']::text[], 'Dairy-free. Contains soy. Anko and Kinako flavors are naturally gluten-free.', 700, 800, 'Published', ARRAY['{"Vegetarian","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Daikan Mochi is a neighborhood confection associated with Setagaya''s local food culture rather than a universally standardized historical recipe. The name and style reflect the area''s traditional sweet-making and festival food customs.', NULL, 'Fresh mochi becomes firmer as it cools, so the best texture is usually achieved soon after pounding and shaping. Kinako-coated pieces are especially aromatic while still warm.', ARRAY['{"01 Glutinous Rice
 Pounded sticky rice provides the soft, stretchy mochi base.
 

 02 Kinako or Red Bean
 Toppings supply roasted soybean aroma or sweet bean richness depending on the version.
 

 03 Sugar
 Sugar balances the topping and adds the characteristic sweetness of the confection."}']::text[], 'dye-kahn mo-chee', NULL, ARRAY[]::text[], NULL),
('okura-daikon', 'Okura Daikon', '大蔵大根', 'kanto', 'tokyo', 'A heritage Japanese daikon associated with Setagaya''s Okura district, known for its unusually thick, long root and firm white flesh. The variety is valued for strong texture and clear flavor and can be used in simmered dishes, pickles, soups, and fresh preparations.', ARRAY['{"Winter (November to February)"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan and Gluten-free (as a base ingredient).', 300, 1200, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Okura Daikon is a traditional Setagaya vegetable associated with the old agricultural landscape around Okura. Modern local programs preserve the variety as a heritage crop despite the convenience of shorter commercial daikon.', NULL, 'Its long roots are well suited to traditional simmered dishes because the flesh keeps a pleasant structure while absorbing broth. The variety is also striking when displayed whole because of its size.', ARRAY['{"01 Okura Daikon
 The heritage root provides crisp texture and a clean radish aroma.
 

 02 Dashi
 Japanese stock carries the daikon''s flavor in simmered preparations.
 

 03 Soy Sauce or Miso
 Savory seasoning adds depth while allowing the root''s natural sweetness to remain clear."}']::text[], 'oh-koo-rah dye-kohn', NULL, ARRAY[]::text[], NULL),
('ningyoyaki', 'Ningyoyaki', '人形焼', 'kanto', 'tokyo', 'A small Tokyo confection of sweet batter baked in decorative molds and traditionally filled with sweet red bean paste. Asakusa''s ningyoyaki are especially recognizable for their compact shapes and crisp-golden exterior, making them a classic street snack and souvenir around Sensoji.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, egg, dairy', 100, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Ningyoyaki developed in Tokyo as a molded confection during the Meiji-era growth of neighborhood sweets, with Asakusa becoming a famous center for the style. The shapes often reflect the area''s local imagery and festive character.', NULL, 'Fresh ningyoyaki are soft and fragrant, while cooled pieces become slightly firmer. The red bean filling is traditionally balanced so it does not overwhelm the delicate cake.', ARRAY['{"01 Wheat-Flour Batter
 A lightly sweetened wheat batter forms the browned shell.
 

 02 Eggs
 Eggs enrich the cake and help create its tender texture.
 

 03 Sweet Red Bean Paste
 Anko supplies the traditional filling and deep sweetness."}']::text[], 'neen-gyoh-yah-kee', NULL, ARRAY[]::text[], NULL),
('dojo-nabe', 'Dojo Nabe', 'どぜう鍋', 'kanto', 'tokyo', 'A traditional Tokyo hot pot of dojo loach cooked until tender in a rich soy-based broth, often served with a large quantity of sliced negi. Asakusa is especially associated with dojo cuisine, where the dish reflects Edo''s old preference for hearty, affordable river-fish cooking.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish, soy, wheat', 2000, 5000, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Dojo hot pot is an Edo-period dish that became closely associated with the Asakusa area. Specialized shops such as Komagata Dojo are part of a long restaurant tradition built around this small freshwater fish and its slow cooking methods.', NULL, 'The name refers specifically to dojo loach, not eel. Large amounts of negi are traditionally added during the meal so the onion gradually wilts into the broth.', ARRAY['{"01 Dojo Loach
 Small loaches provide the central fish flavor and soft texture.
 

 02 Negi
 Large amounts of sliced green onion add sweetness and aroma.
 

 03 Soy-Based Broth
 Dashi, soy sauce, mirin, and other seasonings create the dark savory cooking liquid."}']::text[], 'doh-joh nah-beh', NULL, ARRAY[]::text[], NULL),
('kaminari-okoshi', 'Kaminari Okoshi', '雷おこし', 'kanto', 'tokyo', 'A crisp rice-and-sugar confection strongly associated with Asakusa''s Kaminarimon area, where the name evokes thunder and the dramatic sound of lightning. Puffed grains are bound with a sweet syrup and molded into crunchy pieces that are easy to carry as a classic temple-town souvenir.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains peanuts', 300, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Kaminari Okoshi became established as a souvenir around Sensoji and Kaminarimon, where sweet makers sold the crunchy confection to temple visitors. Its name and popularity are closely tied to Asakusa''s long history as a pilgrimage and entertainment district.', NULL, 'The name combines thunder imagery with the Japanese word okoshi, creating a memorable local souvenir name. The crunchy texture also makes the sweet particularly durable for travel.', ARRAY['{"01 Puffed Rice or Grains
 Puffed grain provides the light, crisp structure.
 

 02 Sugar Syrup
 Cooked sugar binds the grains into cohesive clusters.
 

 03 Flavoring Ingredients
 Peanuts, sesame, or other additions may provide roasted aroma and extra crunch depending on the product."}']::text[], 'kah-mee-nah-ree oh-koh-she', NULL, ARRAY[]::text[], NULL),
('edo-style-tendon', 'Edo-style Tendon', '江戸前天丼', 'kanto', 'tokyo', 'A classic Tokyo tempura rice bowl topped with crisp seafood and vegetables fried in a light batter, then seasoned with a sweet-savory tare. Edomae versions emphasize seafood historically associated with Tokyo Bay and the distinctive contrast between hot tempura, steamed rice, and dark sauce.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains gluten, soy, fish, crustacean (shrimp)', 1500, 4000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Tendon developed in Tokyo''s Edo-period food culture as tempura vendors and restaurants paired fried seafood with rice. The Edomae designation connects the dish to seafood historically caught close to the old city in Tokyo Bay.', NULL, 'The deepest flavor often comes from the sauce that seeps into the rice beneath the tempura. Eating the crisp pieces first and then mixing a little tare into the rice gives two different textures in one bowl.', ARRAY['{"01 Shrimp and Seafood
 Edomae-style toppings commonly feature seafood suited to tempura.
 

 02 Tempura Batter
 Flour, egg, and cold water create the light, crisp coating.
 

 03 Sweet Soy Tare
 A reduced soy-based sauce balances sweetness, saltiness, and umami over the rice."}']::text[], 'eh-doh-mah-eh ten-don', NULL, ARRAY[]::text[], NULL),
('udora-yaki-udo-manju', 'Udora-yaki & Udo Manju', 'ウドラ焼き・うどまんじゅう', 'kanto', 'tokyo', 'A pair of local Tachikawa sweets that turn the city''s mascot Udora and its agricultural identity into edible souvenirs. The baked and steamed formats use familiar Japanese confectionery techniques while giving the products a distinctly local shape and theme.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, egg, soy', 280, 400, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Udora-yaki and Udo Manju were developed as contemporary Tachikawa regional sweets around the city''s mascot and local image. They are souvenir products rather than old traditional dishes, using familiar wagashi formats to express a modern civic identity.', NULL, 'The name Udora combines the city mascot with familiar confectionery names. The products show how local makers adapt classic Japanese sweets for modern city branding.', ARRAY['{"01 Wheat-Flour Cake or Wrapper
 Flour forms the baked dora-yaki shell or steamed manju exterior.
 

 02 Sweet Filling
 Red bean or another confectionery filling supplies the main sweetness.
 

 03 Sugar
 Sugar enriches the batter or dough and balances the filling."}']::text[], 'oo-doh-rah-yah-kee / oo-doh-mahn-joo', NULL, ARRAY[]::text[], NULL),
('tachikawa-yakiton', 'Tachikawa Yakiton', '立川やきとん', 'kanto', 'tokyo', 'A Tachikawa-style grilled pork-offal skewer dish served over charcoal and paired with a neighborhood drinking culture. The skewers are typically cooked quickly at high heat, producing smoky browned edges and tender or pleasantly chewy textures across different cuts.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains pork, soy', 150, 600, 'Published', ARRAY['{"Quick bite","Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Yakiton became widespread in Tokyo''s postwar drinking districts as an affordable counterpart to chicken yakitori. Tachikawa developed its own local shops and style through this broader urban street-and-izakaya food tradition.', NULL, 'The word yakiton specifically refers to pork rather than chicken. Ordering several different cuts is the best way to experience how dramatically texture changes from one skewer to another.', ARRAY['{"01 Pork Offal
 Liver, intestine, heart, cheek, and other cuts form the core of yakiton.
 

 02 Charcoal
 High heat creates the smoky, browned surface characteristic of grilled skewers.
 

 03 Salt or Tare
 Seasoning adds either clean savoriness or a deeper sweet-salty glaze."}']::text[], 'tah-chee-kah-wah yah-kee-ton', NULL, ARRAY[]::text[], NULL),
('tachikawa-pudding', 'Tachikawa Pudding', '立川ぷりん', 'kanto', 'tokyo', 'A smooth custard pudding developed as a Tachikawa local sweet, emphasizing a rich eggy body and soft, creamy texture. The dessert is designed as an accessible souvenir or café treat, using the familiar Japanese pudding format while building a distinct local identity.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains egg, dairy', 680, 700, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Tachikawa Pudding is a contemporary local confection rather than a centuries-old dish. Its regional identity comes from modern local makers who adapt the familiar Japanese custard-pudding format into a city souvenir.', NULL, 'Japanese pudding is usually softer and smoother than traditional Western baked custards. Eating it chilled makes the caramel and creamy egg texture particularly distinct.', ARRAY['{"01 Eggs
 Eggs create the custard structure and rich flavor.
 

 02 Milk and Cream
 Dairy ingredients provide a smooth, creamy mouthfeel.
 

 03 Sugar and Caramel
 Sugar sweetens the custard while cooked caramel contributes a pleasant bitter edge."}']::text[], 'tah-chee-kah-wah poo-reen', NULL, ARRAY[]::text[], NULL),
('sakura-polvoron', 'Sakura Polvoron', '桜ぽるぼろん', 'kanto', 'tokyo', 'A delicate baked sweet from Tama inspired by traditional Spanish polvoron and finished with salted cherry blossoms grown in Tama. Its dry, crumbly texture carries a distinctive sweet-salty balance, turning local cherry flavor into a modern tea-time souvenir.', ARRAY['{"Spring"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 500, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Sakura Polvoron was developed through the Tama City hand-gift project, a collaboration between local industry, government, and education. The product took inspiration from traditional Spanish polvoron and incorporated salted cherry blossoms produced in Tama.', NULL, 'Polvoron is deliberately crumbly and is meant to dissolve rather than chew like a cookie. The salt from the cherry blossom keeps the sweet dough from tasting flat.', ARRAY['{"01 Wheat Flour
 Flour forms the delicate crumbly structure.
 

 02 Salted Cherry Blossoms
 Local salted blossoms add floral aroma and a subtle salty accent.
 

 03 Sugar and Fat
 Sugar provides sweetness while butter or another baking fat creates the characteristic melt-in-the-mouth texture."}']::text[], 'sah-koo-rah poh-roo-boh-ron', NULL, ARRAY[]::text[], NULL),
('tama-no-sanpomichi', 'Tama no Sanpomichi', '多摩の散歩道', 'kanto', 'tokyo', 'A baked karinto snack from Tama made from local wheat noodles and Tama miso, then finished with a sweet-savory coating rather than deep-frying. It comes in a sweet miso flavor and a chili-miso version, providing a crisp tea snack with clear local ingredients.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy', 300, 800, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Tama no Sanpomichi was developed as a baked karinto using noodles from the city''s Ponpoko Udon and Tama-grown miso. The product reflects a modern effort to create a shelf-stable souvenir from existing local agricultural products.', NULL, 'Unlike ordinary karinto, this product is baked rather than fried. The chili-miso version uses locally grown chili and sesame oil to add heat and extra savoriness.', ARRAY['{"01 Local Wheat Noodle
 Tama-produced wheat noodles form the crisp base.
 

 02 Tama Miso
 Local miso supplies the fermented savory depth.
 

 03 Sugar and Chili
 Sugar creates the sweet glaze, while chili provides heat in the spicy version."}']::text[], 'tah-mah no sahn-poh-mee-chee', NULL, ARRAY[]::text[], NULL),
('ponpoko-udon', 'Ponpoko Udon', 'ぽんぽこうどん', 'kanto', 'tokyo', 'A local Tama noodle specialty made from regional wheat flour and served as a hearty Japanese udon. The noodles have a firm, satisfying bite and are used in both hot broth dishes and as a base for local products such as Tama no Sanpomichi baked karinto.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, fish (in broth)', 500, 1200, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Ponpoko Udon belongs to Tama City''s local food development around locally grown wheat and the region''s agricultural identity. The same noodles were later used as an ingredient in the city''s baked karinto product, creating a linked local-food story.', NULL, 'Using local wheat changes the noodle''s texture and aroma compared with highly refined commercial flour. Serving the noodles freshly cooked best preserves their firm bite.', ARRAY['{"01 Tama Wheat Flour
 Local wheat provides the main starch base and grain aroma.
 

 02 Water
 Water hydrates the flour and develops the dough''s final texture.
 

 03 Salt
 Salt strengthens the dough and helps create the firm udon bite."}']::text[], 'pon-poh-koh oo-don', NULL, ARRAY[]::text[], NULL),
('tsukishima-monjayaki', 'Tsukishima Monjayaki', '月島もんじゃ焼き', 'kanto', 'tokyo', 'Tokyo''s most famous monjayaki district centers on a thin, dashi-rich batter cooked with cabbage and toppings directly on a tabletop griddle. Tsukishima''s version is distinguished less by one fixed recipe than by its communal cooking style, tiny metal spatulas, and deep roster of neighborhood shops.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, seafood, meat (varies)', 1000, 2500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Monjayaki was already part of Tokyo''s working-class food culture before Tsukishima became its best-known modern center. From the postwar period onward, the neighborhood''s many small shops turned monja into a destination food and a defining part of local identity.', NULL, 'The tiny spatula is not just a serving utensil: diners use it to scrape up the crispest browned pieces directly from the hot plate. Different shops also develop their own signature combinations of toppings.', ARRAY['{"01 Dashi Batter
 Flour mixed with dashi provides the characteristic loose base.
 

 02 Cabbage
 Finely chopped cabbage adds sweetness and soft texture.
 

 03 Seafood, Meat, and Toppings
 Shrimp, squid, pork, cheese, mochi, and other toppings create each shop''s signature version."}']::text[], 'tsoo-kee-she-mah mon-jah-yah-kee', NULL, ARRAY[]::text[], NULL),
('tsukiji-tamagoyaki', 'Tsukiji Tamagoyaki', '築地の玉子焼き', 'kanto', 'tokyo', 'A thick, softly layered Japanese omelet associated with the Tsukiji fish market, where tamagoyaki became a familiar accompaniment to sushi and seafood meals. The flavor can range from gently sweet to savory, but the hallmark is a smooth, moist texture built from repeatedly folded egg.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains egg, fish (dashi), soy', 100, 300, 'Published', ARRAY['{"Quick bite"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Tamagoyaki vendors became part of Tsukiji''s food-market ecosystem, supplying sushi shops, restaurants, and shoppers. The style reflects the market''s role as a center for seafood and prepared-food trade rather than a single documented invention.', NULL, 'A well-made tamagoyaki is softer than an ordinary omelet because the egg is cooked in many thin layers. The exact seasoning is a shop signature, so sweetness varies noticeably between vendors.', ARRAY['{"01 Eggs
 Fresh eggs create the layered structure and rich flavor.
 

 02 Dashi
 Japanese stock adds savory depth and moisture.
 

 03 Sugar and Soy Sauce
 Sugar and soy balance sweetness, salt, and umami according to the shop''s recipe."}']::text[], 'tsoo-kee-jee no tah-mah-goh-yah-kee', NULL, ARRAY[]::text[], NULL),
('ginza-omurice', 'Ginza Omurice', '銀座のオムライス', 'kanto', 'tokyo', 'A refined Western-style rice omelet associated with Ginza''s long restaurant tradition, pairing seasoned chicken rice with a softly cooked egg layer and sauce. Unlike heavily decorated modern versions, classic Ginza examples emphasize clean technique, balanced seasoning, and polished presentation.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains egg, poultry, wheat, soy', 1500, 3000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Omurice emerged in Japan in the early twentieth century as a Western-influenced restaurant dish. Ginza''s department stores, cafés, and yoshoku restaurants helped develop refined versions, but the dish is not tied to one universally accepted Ginza inventor.', NULL, 'The goal of a classic soft omurice is a barely set egg center that breaks open over the rice. Timing is crucial because the egg continues cooking from residual heat after leaving the pan.', ARRAY['{"01 Eggs
 Eggs create the soft outer layer and rich mouthfeel.
 

 02 Seasoned Rice
 Rice cooked with chicken, onion, and sauce provides the savory filling.
 

 03 Tomato or Demi-Glace Sauce
 Sauce adds acidity, umami, and color to the finished omelet."}']::text[], 'geen-zah no oh-moo-rye-soo', NULL, ARRAY[]::text[], NULL),
('jindaiji-soba', 'Jindaiji Soba', '深大寺そば', 'kanto', 'tokyo', 'A historic soba tradition centered on Jindaiji Temple in Chofu, where buckwheat was cultivated and ground for temple hospitality. The noodles are appreciated for their clean buckwheat aroma and firm texture and are commonly served with a simple dipping sauce around the temple''s many long-established soba shops.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Contains buckwheat, soy', 800, 1500, 'Published', ARRAY['{"Vegetarian","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Jindaiji Soba is traditionally traced to the Edo period, when farmers in the fertile upland north of the temple grew buckwheat and supplied flour to Jindaiji. The temple prepared the noodles for visitors, and the style became famous after a high-ranking imperial prince praised the soba in the Genroku era.', NULL, 'The Chofu tourism association notes that around twenty soba shops now cluster near Jindaiji. Soba flour is also used locally in related sweets and other specialty dishes.', ARRAY['{"01 Buckwheat Flour
 Buckwheat gives the noodles their characteristic aroma and firm bite.
 

 02 Wheat Flour
 A small proportion helps bind the noodles during kneading.
 

 03 Dipping Tsuyu
 Dashi, soy sauce, and mirin create the savory sauce used with chilled noodles."}']::text[], 'jeen-dye-jee soh-bah', NULL, ARRAY[]::text[], NULL),
('seiro-soba', 'Seiro Soba', 'せいろそば', 'kanto', 'tokyo', 'A classic presentation of chilled Japanese soba served on a slatted bamboo tray with a concentrated dipping sauce on the side. The format emphasizes the fragrance, firm bite, and clean finish of properly cooked buckwheat noodles rather than surrounding them with heavy toppings.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains buckwheat, soy', 700, 1500, 'Published', ARRAY['{"Vegetarian","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Seiro soba is a long-established presentation style within Japanese soba cuisine rather than a dish invented in modern Tokyo. Serving noodles on a bamboo tray became especially associated with refined soba shops and the custom of eating noodles with concentrated tsuyu.', NULL, 'The dipping sauce is intentionally stronger than a soup broth because only the end of the noodle is dipped. This keeps more of the buckwheat aroma on the first bite.', ARRAY['{"01 Buckwheat Noodles
 Buckwheat provides the main aroma and earthy flavor.
 

 02 Wheat Flour
 Wheat helps bind the noodle dough and improves elasticity.
 

 03 Concentrated Tsuyu
 Dashi, soy sauce, and mirin provide the dipping sauce''s intense savory character."}']::text[], 'say-roh soh-bah', NULL, ARRAY[]::text[], NULL),
('mori-soba', 'Mori Soba', 'もりそば', 'kanto', 'tokyo', 'A simple serving of chilled soba noodles arranged on a tray and eaten with a separate dipping sauce. Mori soba highlights the noodles themselves, with no broth surrounding them, making it one of the clearest ways to judge buckwheat aroma, texture, and cooking quality.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains buckwheat, soy', 600, 1200, 'Published', ARRAY['{"Vegetarian","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Mori soba developed as a classic way of serving chilled buckwheat noodles in Japanese soba culture. The format is older than modern Tokyo and became standard in soba shops because it keeps the noodles at the center of the meal.', NULL, 'The name distinguishes noodles served on a tray from soba served in hot broth. A small amount of noodle is dipped rather than completely submerged to preserve aroma and prevent over-seasoning.', ARRAY['{"01 Buckwheat Flour
 Buckwheat supplies the characteristic earthy fragrance.
 

 02 Wheat Flour
 Wheat strengthens the dough and helps the noodles hold together.
 

 03 Tsuyu
 A concentrated dashi-soy dipping sauce provides the main seasoning."}']::text[], 'moh-ree soh-bah', NULL, ARRAY[]::text[], NULL),
('shio-daifuku', 'Shio Daifuku', '塩大福', 'kanto', 'tokyo', 'A soft daifuku rice cake filled with sweet red bean paste and balanced by a noticeable touch of salt. The contrast between chewy mochi, creamy anko, and restrained salinity gives this Tokyo favorite a clean finish and keeps the filling from tasting overly sweet.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 150, 400, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Dine-in"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Shio daifuku belongs to the modern family of Japanese daifuku sweets and became especially popular in Tokyo confectionery shops during the twentieth century. The defining idea is the deliberate use of salt to sharpen the bean filling.', NULL, 'A small amount of salt can make a sweet filling taste fuller and more aromatic. This is why shio daifuku often tastes less sugary than its appearance suggests.', ARRAY['{"01 Glutinous Rice
 Sticky rice flour creates the soft, elastic mochi wrapper.
 

 02 Sweet Red Bean Paste
 Anko provides the creamy, sweet center.
 

 03 Salt
 A small amount balances the sugar and intensifies the bean flavor."}']::text[], 'shee-oh dye-foo-koo', NULL, ARRAY[]::text[], NULL),
('otafuku-mame', 'Otafuku Mame', 'お多福豆', 'kanto', 'tokyo', 'Large fava beans slowly cooked in a sweet syrup to create a glossy, deeply seasoned Japanese confection, often associated with traditional sweets shops. The beans become tender while retaining their shape, producing a substantial bite and a gentle contrast between bean flavor and concentrated sweetness.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains soy', 500, 1200, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Otafuku bean sweets belong to the long Japanese tradition of simmering large beans in sugar syrup for preservation and confectionery use. Tokyo shops adapted the style as a tea sweet and gift item rather than treating it as a single regional recipe.', NULL, 'The word otafuku is a traditional expression associated with a cheerful, fortunate woman, giving the sweet a positive name. The beans are often served in small portions because the syrup is concentrated.', ARRAY['{"01 Fava Beans
 Large beans provide the substantial, creamy center.
 

 02 Sugar
 Sugar creates the glossy syrup and preserves the beans.
 

 03 Soy Sauce
 A small amount can deepen the syrup and provide savory balance in some traditional recipes."}']::text[], 'oh-tah-foo-koo mah-meh', NULL, ARRAY[]::text[], NULL),
('tsubaki-oil', 'Tsubaki Oil', '椿油', 'kanto', 'tokyo', 'A clear, fragrant plant oil pressed from camellia seeds, with Toshima Island being a historic Tokyo source. Tsubaki oil has a mild flavor and excellent stability and is used both as a culinary oil and in traditional hair and skin care, reflecting the island''s close relationship with camellia trees.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 1000, 3000, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Camellia has long been cultivated on Toshima, and pressing its seeds into oil became an important island industry. Traditional production was closely tied to household use and local commerce and remains a characteristic Toshima product today.', NULL, 'Camellia oil is rich in oleic acid, which helps explain its stability and smooth mouthfeel. Its mild flavor makes it usable for cooking without dominating delicate ingredients.', ARRAY['{"01 Camellia Seeds
 Pressed camellia seeds provide the oil and its subtle nutty aroma.
 

 02 Mechanical Pressing
 Traditional pressing extracts the oil without adding a strong external flavor.
 

 03 Filtration
 Filtration removes seed particles and produces the clear finished oil."}']::text[], 'tsoo-bah-kee oy-roo', NULL, ARRAY[]::text[], NULL),
('8-tier-soft-serve-daily-chico', '8-Tier Soft Serve - Daily Chico', '8段ソフトクリーム（デイリーチコ）', 'kanto', 'tokyo', 'A towering soft-serve creation from Daily Chico in Nakano''s Nakano Broadway, famous for stacking eight flavors into a single tall cone. The appeal is visual as much as edible, with contrasting colors, aromas, and flavors layered vertically into one oversized serving.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains dairy', 700, 900, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Daily Chico became known through Nakano Broadway for serving its multi-flavor soft-serve, with the eight-flavor tower becoming a signature attraction. The concept is a modern dessert spectacle rather than a traditional Japanese confection.', NULL, 'The serving is unusually tall, so eating it steadily from top to bottom helps prevent melting and collapse. Flavor combinations can change with the menu.', ARRAY['{"01 Milk-Based Soft Serve
 A creamy soft-serve base carries the individual flavor layers.
 

 02 Flavor Mixes
 Fruit, chocolate, coffee, or other flavorings create the contrasting tiers.
 

 03 Waffle Cone
 A crisp cone supports the tall soft-serve stack and adds a toasted wheat note."}']::text[], 'hah-chee-dahn so-foo-toh koo-ree-moo', NULL, ARRAY[]::text[], NULL),
('oyaki-refu-tei', 'Oyaki - Refu-tei', 'おやき（おやき処 れふ亭）', 'kanto', 'tokyo', 'A stuffed Japanese griddle cake sold by Refutei in Nakano, with a soft, lightly browned outer dough surrounding a sweet or savory filling. The shop''s version presents the familiar oyaki format as a quick neighborhood snack, easy to eat warm and by hand.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, egg, dairy', 150, 300, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Oyaki itself originates in central Japan, especially Nagano, where filled flour cakes became a practical staple food. Refutei adapted the familiar style for Nakano as a convenient Tokyo snack rather than claiming to have invented oyaki.', NULL, 'Oyaki fillings vary widely, from sweet bean to vegetables and miso-seasoned ingredients. The same dough can therefore serve as either a snack or a light savory meal.', ARRAY['{"01 Flour Dough
 Wheat flour forms the soft, lightly crisp outer cake.
 

 02 Filling
 Vegetables, miso, sweet bean, or other fillings provide the main flavor depending on the variety.
 

 03 Seasoning
 Savory versions may use miso or soy while sweet versions rely on sugar and bean paste."}']::text[], 'oh-yah-kee reh-foo-tay', NULL, ARRAY[]::text[], NULL),
('kusaya', 'Kusaya', 'くさや', 'kanto', 'tokyo', 'A strongly aromatic fermented fish specialty from the Izu Islands, made by salting and drying fish in a repeatedly used fermentation brine known as kusaya-jiru. The result has an intense smell but a surprisingly savory, concentrated flavor that is traditionally grilled and paired with rice or drinks.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish', 800, 2000, 'Published', ARRAY[]::text[], 'Not vegetarian', 'Not halal', TRUE, 'Kusaya developed on the Izu Islands as a preservation method for fish in an environment where salt was valuable. Reusing the fermentation brine created the distinctive flavor, and the technique was passed down through island households and producers.', NULL, 'The fermentation liquid, kusaya-jiru, is deliberately preserved and reused from batch to batch. This makes the smell powerful but also gives the fish a complex savory taste that regular dried fish does not have.', ARRAY['{"01 Horse Mackerel or Flying Fish
 Small oily fish are commonly used because they dry and ferment well.
 

 02 Kusaya-Jiru
 The traditional fermented brine gives the fish its signature aroma and umami.
 

 03 Salt
 Salt controls preservation and helps concentrate the fish during drying."}']::text[], 'koo-sah-yah', NULL, ARRAY[]::text[], NULL),
('asahi-karinto', 'Asahi Karinto', 'かりんとう (旭製菓)', 'kanto', 'tokyo', 'A classic Japanese karinto produced by Asahi Seika in Nishitokyo, where fried wheat dough is coated with a crisp sugar glaze. The result is crunchy, fragrant, and lightly caramelized, with a long shelf life that has helped make karinto a familiar tea snack and gift.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, sesame', 300, 1000, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Asahi Seika is a long-established confectionery maker in western Tokyo, producing karinto as part of the region''s traditional snack industry. Karinto itself is a much older Japanese sweet, while the company''s local identity comes from its continued production and product variations.', NULL, 'Karinto is fried rather than baked, which creates its characteristic blistered crunch. The sugar coating also acts as a protective layer, helping the snack stay crisp when kept dry.', ARRAY['{"01 Wheat Flour Dough
 Wheat flour forms the crisp fried core.
 

 02 Frying Oil
 Hot oil cooks the dough and develops its toasted aroma.
 

 03 Sugar Syrup
 Cooked sugar creates the hard, crunchy shell around the fried pieces."}']::text[], 'kah-reen-toh', NULL, ARRAY[]::text[], NULL),
('nerima-daikon-takuan', 'Nerima Daikon Takuan', '練馬大根の沢庵漬け', 'kanto', 'tokyo', 'A traditional Japanese pickle made from Nerima daikon, the long white radish historically grown around Nerima Ward, and cured in salt and rice bran. The result is crisp, savory, mildly sweet, and strongly aromatic, representing one of Tokyo''s best-known heritage-vegetable preservation foods.', ARRAY['{"Winter"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains Rice Bran and Salt. Gluten-Free and Vegan.', 400, 800, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Nerima daikon was cultivated in the Edo period and became famous around the capital, while takuan preservation offered a practical way to keep the large roots through winter. The local pickle tradition later declined with urbanization but survives as a heritage food.', NULL, 'Takuan is traditionally cured in rice bran rather than simply soaked in vinegar. The crisp texture is strongest when the pickle is sliced thinly and served with plain rice.', ARRAY['{"01 Nerima Daikon
 The long heritage radish provides the firm vegetable base.
 

 02 Rice Bran
 Nuka controls fermentation and develops the characteristic pickle aroma.
 

 03 Salt
 Salt draws out moisture, seasons the radish, and supports the curing process."}']::text[], 'Neh-ree-mah Die-kon Tah-koo-ahn', NULL, ARRAY[]::text[], NULL),
('nerima-daikon-manju', 'Nerima Daikon Manju', '練馬大根まんじゅう', 'kanto', 'tokyo', 'A clever and adorable sweet confection shaped exactly like a realistic miniature Nerima Daikon radish. Created by the 120-year-old historical shop Okashitsukasa Kimura-ya, this unique traditional treat wraps smooth sweet red bean paste inside a soft, steamed dough made from freshly grated yam and rice flour. It is celebrated as one of the ward''s most creative gourmet gifts.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains Wheat, Dairy, Soy, and Red Bean. Vegetarian-friendly.', 150, 300, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Invented in the year 2000 by the fourth-generation master chef of Okashitsukasa Kimura-ya. He wanted to design a fun, visual souvenir that younger travelers and children could easily enjoy while learning about the area''s agricultural history.', NULL, 'Wrapped in a soft, steamed dough made from freshly grated yam and rice flour, it yields gently to reveal a deeply satisfying, smooth red bean paste inside.', ARRAY['{"01 Soft Steamed Dough Base
A tender, elegant exterior crafted from a traditional blend of grated yam and jōyoko (rice flour), yielding a soft, steamed texture rather than a hard snap.

02 Smooth Red Bean Center
Generously filled with homemade koshian (smooth, pureed sweet red bean paste) to provide a deep, earthy sweetness at its core.

03 Hand-Crafted Finish
Carefully shaped by hand, gently steamed, and meticulously finished with a delicate touch of green nerikiri to complete the radish illusion."}']::text[], 'Neh-ree-mah Die-kon Mahn-joo', NULL, ARRAY[]::text[], NULL),
('nerima-daifuku', 'Nerima Daifuku', 'ねりま大福', 'kanto', 'tokyo', 'A soft daifuku associated with Nerima''s local confectionery culture, using chewy mochi around a sweet filling and often incorporating local themes into the product design. It follows the familiar Japanese balance of elastic rice cake and smooth bean paste while serving as an approachable district souvenir.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains Glutinous Rice, Red Bean, and Salted Radish Leaves. Gluten-Free and Vegan.', 160, 200, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Nerima Daifuku is a modern district-branded confection rather than a centuries-old standalone recipe. Its regional identity comes from incorporating Nerima''s local imagery and confectionery makers into the familiar daifuku format.', NULL, 'Fresh daifuku is highly sensitive to drying, so the softest texture is found soon after production. The rice cake is intentionally thin enough to let the filling dominate the bite.', ARRAY['{"01 Glutinous Rice
 Rice flour creates the chewy mochi wrapper.
 

 02 Sweet Red Bean Paste
 Anko provides the principal sweet filling.
 

 03 Sugar
 Sugar sweetens the filling and dough and helps balance the rice cake''s neutral flavor."}']::text[], 'Neh-ree-mah Die-foo-koo', NULL, ARRAY[]::text[], NULL),
('nerima-sabl', 'Nerima Sablé', '練馬サブレ', 'kanto', 'tokyo', 'A crisp butter sablé created as a Nerima souvenir, using a simple European-style biscuit format to express local character through its name, shape, or packaging. The cookie is light, buttery, and crisp, making it a practical gift that pairs naturally with coffee or tea.', ARRAY['{"All year"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains Wheat, Butter, Eggs, and Sugar. Vegetarian-friendly.', 80, 120, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Nerima Sablé is a modern local confection sold as a regional gift by Chikushido. It uses the established French sablé technique and adds local identity through the product concept rather than recreating an old Japanese sweet.', NULL, 'Sablé means sandy in French, referring to the crumbly texture created by a rich, short dough. Keeping the cookie dry is essential because humidity quickly dulls the crisp texture.', ARRAY['{"01 Wheat Flour
 Flour provides the cookie''s crisp structure.
 

 02 Butter
 Butter creates the rich aroma and sandy crumb.
 

 03 Sugar
 Sugar provides sweetness and helps the edges brown during baking."}']::text[], 'Neh-ree-mah Sah-boo-reh', NULL, ARRAY[]::text[], NULL),
('hachioji-ramen', 'Hachioji Ramen', '八王子ラーメン', 'kanto', 'tokyo', 'A Tokyo ramen style distinguished by a soy-based soup topped with finely chopped raw onion and fragrant oil. Hachioji ramen is known for its clean, dark broth and the sweet sharpness of onion, creating a straightforward bowl in which the garnish plays an essential role.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, pork', 600, 1000, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Hachioji ramen developed in neighborhood ramen shops during the postwar period and became recognized for its distinctive onion topping. Unlike many regional ramen styles, it is defined by a small set of consistent elements rather than a single founding restaurant.', NULL, 'The chopped onion softens slightly in the hot broth while retaining a fresh bite. The aromatic oil helps spread its sweetness through the soup as you eat.', ARRAY['{"01 Wheat Ramen Noodles
 Medium-width noodles provide the chewy base.
 

 02 Soy-Seasoned Broth
 Chicken, fish, or other stock is seasoned with soy sauce for the dark savory soup.
 

 03 Chopped Onion and Aromatic Oil
 Fresh onion gives sweetness and crunch while aromatic oil rounds the broth."}']::text[], 'hah-chee-oh-jee rah-men', 'N/A', ARRAY[]::text[], NULL),
('hachijo-shochu', 'Hachijo Shochu', '八丈焼酎', 'kanto', 'tokyo', 'A distinctive island shochu tradition from Hachijojima, where local producers make sweet-potato and barley styles using traditional koji fermentation. The spirits can be robust and aromatic, reflecting the island''s long history of household-scale brewing adapted into licensed local production.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 1500, 4000, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hachijo shochu developed from traditional island distilling practices and was later adapted into licensed commercial production. The style is associated with local households and producers rather than a single inventor, with sweet potato and barley forming the main raw materials.', NULL, 'Hachijojima is unusual in Tokyo for maintaining a recognizable island shochu tradition alongside distinctive agricultural ingredients. Water and koji choices can make producers'' spirits taste noticeably different.', ARRAY['{"01 Sweet Potatoes or Barley
 Producers use sweet potato, barley, or blends depending on the style.
 

 02 Koji
 Koji supplies the enzymes that convert starches into fermentable sugars.
 

 03 Island Water
 Local water supports fermentation and dilution of the finished spirit."}']::text[], 'hah-chee-joh shoh-choo', 'N/A', ARRAY[]::text[], NULL),
('hachijo-fruit-lemon', 'Hachijo Fruit Lemon', '八丈フルーツレモン', 'kanto', 'tokyo', 'An unusually large island lemon from Hachijojima, prized for its fragrant peel, juicy flesh, and balanced acidity. The fruit is substantially larger than an ordinary lemon and is used not only for juice but also in sweets and drinks where its aromatic skin is especially valuable.', ARRAY['{"Winter"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 1500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hachijo fruit lemon is a regional citrus associated with Hachijojima''s subtropical climate and distinctive island agriculture. The local specialty is prized for its size and aroma and has become a recognized Tokyo island product.', NULL, 'The fruit can be used while still green, and its thick, aromatic peel is valuable in confectionery. The unusually large fruit also makes a striking visual centerpiece in gift boxes.', ARRAY['{"01 Hachijo Fruit Lemon
 The whole fruit supplies the characteristic juice and citrus aroma.
 

 02 Fragrant Peel
 Thick peel provides essential oils that intensify the scent.
 

 03 Natural Citrus Sugars and Acids
 Balanced sweetness and acidity create the fruit''s clean, lively flavor."}']::text[], 'hah-chee-joh foo-roo-tsoo reh-mon', 'N/A', ARRAY[]::text[], NULL),
('karuta-senbei-hamurin-senbei', 'Karuta Senbei / Hamurin Senbei', 'かるたせんべい・はむりんせんべい', 'kanto', 'tokyo', 'Two Hamura souvenir crackers that turn local civic imagery into simple, crisp baked snacks. Karuta Senbei uses the idea of traditional Japanese picture-card culture, while Hamurin Senbei features the city''s mascot, giving visitors an edible keepsake with a light, dry crunch.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains soy', 300, 800, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'These senbei were developed as contemporary Hamura souvenirs rather than inherited recipes. The products use familiar Japanese cracker-making techniques and local imagery to create city-branded snacks.', NULL, 'Karuta-inspired packaging turns a plain cracker into a small cultural souvenir. The dry texture also makes senbei particularly suitable for carrying home without refrigeration.', ARRAY['{"01 Rice Flour
 Rice forms the crisp cracker base.
 

 02 Seasoning
 Sugar, soy, or other recipe-specific seasoning gives the cracker its flavor.
 

 03 Printed Decoration
 An edible printed or stamped image connects the cracker to Hamura''s local theme."}']::text[], 'kah-roo-tah sen-bay / hah-moo-reen sen-bay', 'N/A', ARRAY[]::text[], NULL),
('hamura-no-seki', 'Hamura no Seki', '羽村の堰', 'kanto', 'tokyo', 'A historic Tamagawa water-control structure in Hamura rather than a dish or food product. The weir is included in the dataset as a local heritage landmark, so its accurate profile describes the waterworks themselves instead of inventing culinary characteristics.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'N/A', 0, 0, 'Published', ARRAY['{"Vegetarian"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'The Hamura Weir is part of the Tamagawa Josui system created in the Edo period to bring clean water toward Edo. It is a civil-engineering landmark, not a traditional food, and its importance lies in Tokyo''s water history.', NULL, 'Because this record is a landmark rather than a dish, there are no ingredients or eating rituals to describe accurately. It should be treated as a cultural heritage entry or removed from a culinary-only dataset.', ARRAY['{"01 Tama River
 The river supplies the water controlled by the weir.
 

 02 Weir Structure
 The barrier regulates and directs river flow.
 

 03 Tamagawa Josui
 The weir forms part of the historic water-supply infrastructure leading toward Tokyo."}']::text[], 'hah-moo-rah no seh-kee', 'N/A', ARRAY[]::text[], NULL),
('sakura-sable-sazareishi', 'Sakura Sable / Sazareishi', '桜サブレー・さざれ石', 'kanto', 'tokyo', 'A pair of Hamura souvenir sweets pairing a buttery sakura-themed sablé with a separate confection named Sazareishi. The products use familiar baked-sweet techniques and local imagery to create compact gifts connected to Hamura''s cherry-blossom and civic landscape.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 400, 1000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'These products are contemporary Hamura souvenirs created by local confectionery makers, not ancient local recipes. Their identity comes from cherry-blossom imagery and regional naming rather than a historical dish.', NULL, 'Sablé cookies are especially good with tea because their butter aroma and dry crumb do not overwhelm delicate drinks. The name Sazareishi evokes a small stone, giving the pair a local naming theme.', ARRAY['{"01 Wheat Flour
 Flour forms the crisp sablé structure.
 

 02 Butter and Sugar
 Butter supplies richness while sugar creates sweetness and browning.
 

 03 Sakura Flavor or Decoration
 Cherry blossom imagery or ingredients provide the local seasonal theme."}']::text[], 'sah-koo-rah sah-boo-reh / sah-zah-reh-ee-she', 'N/A', ARRAY[]::text[], NULL),
('noka-no-nidango', 'Noka no Nidango', '農家の煮ぃだんご', 'kanto', 'tokyo', 'A rustic village-style dumpling dish from Higashikurume in which simple wheat dumplings are simmered with vegetables in a savory broth. The dish reflects the practical cooking of Tokyo''s former farm households, where flour and seasonal produce were combined into a filling one-pot meal.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat, soy', 500, 1200, 'Published', ARRAY['{"Vegetarian","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Noka no Nidango belongs to the household food tradition of eastern Musashino farming communities. The dish grew from practical use of wheat and vegetables rather than being invented by a known chef or commercial shop.', NULL, 'The dumplings are intentionally irregular because they were shaped by hand rather than cut into uniform noodles. The texture becomes pleasantly chewy as the pieces simmer in the broth.', ARRAY['{"01 Wheat Dough Dumplings
 Simple flour-and-water dough forms the chewy dumpling pieces.
 

 02 Seasonal Vegetables
 Daikon, carrot, greens, or other local produce provide sweetness and color.
 

 03 Dashi or Soy Broth
 A savory broth carries the vegetable and wheat flavors through the dish."}']::text[], 'noh-kah no nee-dahn-goh', 'N/A', ARRAY[]::text[], NULL),
('wasanbon-kogei-kashi', 'Wasanbon Kogei Kashi', '和三盆工芸菓子', 'kanto', 'tokyo', 'A delicate decorative confection shaped from wasanbon sugar into finely detailed forms, combining the clean sweetness of traditional Japanese sugar craft with the visual precision of miniature sculpture. These sweets are intended to be admired before dissolving gently on the tongue.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 800, 2000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Wasanbon craft sweets belong to Japan''s traditional sugar-art culture and are made using techniques developed over generations. The Higashikurume local product presents that broader craftsmanship as a refined gift item rather than claiming a single local inventor.', NULL, 'Wasanbon sugar has a fine crystalline texture that dissolves quickly in the mouth. The confection is often appreciated as much for its carving and molding detail as for its flavor.', ARRAY['{"01 Wasanbon Sugar
 Fine-grained traditional sugar provides the clean sweetness and delicate texture.
 

 02 Food-Safe Molds
 Molds create the precise decorative shapes.
 

 03 Natural Flavoring
 Tea, seasonal color, or subtle flavoring may be used depending on the craft piece."}']::text[], 'wah-sahn-bon koh-gay kah-she', 'N/A', ARRAY[]::text[], NULL),
('higashimurayama-black-yakisoba', 'Higashimurayama Black Yakisoba', '東村山黒焼きそば', 'kanto', 'tokyo', 'A distinctive yakisoba from Higashimurayama colored dark by a local sauce and cooked with noodles, meat, and vegetables on a hot griddle. Its savory, slightly sweet flavor comes from the sauce and caramelized noodles, giving the dish a darker appearance than ordinary Tokyo yakisoba.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, squid', 600, 1200, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Higashimurayama Black Yakisoba is a modern local specialty developed to distinguish the city through its own sauce-forward noodle dish. Its identity centers on the dark color and rich sauce rather than an ancient regional recipe.', NULL, 'The dark appearance does not mean the noodles are burnt. The characteristic color comes mainly from the specially chosen sauce, while high-heat griddling adds the roasted aroma.', ARRAY['{"01 Wheat Yakisoba Noodles
 Wheat noodles provide the chewy base.
 

 02 Cabbage and Pork
 Vegetables and pork add sweetness, texture, and savory richness.
 

 03 Dark Yakisoba Sauce
 A concentrated local-style sauce creates the signature deep color and flavor."}']::text[], 'hee-gah-she-moo-rah-yah-mah koo-roh yah-kee-soh-bah', 'N/A', ARRAY[]::text[], NULL),
('musashino-udon', 'Musashino Udon', '武蔵野うどん', 'kanto', 'tokyo', 'A rustic noodle tradition of the Musashino region, defined by thick, firm wheat noodles eaten with a hot meat-and-vegetable dipping broth. It reflects the area''s former wheat-growing farm culture, producing a hearty meal where chewy noodles and strongly flavored soup are deliberately kept separate.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy, fish (broth)', 700, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Musashino udon grew from the farming villages west of Edo, where wheat was an important local crop and noodles provided a filling household meal. The style continued through the modern Tokyo suburbs and became recognized as a regional food tradition.', NULL, 'The noodles are intentionally firmer than many mainstream udon styles because they are meant to be dipped into a hot broth. Pork and negi in the dipping soup are characteristic of many traditional versions.', ARRAY['{"01 Local Wheat Noodles
 Firm wheat noodles provide the substantial bite.
 

 02 Pork
 Pork adds richness to the dipping broth.
 

 03 Negi and Soy-Based Broth
 Green onion, dashi, soy sauce, and mirin create the savory dipping sauce."}']::text[], 'moo-sah-she-noh oo-don', 'N/A', ARRAY[]::text[], NULL),
('higashiyamato-cha-udon', 'Higashiyamato Cha Udon', 'ひがしやまと茶うどん', 'kanto', 'tokyo', 'A green-tinted udon from Higashiyamato made by incorporating locally associated Sayama tea into wheat noodles. The tea adds a subtle grassy aroma and color while the noodle retains the firm, chewy structure expected from Japanese udon.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains wheat, soy', 700, 1500, 'Published', ARRAY['{"Vegetarian","Dine-in"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Higashiyamato Tea Udon was developed as a local product linking the city with Sayama tea culture. The recipe adapts familiar udon-making techniques by incorporating tea into the noodle dough rather than creating a separate soup or dessert.', NULL, 'The tea aroma is intentionally subtle because too much tea powder would make the noodles bitter. The green color is therefore a visual cue as much as a flavor signal.', ARRAY['{"01 Wheat Flour
 Wheat provides the gluten structure needed for chewy udon.
 

 02 Sayama Tea
 Tea contributes green color and a delicate grassy fragrance.
 

 03 Salt and Water
 Salt strengthens the dough while water develops the final noodle texture."}']::text[], 'hee-gah-she-yah-mah-toh chah oo-don', 'N/A', ARRAY[]::text[], NULL),
('sayama-tea', 'Sayama Tea', '狭山茶', 'kanto', 'tokyo', 'A Japanese green tea grown in the western Tokyo region around Sayama, valued for its rich body, mellow sweetness, and distinctive steamed-leaf aroma. The tea is associated with cool-climate growing conditions and is traditionally enjoyed as a concentrated, full-flavored cup rather than a delicate light brew.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 1000, 3000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Sayama tea has been cultivated in the western Tokyo and southern Saitama region for centuries, with production becoming established under the area''s cooler climate. The local tea tradition developed around careful cultivation and processing in this northern tea-growing area.', NULL, 'Sayama tea is associated with a famous saying that praises three qualities: flavor, color, and aroma. Its fuller body makes it well suited to a slightly stronger brew than many delicate sencha styles.', ARRAY['{"01 Tea Leaves
 Young leaves provide the aroma, bitterness, sweetness, and body of the infusion.
 

 02 Steam Processing
 Steaming prevents oxidation and preserves the green character of the leaves.
 

 03 Hot Water
 Water extracts soluble flavor compounds to form the finished tea infusion."}']::text[], 'sah-yah-mah chah', 'N/A', ARRAY[]::text[], NULL),
('hino-pears', 'Hino Pears', '日野の梨', 'kanto', 'tokyo', 'Crisp Japanese pears grown in Hino, where local orchards produce sweet, juicy fruit for direct sales during late summer and autumn. Hino pears are eaten fresh for their clean aroma, abundant juice, and refreshing crunch rather than used primarily as a processed ingredient.', ARRAY['{"Fall"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 500, 2000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Pear growing has a long history in the Tama region, including Hino, where local orchards survived alongside expanding residential areas. The local specialty today reflects small-scale orchard production and direct seasonal sales.', NULL, 'Japanese pears are harvested close to eating ripeness rather than left to soften dramatically off the tree. This helps explain their exceptionally crisp texture.', ARRAY['{"01 Japanese Pears
 Whole ripe nashi provide the signature sweetness and crisp juice.
 

 02 Orchard Soil and Water
 Growing conditions shape the fruit''s size and balance.
 

 03 Natural Fruit Sugars
 Natural sugars provide the clean sweetness enjoyed in fresh fruit."}']::text[], 'hee-noh no nah-she', 'N/A', ARRAY[]::text[], NULL),
('hinode-tomato', 'Hinode Tomato', '日の出トマト', 'kanto', 'tokyo', 'A locally grown tomato specialty from Hinode, valued for ripe sweetness, fresh acidity, and the concentrated flavor that comes from careful local cultivation. The tomatoes are best treated simply, allowing the fruit''s natural juice and aroma to remain the center of the dish.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 300, 1000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hinode Tomato is a modern local agricultural specialty rather than an old named dish. It reflects the town''s horticulture and direct-sale culture, where ripe local tomatoes are promoted as seasonal produce.', NULL, 'Tomatoes taste sweeter and more aromatic when allowed to ripen fully before eating. A light pinch of salt can sharpen their natural sweetness without adding a heavy sauce.', ARRAY['{"01 Fresh Tomatoes
 Ripe locally grown tomatoes provide the main flavor, acidity, and color.
 

 02 Natural Tomato Juice
 Juice creates the refreshing texture and carries aroma through the fruit.
 

 03 Sea Salt
 A small amount of salt can enhance sweetness in simple tomato preparations."}']::text[], 'hee-noh-deh toh-mah-toh', 'N/A', ARRAY[]::text[], NULL),
('yuzu-hinohara-black-tea', 'Yuzu / Hinohara Black Tea', 'ゆず・ひのはら紅茶', 'kanto', 'tokyo', 'A paired local specialty from Hinohara combining fragrant yuzu citrus with black tea produced in the village. The citrus adds bright peel aroma to the tea, creating a warm, rounded drink that links mountain agriculture with a modern Japanese tea style.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 600, 1500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hinohara black tea and local yuzu products were developed as contemporary village specialties using the area''s mountain agriculture. The combination reflects modern value-added processing rather than a historic Edo beverage.', NULL, 'Yuzu peel can dominate the aroma even when only a small amount is used. Adding the peel after brewing preserves more of the volatile citrus oils.', ARRAY['{"01 Black Tea Leaves
 Fully oxidized tea leaves provide the amber liquor and malty base.
 

 02 Hinohara Yuzu
 Yuzu peel adds bright citrus aroma and gentle tartness.
 

 03 Hot Water
 Hot water extracts the tea compounds and carries the citrus oils into the cup."}']::text[], 'yoo-zoo / hee-noh-hah-rah koh-chah', 'N/A', ARRAY[]::text[], NULL),
('hinohara-potatoes', 'Hinohara Potatoes', 'ひのはらじゃがいも', 'kanto', 'tokyo', 'A locally grown potato specialty from Hinohara, where cool mountain conditions support small-scale vegetable cultivation. The potatoes are valued for their clean earthy flavor and firm, creamy texture and can be roasted, boiled, or used in simple village dishes that showcase the crop.', ARRAY['{"Autumn"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 300, 800, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hinohara potatoes are part of the village''s traditional mountain agriculture and continue to be promoted as a local specialty. Their importance lies in seasonal cultivation and household cooking rather than a single historic recipe.', NULL, 'Mountain-grown potatoes often vary in size because they come from small diversified fields rather than uniform industrial production. This makes simple roasting or boiling especially attractive.', ARRAY['{"01 Hinohara Potatoes
 The local crop provides the starchy base and earthy flavor.
 

 02 Water
 Water is used for boiling and helps carry salt and seasoning through the flesh.
 

 03 Salt or Miso
 Simple Japanese seasoning highlights the potatoes without masking their natural flavor."}']::text[], 'hee-noh-hah-rah jah-gye-moh', 'N/A', ARRAY[]::text[], NULL),
('apollo-pan', 'Apollo Pan', 'アポロパン', 'kanto', 'tokyo', 'A nostalgic local bread associated with Fuchu, sold as an everyday bakery item rather than a plated dish. The bread has a soft interior and lightly browned crust, reflecting the long tradition of neighborhood bakeries producing familiar Japanese-Western breads for school and home meals.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 150, 300, 'Published', ARRAY['{"Vegetarian","Quick bite"}']::text[], 'Verified vegetarian', 'Not halal', TRUE, 'Apollo Bread is a local bakery product associated with Fuchu''s neighborhood food culture. Its identity comes from local bakery tradition and a distinctive product name rather than a nationally standardized historical recipe.', NULL, 'The bread belongs to the Japanese bakery tradition that blends European-style doughs with local sweet and savory preferences. Its nostalgic appeal comes from being an everyday bakery item rather than a ceremonial food.', ARRAY['{"01 Wheat Flour
 Flour provides the main bread structure.
 

 02 Yeast
 Yeast leavens the dough and develops aroma.
 

 03 Milk, Sugar, and Fat
 These ingredients create the soft, lightly sweet character common in Japanese bakery bread."}']::text[], 'ah-poh-roh pahn', 'N/A', ARRAY[]::text[], NULL),
('ogai-mochi', 'Ogai Mochi', '鴎外餅', 'kanto', 'tokyo', 'A literary-themed Japanese sweet associated with Bunkyo and the former residence of novelist Mori Ogai, shaped as a soft mochi confection with a sweet filling. Its identity is cultural as much as culinary, linking a simple traditional sweet with one of Tokyo''s best-known writers.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 200, 600, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Ogai Mochi was created as a Bunkyo confection connected with Mori Ogai and the former Kanchoro residence. It is a modern literary souvenir inspired by the neighborhood''s cultural history rather than a sweet known to have been invented by Ogai himself.', NULL, 'The name is a tribute to Mori Ogai, not proof that the novelist created or ate this exact confection. Its value lies in the connection between a familiar wagashi form and Bunkyo''s literary heritage.', ARRAY['{"01 Glutinous Rice
 Rice-based dough creates the soft, chewy outer layer.
 

 02 Sweet Bean Filling
 Anko provides the central sweetness.
 

 03 Sugar
 Sugar balances the rice cake and filling and supports the confection''s soft texture."}']::text[], 'oh-gye moh-chee', 'N/A', ARRAY[]::text[], NULL),
('kanchorou-ginkgo-sable', 'Kanchorou Ginkgo Sable', '観潮楼のいちょうサブレ', 'kanto', 'tokyo', 'A crisp ginkgo-leaf-shaped sablé inspired by Kanchoro, Mori Ogai''s former residence in Bunkyo, where a famous ginkgo tree became part of the site''s literary landscape. The buttery cookie uses a simple European-style recipe to turn a local literary symbol into an elegant tea sweet.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, dairy, egg', 400, 1000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Kanchoro Ginkgo Sablé was developed as a modern Bunkyo souvenir inspired by the ginkgo at Mori Ogai''s former residence. The product links a French-style butter cookie with the neighborhood''s literary and historic landscape.', NULL, 'A ginkgo-shaped cookie can be recognized even without its package, making the local story visible in the food itself. The flavor is intentionally restrained so the butter and toasted flour remain clear.', ARRAY['{"01 Wheat Flour
 Flour forms the sablé''s crisp structure.
 

 02 Butter
 Butter provides richness and the characteristic short, crumbly texture.
 

 03 Sugar
 Sugar adds sweetness and helps the cookie brown lightly during baking."}']::text[], 'kahn-choh-roh no ee-choh sah-boo-reh', 'N/A', ARRAY[]::text[], NULL),
('machida-silk-melon', 'Machida Silk Melon', 'まちだシルクメロン', 'kanto', 'tokyo', 'A premium melon grown in Machida using a patented hydroponic cultivation method designed to produce many high-quality fruits from a single plant. The melon is marketed for its refined sweetness, fine texture, and controlled growing conditions, giving Machida a distinctive modern agricultural specialty.', ARRAY['{"Summer"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 3000, 10000, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Machida Silk Melon was developed through a patented Machida-style hydroponic farming method rather than traditional field cultivation. The system is designed to support controlled nutrient and water management and can produce many melons from a single plant.', NULL, 'The official producer describes a system capable of producing as many as sixty melons from one plant under controlled conditions. The key selling point is controlled cultivation designed to support consistent fruit quality.', ARRAY['{"01 Muskmelon
 The melon provides the fragrant sweetness and juicy flesh.
 

 02 Hydroponic Nutrient Solution
 Controlled nutrients support growth without ordinary field soil.
 

 03 Water
 Precise water management is central to the hydroponic growing system."}']::text[], 'mah-chee-dah shee-roo-koo meh-ron', 'N/A', ARRAY[]::text[], NULL),
('hengo-dango', 'Hengo Dango', 'ヘンゴだんご', 'kanto', 'tokyo', 'A traditional Mikurajima island dumpling associated with the island''s distinctive plant-rich mountain environment. Hengo dango is made from locally familiar starchy ingredients and shaped into a simple rustic sweet, reflecting the self-sufficient cooking of this remote Izu island.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 150, 400, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hengo Dango belongs to Mikurajima''s traditional island food culture and was passed through household cooking rather than developed by a documented commercial chef. The recipe reflects the use of locally available plants and starches on a remote island.', NULL, 'Remote island foods often preserve ingredients and techniques that disappeared from urban cooking. Hengo dango is valuable because it records a local household food tradition rather than because of commercial branding.', ARRAY['{"01 Local Starchy Ingredient
 A locally gathered starch provides the dough''s body.
 

 02 Water
 Water hydrates the mixture and determines the dumpling''s final texture.
 

 03 Sweet Seasoning
 Sugar or another simple sweetener provides the dessert character."}']::text[], 'hen-goh dahn-goh', 'N/A', ARRAY[]::text[], NULL),
('sakuyuri-no-kinton', 'Sakuyuri no Kinton', 'サクユリのきんとん', 'kanto', 'tokyo', 'A delicate wagashi inspired by Sakuyuri, the native lily associated with Mikurajima, using the soft, sculpted kinton style to evoke the flower''s natural forms. The confection is better understood as a botanical-themed sweet than as a dessert made from the lily itself.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan', 300, 800, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'The confection is a modern interpretation inspired by Mikurajima''s Sakuyuri, a locally important lily. It uses the flower as a cultural and visual motif rather than claiming Sakuyuri as an edible ingredient.', NULL, 'Sakuyuri is valued as part of Mikurajima''s native plant heritage. The kinton uses the flower as design inspiration, not as food material.', ARRAY['{"01 Sweet Bean Base
 Sweet bean paste provides the soft, moldable body of the kinton.
 

 02 Sugar
 Sugar supplies sweetness and helps create the fine, soft texture.
 

 03 Natural Coloring
 Subtle natural coloring can reinforce the flower motif without overpowering the confection."}']::text[], 'sah-koo-yoo-ree no keen-ton', 'N/A', ARRAY[]::text[], NULL),
('hayaki', 'Hayaki', 'はやき', 'kanto', 'tokyo', 'A traditional Mikurajima island food made from a simple local grain-and-starch dough that is cooked into a compact, satisfying snack. The dish reflects the island''s history of making filling foods from ingredients that could be cultivated or transported to a remote community.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 200, 500, 'Published', ARRAY['{"Vegetarian","Halal"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Hayaki is recorded as part of Mikurajima''s traditional household food culture rather than as a modern commercial invention. The recipe reflects practical island cooking and the need to make filling foods from limited supplies.', NULL, 'Traditional island recipes often survive through oral transmission and household practice, so exact ingredient ratios can vary. It is most accurately presented as a local heritage food rather than a standardized factory product.', ARRAY['{"01 Local Grain or Flour
 A staple grain or flour provides the main body of the food.
 

 02 Starchy Binder
 A starch helps hold the mixture together and gives the finished food its dense texture.
 

 03 Water
 Water hydrates the mixture and allows the ingredients to form a workable dough."}']::text[], 'hah-yah-kee', 'N/A', ARRAY[]::text[], NULL),
('jinenjo-karukan-manju', 'Jinenjo Karukan Manju', '自然薯かるかん饅頭', 'kanto', 'tokyo', 'A soft steamed karukan manju from Mizuho made with Japanese yam, rice flour, and sweet filling. The yam gives the outer cake a springy, airy texture and subtle earthy aroma, while the bean center adds sweetness without making the confection heavy.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan', 200, 600, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Natural-yam karukan is based on the southern Japanese tradition of karukan, while Mizuho producers have adapted the format as a local Tokyo specialty using cultivated Japanese yam. The product is a modern regional confection built around a traditional steamed-cake technique.', NULL, 'Karukan is unusual among Japanese sweets because the yam is part of the cake structure rather than only the filling. The resulting crumb is softer and more elastic than an ordinary flour-based manju.', ARRAY['{"01 Japanese Yam
 Naturally sticky yam gives the steamed cake its spring and moisture.
 

 02 Rice Flour
 Rice flour provides the clean, light cake structure.
 

 03 Sweet Red Bean Paste
 Anko adds the principal sweetness and creates the dark center."}']::text[], 'jee-nen-joh kah-roo-kahn mahn-joo', 'N/A', ARRAY[]::text[], NULL),
('kiwi-amazake', 'Kiwi Amazake', 'キウイ甘酒', 'kanto', 'tokyo', 'A modern Mitaka drink that blends locally grown kiwi with amazake, creating a naturally sweet, softly tart beverage with a creamy grain base. The product combines a traditional Japanese fermented rice drink with the fresh fruit character of Mitaka agriculture.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 400, 800, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Kiwi Amazake was developed as a Mitaka regional product by local makers using Mitaka-grown kiwi and amazake. The city promotes it as a modern example of local agricultural produce combined with a traditional fermented beverage.', NULL, 'Amazake can be made from rice koji without added distilled alcohol, so the finished drink can be non-alcoholic. Kiwi adds acidity that keeps the rice sweetness from becoming cloying.', ARRAY['{"01 Rice Koji Amazake
 Fermented rice and koji provide the naturally sweet, creamy base.
 

 02 Mitaka Kiwi
 Fresh kiwi supplies acidity, fruit aroma, and green color.
 

 03 Water
 Water balances the concentrated amazake and fruit into a drinkable consistency."}']::text[], 'kee-oo-ee ah-mah-zah-keh', 'N/A', ARRAY[]::text[], NULL),
('azabu-juban-bean-snacks', 'Azabu Juban Bean Snacks', '麻布十番の豆菓子', 'kanto', 'tokyo', 'A traditional-style bean confection associated with Azabu-Juban''s long-running Mamegen shop, where roasted beans and other ingredients are coated, seasoned, or confectioned into crisp bite-sized snacks. The range balances roasted aroma, sweetness, saltiness, and texture and is strongly linked to the neighborhood''s historic shopping street.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, contains soy/peanuts', 400, 1500, 'Published', ARRAY['{"Vegetarian","Halal","Quick bite"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Mamegen has been a bean-confectionery shop in Azabu-Juban since the nineteenth century and is widely associated with the area''s bean-snack tradition. The shop developed a broad range of roasted and coated beans rather than a single recipe.', NULL, 'The shop''s long presence helped make bean snacks part of the Azabu-Juban souvenir identity. Many varieties are designed to be eaten with tea or an alcoholic drink.', ARRAY['{"01 Roasted Beans
 Soybeans, broad beans, peanuts, and other legumes provide the crunchy base.
 

 02 Sugar or Savory Coating
 Sweet, soy, miso, or spice coatings create the main flavor.
 

 03 Sesame or Aromatic Seasoning
 Sesame and other seasonings add fragrance and extra texture to selected varieties."}']::text[], 'ah-zah-boo joo-bahn no mah-meh-gah-she', 'N/A', ARRAY[]::text[], NULL),
('akame-satoimo', 'Akame Satoimo', '赤芽さといも', 'kanto', 'tokyo', 'A traditional taro variety from Miyakejima distinguished by its reddish-purple shoots and firm, creamy corms. Akame satoimo is used in simmered dishes and other island cooking, where its dense texture and earthy sweetness complement soy-based seasonings.', ARRAY['{"Autumn"}']::text[], ARRAY['{"local specialty"}']::text[], 'Vegan, Gluten-free', 300, 800, 'Published', ARRAY['{"Vegetarian","Halal","Seasonal peak"}']::text[], 'Verified vegetarian', 'Verified halal', TRUE, 'Akame satoimo is a traditional agricultural variety preserved on Miyakejima as part of the island''s distinctive crop heritage. Its cultivation reflects the island''s adaptation to subtropical conditions and its long reliance on hardy root crops.', NULL, 'The reddish color is most obvious in the young shoots, while the edible corm is much paler inside. Cooking softens the root into a creamy texture while leaving enough structure for simmered dishes.', ARRAY['{"01 Akame Taro
 The heritage root provides the starchy, creamy base.
 

 02 Dashi
 Japanese stock carries the root''s delicate earthy flavor.
 

 03 Soy Sauce and Mirin
 Savory-sweet seasoning enhances the natural sweetness of the taro."}']::text[], 'ah-kah-meh sah-toh-ee-moh', 'N/A', ARRAY[]::text[], NULL),
('muroaji-ashitaba-smoked-fish', 'Muroaji Ashitaba Smoked Fish', 'むロアジあした葉燻製', 'kanto', 'tokyo', 'A smoked fish specialty from Miyakejima that pairs locally caught flying fish with the island''s distinctive ashitaba plant. The fish is cured and gently smoked to concentrate its savory flavor, while ashitaba adds a local botanical note to the product''s identity.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish', 800, 2000, 'Published', ARRAY[]::text[], 'Not vegetarian', 'Not halal', TRUE, 'The product was developed as a Miyakejima specialty combining the island''s flying-fish catch with ashitaba, a signature local plant. It represents modern local food processing rather than an ancient named dish.', NULL, 'Flying fish are naturally lean, so smoking concentrates their flavor without making the finished product as oily as richer fish. Ashitaba gives the item a distinctly island-specific identity.', ARRAY['{"01 Flying Fish
 Muroaji provides lean, savory fish flesh.
 

 02 Ashitaba
 The local leafy plant adds botanical character and regional identity.
 

 03 Smoking Salt
 Salt cures the fish while wood smoke creates aroma and the characteristic brown surface."}']::text[], 'moo-roh-ah-jee ah-she-tah-bah koon-say', 'N/A', ARRAY[]::text[], NULL),
('musashino-jigona-udon', 'Musashino Jigona Udon', '武蔵野地粉うどん', 'kanto', 'tokyo', 'A handmade udon made with locally associated Musashino wheat flour, emphasizing firm noodles and a rustic grain aroma. The style reflects the area''s historic wheat-growing culture and is often served with a warm dipping soup rich in pork and green onion.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy', 700, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Musashino Jigona Udon was developed to promote locally milled wheat and the area''s traditional noodle culture. It draws on the older Musashino practice of growing wheat and making substantial udon rather than reproducing a single historic recipe.', NULL, 'The term jigona points to local flour, emphasizing the grain''s regional origin. Firm noodles are particularly good with the hot dipping broth used in Musashino-style udon.', ARRAY['{"01 Local Wheat Flour
 Regional wheat provides the principal grain aroma and noodle body.
 

 02 Water and Salt
 Water forms the dough while salt strengthens the gluten structure.
 

 03 Dipping Broth
 Pork, dashi, soy sauce, and negi create the traditional savory accompaniment."}']::text[], 'moo-sah-she-noh jee-goh-nah oo-don', 'N/A', ARRAY[]::text[], NULL),
('murayama-kate-udon', 'Murayama Kate Udon', '村山かてうどん', 'kanto', 'tokyo', 'A hearty noodle tradition from Musashimurayama in which firm wheat udon is eaten with a rich dipping soup and abundant greens or other vegetables called kate. The dish developed from local farm households that paired homemade noodles with whatever vegetables were available.', ARRAY['{"N/A"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains wheat, soy', 800, 1500, 'Published', ARRAY['{"Dine-in"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'Murayama Kate Udon developed from the farming culture of the Musashino plain, where wheat was an important crop and vegetables were used to stretch a meal. The local tradition was preserved as a home-style dish and later promoted as a city specialty.', NULL, 'The word kate means food to eat with the noodles, especially vegetables. The dish therefore expresses the practical idea of making a filling meal from noodles plus available produce.', ARRAY['{"01 Wheat Udon
 Firm hand-made noodles provide the substantial base.
 

 02 Local Leafy Vegetables
 Greens and other seasonal vegetables provide the signature kate component.
 

 03 Pork and Soy Broth
 Pork, dashi, soy sauce, and negi make the hot dipping soup."}']::text[], 'moo-rah-yah-mah kah-teh oo-don', 'N/A', ARRAY[]::text[], NULL),
('meguro-no-sanma', 'Meguro no Sanma', '目黒のさんま', 'kanto', 'tokyo', 'A Meguro civic food tradition centered on grilled Pacific saury, served as a tribute to a famous rakugo story in which the fish is celebrated as food that tastes best when cooked simply. The modern local event tradition uses charcoal-grilled sanma to connect literature, neighborhood identity, and autumn food culture.', ARRAY['{"Autumn"}']::text[], ARRAY['{"local specialty"}']::text[], 'Contains fish', 500, 1500, 'Published', ARRAY['{"Dine-in","Seasonal peak"}']::text[], 'Not vegetarian', 'Not halal', TRUE, 'The Meguro saury tradition is inspired by the rakugo story Meguro no Sanma, in which a lord discovers the appeal of simply prepared saury. The modern local festival tradition grew in the twentieth century as the ward turned that literary reference into a community food event.', NULL, 'The rakugo joke says the fish tastes best in Meguro even though the district is inland and not a fishing port. The story became so associated with the ward that saury now serves as a local cultural symbol.', ARRAY['{"01 Pacific Saury
 Fresh sanma provides the rich, oily fish flavor.
 

 02 Salt
 Simple salting seasons the fish and helps the skin brown over the grill.
 

 03 Grated Daikon and Citrus
 Grated daikon and a squeeze of citrus cut the fish''s richness and refresh the finish."}']::text[], 'meh-goo-roh no sahn-mah', 'N/A', ARRAY[]::text[], NULL)
ON CONFLICT (dish_id) DO UPDATE SET dish_name = EXCLUDED.dish_name, japanese_name = EXCLUDED.japanese_name, summary = EXCLUDED.summary;

-- 5. DISH_LOCATIONS
INSERT INTO dish_locations (dish_id, location_id, relationship, display_priority, editorial_note, link_status) VALUES
('aochu', 'aogashima-village', 'best-known', 1, 'Aochu in Aogashima Village', 'Published'),
('hingya-no-shio', 'aogashima-village', 'best-known', 1, 'Hingya no Shio in Aogashima Village', 'Published'),
('haijima-highball', 'akishima-city', 'best-known', 1, 'Haijima Highball in Akishima City', 'Published'),
('haijima-negi-miso', 'akishima-city', 'best-known', 1, 'Haijima Negi Miso in Akishima City', 'Published'),
('akigawa-sweet-corn', 'akiruno-city', 'best-known', 1, 'Akigawa Sweet Corn in Akiruno City', 'Published'),
('norabou-na', 'akiruno-city', 'best-known', 1, 'Norabou-na in Akiruno City', 'Published'),
('bunka-fry', 'adachi-ward', 'best-known', 1, 'Bunka Fry in Adachi Ward', 'Published'),
('senju-no-suzumeyaki', 'adachi-ward', 'best-known', 1, 'Senju no Suzumeyaki in Adachi Ward', 'Published'),
('yarikake-dango', 'adachi-ward', 'best-known', 1, 'Yarikake Dango in Adachi Ward', 'Published'),
('yuyu-toden-wagashi', 'arakawa-ward', 'best-known', 1, 'Yuyu Toden - Wagashi in Arakawa Ward', 'Published'),
('arakawa-monja', 'arakawa-ward', 'best-known', 1, 'Arakawa Monja in Arakawa Ward', 'Published'),
('okara-soy-milk-karinto', 'itabashi-ward', 'best-known', 1, 'Okara & Soy Milk Karinto in Itabashi Ward', 'Published'),
('niku-no-marusan-homemade-ham-cutlet', 'itabashi-ward', 'best-known', 1, 'Niku no Marusan Homemade Ham Cutlet in Itabashi Ward', 'Published'),
('inagi-pears', 'inagi-city', 'best-known', 1, 'Inagi Pears in Inagi City', 'Published'),
('inagi-mukashibanashi-manju', 'inagi-city', 'best-known', 1, 'Inagi Mukashibanashi Manju in Inagi City', 'Published'),
('komatsuna', 'edogawa-ward', 'best-known', 1, 'Komatsuna in Edogawa Ward', 'Published'),
('salad-komatsuna', 'edogawa-ward', 'best-known', 1, 'Salad Komatsuna in Edogawa Ward', 'Published'),
('ome-senbei', 'ome-city', 'best-known', 1, 'Ome Senbei in Ome City', 'Published'),
('noshikon', 'ome-city', 'best-known', 1, 'Noshikon in Ome City', 'Published'),
('bekko-sushi', 'oshima-town', 'best-known', 1, 'Bekko Sushi in Oshima Town', 'Published'),
('zako-teishoku', 'oshima-town', 'best-known', 1, 'Zako Teishoku in Oshima Town', 'Published'),
('gyunu-senbei', 'oshima-town', 'best-known', 1, 'Gyunu Senbei in Oshima Town', 'Published'),
('omori-nori', 'ota-ward', 'best-known', 1, 'Omori Nori in Ota Ward', 'Published'),
('shima-zushi', 'ogasawara-village', 'best-known', 1, 'Shima-zushi in Ogasawara Village', 'Published'),
('kame-ni', 'ogasawara-village', 'best-known', 1, 'Kame-ni in Ogasawara Village', 'Published'),
('same-burger', 'ogasawara-village', 'best-known', 1, 'Same Burger in Ogasawara Village', 'Published'),
('shikaku-mame-tempura', 'ogasawara-village', 'best-known', 1, 'Shikaku-mame Tempura in Ogasawara Village', 'Published'),
('akaba-miso-soup', 'ogasawara-village', 'best-known', 1, 'Akaba Miso Soup in Ogasawara Village', 'Published'),
('shima-lemon-jelly', 'ogasawara-village', 'best-known', 1, 'Shima Lemon Jelly in Ogasawara Village', 'Published'),
('okutama-yamame', 'okutama-town', 'best-known', 1, 'Okutama Yamame in Okutama Town', 'Published'),
('okutama-wasabi', 'okutama-town', 'best-known', 1, 'Okutama Wasabi in Okutama Town', 'Published'),
('sashimi-konnyaku', 'okutama-town', 'best-known', 1, 'Sashimi Konnyaku in Okutama Town', 'Published'),
('kusa-dango', 'katsushika-ward', 'best-known', 1, 'Kusa Dango in Katsushika Ward', 'Published'),
('kawazakana-ryori', 'katsushika-ward', 'best-known', 1, 'Kawazakana Ryori in Katsushika Ward', 'Published'),
('motsuyaki', 'katsushika-ward', 'best-known', 1, 'Motsuyaki in Katsushika Ward', 'Published'),
('takinogawa-gobo', 'kita-ward', 'best-known', 1, 'Takinogawa Gobo in Kita Ward', 'Published'),
('kiyose-bo', 'kiyose-city', 'best-known', 1, 'Kiyose Bo in Kiyose City', 'Published'),
('kiyose-man', 'kiyose-city', 'best-known', 1, 'Kiyose Man in Kiyose City', 'Published'),
('kunitachi-brewery-craft-beer', 'kunitachi-city', 'best-known', 1, 'Kunitachi Brewery Craft Beer in Kunitachi City', 'Published'),
('kinmedai-no-nitsuke', 'kozushima-village', 'best-known', 1, 'Kinmedai no Nitsuke in Kozushima Village', 'Published'),
('toyosu-market-kaisendon', 'koto-ward', 'best-known', 1, 'Toyosu Market Kaisendon in Koto Ward', 'Published'),
('koganei-sakura-junmai-ginjo', 'koganei-city', 'best-known', 1, 'Koganei Sakura Junmai Ginjo in Koganei City', 'Published'),
('fight-monaka', 'kokubunji-city', 'best-known', 1, 'Fight Monaka in Kokubunji City', 'Published'),
('kate-udon', 'kodaira-city', 'best-known', 1, 'Kate Udon in Kodaira City', 'Published'),
('komae-honey', 'komae-city', 'best-known', 1, 'Komae Honey in Komae City', 'Published'),
('sable-manju-komae', 'komae-city', 'best-known', 1, 'Sable Manju Komae in Komae City', 'Published'),
('komae-jomon-madeleine', 'komae-city', 'best-known', 1, 'Komae Jomon Madeleine in Komae City', 'Published'),
('oden-croquette', 'shinagawa-ward', 'best-known', 1, 'Oden Croquette in Shinagawa Ward', 'Published'),
('edomae-anago', 'shinagawa-ward', 'best-known', 1, 'Edomae Anago in Shinagawa Ward', 'Published'),
('harajuku-crepe', 'shibuya-ward', 'best-known', 1, 'Harajuku Crepe in Shibuya Ward', 'Published'),
('omoide-yokocho-yakitori', 'shinjuku-ward', 'best-known', 1, 'Omoide Yokocho Yakitori in Shinjuku Ward', 'Published'),
('ogikubo-ramen', 'suginami-ward', 'best-known', 1, 'Ogikubo Ramen in Suginami Ward', 'Published'),
('chanko-nabe', 'sumida-ward', 'best-known', 1, 'Chanko Nabe in Sumida Ward', 'Published'),
('chomeiji-sakura-mochi', 'sumida-ward', 'best-known', 1, 'Chomeiji Sakura Mochi in Sumida Ward', 'Published'),
('daikan-mochi', 'setagaya-ward', 'best-known', 1, 'Daikan Mochi in Setagaya Ward', 'Published'),
('okura-daikon', 'setagaya-ward', 'best-known', 1, 'Okura Daikon in Setagaya Ward', 'Published'),
('ningyoyaki', 'taito-ward', 'best-known', 1, 'Ningyoyaki in Taito Ward', 'Published'),
('dojo-nabe', 'taito-ward', 'best-known', 1, 'Dojo Nabe in Taito Ward', 'Published'),
('kaminari-okoshi', 'taito-ward', 'best-known', 1, 'Kaminari Okoshi in Taito Ward', 'Published'),
('edo-style-tendon', 'taito-ward', 'best-known', 1, 'Edo-style Tendon in Taito Ward', 'Published'),
('udora-yaki-udo-manju', 'tachikawa-city', 'best-known', 1, 'Udora-yaki & Udo Manju in Tachikawa City', 'Published'),
('tachikawa-yakiton', 'tachikawa-city', 'best-known', 1, 'Tachikawa Yakiton in Tachikawa City', 'Published'),
('tachikawa-pudding', 'tachikawa-city', 'best-known', 1, 'Tachikawa Pudding in Tachikawa City', 'Published'),
('sakura-polvoron', 'tama-city', 'best-known', 1, 'Sakura Polvoron in Tama City', 'Published'),
('tama-no-sanpomichi', 'tama-city', 'best-known', 1, 'Tama no Sanpomichi in Tama City', 'Published'),
('ponpoko-udon', 'tama-city', 'best-known', 1, 'Ponpoko Udon in Tama City', 'Published'),
('tsukishima-monjayaki', 'chuo-ward', 'best-known', 1, 'Tsukishima Monjayaki in Chuo Ward', 'Published'),
('tsukiji-tamagoyaki', 'chuo-ward', 'best-known', 1, 'Tsukiji Tamagoyaki in Chuo Ward', 'Published'),
('ginza-omurice', 'chuo-ward', 'best-known', 1, 'Ginza Omurice in Chuo Ward', 'Published'),
('jindaiji-soba', 'chofu-city', 'best-known', 1, 'Jindaiji Soba in Chofu City', 'Published'),
('seiro-soba', 'chiyoda-ward', 'best-known', 1, 'Seiro Soba in Chiyoda Ward', 'Published'),
('mori-soba', 'chiyoda-ward', 'best-known', 1, 'Mori Soba in Chiyoda Ward', 'Published'),
('shio-daifuku', 'toshima-ward', 'best-known', 1, 'Shio Daifuku in Toshima Ward', 'Published'),
('otafuku-mame', 'toshima-ward', 'best-known', 1, 'Otafuku Mame in Toshima Ward', 'Published'),
('tsubaki-oil', 'toshima-village', 'best-known', 1, 'Tsubaki Oil in Toshima Village', 'Published'),
('8-tier-soft-serve-daily-chico', 'nakano-ward', 'best-known', 1, '8-Tier Soft Serve - Daily Chico in Nakano Ward', 'Published'),
('oyaki-refu-tei', 'nakano-ward', 'best-known', 1, 'Oyaki - Refu-tei in Nakano Ward', 'Published'),
('kusaya', 'niijima-village', 'best-known', 1, 'Kusaya in Niijima Village', 'Published'),
('asahi-karinto', 'nishitokyo-city', 'best-known', 1, 'Asahi Karinto in Nishitokyo City', 'Published'),
('nerima-daikon-takuan', 'nerima-ward', 'best-known', 1, 'Nerima Daikon Takuan in Nerima Ward', 'Published'),
('nerima-daikon-manju', 'nerima-ward', 'best-known', 1, 'Nerima Daikon Manju in Nerima Ward', 'Published'),
('nerima-daifuku', 'nerima-ward', 'best-known', 1, 'Nerima Daifuku in Nerima Ward', 'Published'),
('nerima-sabl', 'nerima-ward', 'best-known', 1, 'Nerima Sablé in Nerima Ward', 'Published'),
('hachioji-ramen', 'hachioji-city', 'best-known', 1, 'Hachioji Ramen in Hachioji City', 'Published'),
('hachijo-shochu', 'hachijo-town', 'best-known', 1, 'Hachijo Shochu in Hachijo Town', 'Published'),
('hachijo-fruit-lemon', 'hachijo-town', 'best-known', 1, 'Hachijo Fruit Lemon in Hachijo Town', 'Published'),
('karuta-senbei-hamurin-senbei', 'hamura-city', 'best-known', 1, 'Karuta Senbei / Hamurin Senbei in Hamura City', 'Published'),
('hamura-no-seki', 'hamura-city', 'best-known', 1, 'Hamura no Seki in Hamura City', 'Published'),
('sakura-sable-sazareishi', 'hamura-city', 'best-known', 1, 'Sakura Sable / Sazareishi in Hamura City', 'Published'),
('noka-no-nidango', 'higashikurume-city', 'best-known', 1, 'Noka no Nidango in Higashikurume City', 'Published'),
('wasanbon-kogei-kashi', 'higashikurume-city', 'best-known', 1, 'Wasanbon Kogei Kashi in Higashikurume City', 'Published'),
('higashimurayama-black-yakisoba', 'higashimurayama-city', 'best-known', 1, 'Higashimurayama Black Yakisoba in Higashimurayama City', 'Published'),
('musashino-udon', 'higashimurayama-city', 'best-known', 1, 'Musashino Udon in Higashimurayama City', 'Published'),
('higashiyamato-cha-udon', 'higashiyamato-city', 'best-known', 1, 'Higashiyamato Cha Udon in Higashiyamato City', 'Published'),
('sayama-tea', 'higashiyamato-city', 'best-known', 1, 'Sayama Tea in Higashiyamato City', 'Published'),
('hino-pears', 'hino-city', 'best-known', 1, 'Hino Pears in Hino City', 'Published'),
('hinode-tomato', 'hinode-town', 'best-known', 1, 'Hinode Tomato in Hinode Town', 'Published'),
('yuzu-hinohara-black-tea', 'hinohara-village', 'best-known', 1, 'Yuzu / Hinohara Black Tea in Hinohara Village', 'Published'),
('hinohara-potatoes', 'hinohara-village', 'best-known', 1, 'Hinohara Potatoes in Hinohara Village', 'Published'),
('apollo-pan', 'fuchu-city', 'best-known', 1, 'Apollo Pan in Fuchu City', 'Published'),
('ogai-mochi', 'bunkyo-ward', 'best-known', 1, 'Ogai Mochi in Bunkyo Ward', 'Published'),
('kanchorou-ginkgo-sable', 'bunkyo-ward', 'best-known', 1, 'Kanchorou Ginkgo Sable in Bunkyo Ward', 'Published'),
('machida-silk-melon', 'machida-city', 'best-known', 1, 'Machida Silk Melon in Machida City', 'Published'),
('hengo-dango', 'mikurajima-village', 'best-known', 1, 'Hengo Dango in Mikurajima Village', 'Published'),
('sakuyuri-no-kinton', 'mikurajima-village', 'best-known', 1, 'Sakuyuri no Kinton in Mikurajima Village', 'Published'),
('hayaki', 'mikurajima-village', 'best-known', 1, 'Hayaki in Mikurajima Village', 'Published'),
('jinenjo-karukan-manju', 'mizuho-town', 'best-known', 1, 'Jinenjo Karukan Manju in Mizuho Town', 'Published'),
('kiwi-amazake', 'mitaka-city', 'best-known', 1, 'Kiwi Amazake in Mitaka City', 'Published'),
('azabu-juban-bean-snacks', 'minato-ward', 'best-known', 1, 'Azabu Juban Bean Snacks in Minato Ward', 'Published'),
('akame-satoimo', 'miyake-village', 'best-known', 1, 'Akame Satoimo in Miyake Village', 'Published'),
('muroaji-ashitaba-smoked-fish', 'miyake-village', 'best-known', 1, 'Muroaji Ashitaba Smoked Fish in Miyake Village', 'Published'),
('musashino-jigona-udon', 'musashino-city', 'best-known', 1, 'Musashino Jigona Udon in Musashino City', 'Published'),
('murayama-kate-udon', 'musashimurayama-city', 'best-known', 1, 'Murayama Kate Udon in Musashimurayama City', 'Published'),
('meguro-no-sanma', 'meguro-ward', 'best-known', 1, 'Meguro no Sanma in Meguro Ward', 'Published')
ON CONFLICT (dish_id, location_id, relationship) DO NOTHING;

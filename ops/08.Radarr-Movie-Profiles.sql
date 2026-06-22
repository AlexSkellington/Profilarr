-- Alex_C.T modular Profilarr v4 PCD operations.
-- 08: Radarr movie quality profiles and scoring.
-- Requires 01 through 07.
--
-- The strict profiles compare BluRay and WEB-DL inside one resolution-specific
-- group so existing custom-format scores choose the best file. Catalog keeps an ordered,
-- permissive DVD-through-1080p fallback ladder. Remux is never enabled.

-- Rebuild only the current managed movie profiles.
DELETE FROM quality_profile_custom_formats WHERE quality_profile_name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_group_members WHERE quality_profile_name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profile_qualities WHERE quality_profile_name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_groups WHERE quality_profile_name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profile_tags WHERE quality_profile_name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profiles WHERE name IN (
  'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);

-------------------------------------------------------------------------------
-- Profile quality groups
-------------------------------------------------------------------------------

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 1080p Movies', 'Default 1080p movie profile containing BluRay and WEB-DL. Remux is not enabled.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Movies');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', '1080p');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 1080p Movies', 'BluRay + WEB-DL 1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Movies', 'BluRay + WEB-DL 1080p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Movies', 'BluRay + WEB-DL 1080p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 1080p Movies', 'BluRay + WEB-DL 1080p', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 4K Movies', '4K movie profile containing 2160p BluRay and WEB-DL. Remux is not enabled.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', 'Movies');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', '4K');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 4K Movies', 'BluRay + WEB-DL 4K');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Movies', 'BluRay + WEB-DL 4K', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Movies', 'BluRay + WEB-DL 4K', 'WEBDL-2160p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 4K Movies', 'BluRay + WEB-DL 4K', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Permissive DVD-through-1080p movie ladder for older and scarce titles.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Movies');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Catalog');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Bluray-1080p', 1, 1, 1);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 1080p', 'WEBDL-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 1080p', 'WEBRip-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 1080p', 2, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Bluray-720p', 3, 1, 0);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 720p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 720p', 'WEBDL-720p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 720p', 'WEBRip-720p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 720p', 4, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Bluray-576p', 5, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Bluray-480p', 6, 1, 0);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 480p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 480p', 'WEBDL-480p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 480p', 'WEBRip-480p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'WEB 480p', 7, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'DVD', 8, 1, 0);

-------------------------------------------------------------------------------
-- Shared movie scoring: technical features dominate resolution and editions.
-------------------------------------------------------------------------------

-- Language and subtitles remain useful refiners without overriding A/V quality.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: Prefer English + Spanish', 'all', 300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: Spanish Audio Marker', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: English Marker', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: English-Only Backup', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: Spanish-Only Fallback', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: Latino Spanish Fallback', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Language: Multi-Dual Audio Bonus', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Subtitles: Prefer English + Spanish', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Subtitles: Spanish Bonus', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Subtitles: English Bonus', 'all', 25);

-- Codecs are tie-breakers; codec labels are not proof of encode quality.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Codec: HEVC-x265 Preferred', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Codec: AV1 Preferred', 'all', 350);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Codec: VVC-x266 Future', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);

-- Dynamic range is the strongest video feature family.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: Base HDR Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: HDR10 Bonus', 'all', 700);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: HDR10+ Bonus', 'all', 1200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: Dolby Vision Bonus', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: Dolby Vision + HDR Bonus', 'all', 1800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'HDR: Dolby Vision Only Fallback', 'all', 300);

-- Audio rewards lossless/object audio and prefers 7.1, while retaining strong 5.1 credit.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: Surround Bonus', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: 5.1 Surround Preferred', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: 6.1 Bonus', 'all', 650);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: 7.1 Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: Atmos Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: Lossless Track Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: EAC3-AC3 Preferred', 'all', 300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: AAC Fallback Marker', 'all', 20);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Audio: Stereo-2.0 Fallback', 'all', 5);

-- Source and release-fix signals proxy bitrate and provenance without hard size gates.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', '4K: UHD BluRay Preferred', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', '4K: WEB-DL Preferred', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', '1080p: BluRay Preferred', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', '1080p: WEB-DL Preferred', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Release: Proper-Repack-Rerip', 'all', 75);

-- Editions are collector refiners, intentionally below technical A/V features.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: IMAX', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: IMAX Enhanced', 'all', 450);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Director''s Cut', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Final Cut', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Extended', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Ultimate Cut', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Special Edition', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Expanded Ratio', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Open Matte', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: VAR', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Remastered', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Restored', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: 4K Scan', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: New Transfer', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Criterion', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Arrow', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Shout Factory', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: StudioCanal', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Collector''s Edition', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Anniversary Edition', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Edition: Unrated', 'all', 75);

-- Clone the canonical 1080p matrix so all movie profiles tune from one source block.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best 4K Movies', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - Best 1080p Movies';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Catalog 480p-1080p Movies', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - Best 1080p Movies';

-- Catalog-only lower-resolution source refiners.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '1080p: WEBRip Source', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '1080p: BDRip Source', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '720p: BluRay Preferred', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '720p: WEB-DL Preferred', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '720p: WEBRip Source', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '720p: BDRip Source', 'all', 40);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '576p: BluRay Preferred', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '576p: WEB-DL Preferred', 'all', 60);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '576p: WEBRip Source', 'all', 30);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '576p: BDRip Source', 'all', 30);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '480p: BluRay Preferred', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '480p: WEB-DL Preferred', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '480p: WEBRip Source', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', '480p: BDRip Source', 'all', 25);

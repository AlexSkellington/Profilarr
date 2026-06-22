-- Alex_C.T modular Profilarr v2 PCD operations.
-- 08: Radarr movie quality profiles and feature-rich scoring.
-- Requires 01 through 07.
--
-- Comparable 1080p and 2160p qualities are grouped so custom-format score,
-- not resolution label alone, chooses the best release. The 2160p bonus is
-- deliberately modest: equally rich 4K wins, but excellent 1080p can beat
-- weak 4K. Size helpers in 12 are optional and are not attached here.

-- Remove superseded and current managed movie profiles before rebuilding them.
DELETE FROM quality_profile_custom_formats WHERE quality_profile_name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_group_members WHERE quality_profile_name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profile_qualities WHERE quality_profile_name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_groups WHERE quality_profile_name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profile_tags WHERE quality_profile_name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);
DELETE FROM quality_profiles WHERE name IN (
  'Alex_C.T - Compact 1080p Movies', 'Alex_C.T - Premium 1080p Movies', 'Alex_C.T - Remux 1080p Movies',
  'Alex_C.T - Compact 4K Movies', 'Alex_C.T - Premium 4K Movies', 'Alex_C.T - Remux 4K Movies',
  'Alex_C.T - 1080p Plex Movies', 'Alex_C.T - 4K Plex Movies', 'Alex_C.T - Catalog 480p-1080p Plex Movies',
  'Alex_C.T - Best Available Movies', 'Alex_C.T - Best 1080p Movies', 'Alex_C.T - Best 4K Movies',
  'Alex_C.T - Catalog 480p-1080p Movies'
);

-------------------------------------------------------------------------------
-- Profile quality groups
-------------------------------------------------------------------------------

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best Available Movies', 'Default feature-first movie profile. It compares BluRay and WEB-DL releases across 1080p and 2160p in one quality group, allowing HDR, Dolby Vision, audio, source, language, and edition richness to outweigh resolution alone. Remux is reserved for the resolution-specific profiles.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best Available Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best Available Movies', 'Movies');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p', 'WEBDL-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best Available Movies', 'Feature-Rich 1080p-2160p', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 1080p Movies', 'Resolution-specific feature-first movie profile. It compares 1080p Remux, BluRay, and WEB-DL releases by technical richness and keeps every accepted release at 1080p.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Movies');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Movies', '1080p');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 1080p Movies', 'Feature-Rich 1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Feature-Rich 1080p', 'Remux-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Feature-Rich 1080p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Movies', 'Feature-Rich 1080p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 1080p Movies', 'Feature-Rich 1080p', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 4K Movies', 'Resolution-specific feature-first movie profile. It compares 2160p Remux, BluRay, and WEB-DL releases by technical richness and keeps every accepted release at 4K.', 1, 0, 10000, 50);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', 'Radarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', 'Movies');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Movies', '4K');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 4K Movies', 'Feature-Rich 4K');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Movies', 'Feature-Rich 4K', 'Remux-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Movies', 'Feature-Rich 4K', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Movies', 'Feature-Rich 4K', 'WEBDL-2160p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 4K Movies', 'Feature-Rich 4K', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Catalog 480p-1080p Movies', 'Relaxed movie profile for older and scarce titles. It accepts DVD through 1080p, climbs by resolution and source quality, and uses the same feature-rich scoring priorities as the primary movie profiles.', 1, 0, 10000, 50);
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
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: Prefer English + Spanish', 'all', 300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: Spanish Audio Marker', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: English Marker', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: English-Only Backup', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: Spanish-Only Fallback', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: Latino Spanish Fallback', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Language: Multi-Dual Audio Bonus', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Subtitles: Prefer English + Spanish', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Subtitles: Spanish Bonus', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Subtitles: English Bonus', 'all', 25);

-- Resolution and codecs are tie-breakers; codec labels are not proof of encode quality.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Video: 2160p Resolution Bonus', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Codec: HEVC-x265 Preferred', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Codec: AV1 Preferred', 'all', 350);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Codec: VVC-x266 Future', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);

-- Dynamic range is the strongest video feature family.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: Base HDR Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: HDR10 Bonus', 'all', 700);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: HDR10+ Bonus', 'all', 1200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: Dolby Vision Bonus', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: Dolby Vision + HDR Bonus', 'all', 1800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'HDR: Dolby Vision Only Fallback', 'all', 300);

-- Audio rewards lossless/object audio and prefers 7.1, while retaining strong 5.1 credit.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: Surround Bonus', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: 5.1 Surround Preferred', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: 6.1 Bonus', 'all', 650);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: 7.1 Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: Atmos Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: Lossless Track Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: EAC3-AC3 Preferred', 'all', 300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: AAC Fallback Marker', 'all', 20);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Audio: Stereo-2.0 Fallback', 'all', 5);

-- Source and release-fix signals proxy bitrate and provenance without hard size gates.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', '4K: UHD BluRay Preferred', 'all', 1200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', '4K: WEB-DL Preferred', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', '1080p: UHD BluRay Source Bonus', 'all', 900);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', '1080p: BluRay Preferred', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', '1080p: WEB-DL Preferred', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Release: Proper-Repack-Rerip', 'all', 75);

-- Editions are collector refiners, intentionally below technical A/V features.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: IMAX', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: IMAX Enhanced', 'all', 450);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Director''s Cut', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Final Cut', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Extended', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Ultimate Cut', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Special Edition', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Expanded Ratio', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Open Matte', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: VAR', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Remastered', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Restored', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: 4K Scan', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: New Transfer', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Criterion', 'all', 125);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Arrow', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Shout Factory', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: StudioCanal', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Collector''s Edition', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Anniversary Edition', 'all', 75);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best Available Movies', 'Edition: Unrated', 'all', 75);

-- Clone the canonical matrix so all movie profiles tune from one source block.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best 1080p Movies', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - Best Available Movies';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best 4K Movies', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - Best Available Movies';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Catalog 480p-1080p Movies', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - Best Available Movies';

-- Remux is intentionally exclusive to resolution-specific profiles.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Source: Remux Preferred', 'all', 1800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 4K Movies', 'Source: Remux Preferred', 'all', 1800);

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

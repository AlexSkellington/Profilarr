-- Alex_C.T modular Profilarr v2 PCD operations.
-- 09: Sonarr series quality profiles and feature-rich scoring.
-- Requires 01 through 07.
--
-- The three primary profiles share one technical score matrix. The default
-- compares 1080p and 2160p directly, while the targeted profiles constrain
-- that same decision model to a specific resolution.

-- Remove superseded and current managed series profiles before rebuilding them.
DELETE FROM quality_profile_custom_formats WHERE quality_profile_name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);
DELETE FROM quality_group_members WHERE quality_profile_name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);
DELETE FROM quality_profile_qualities WHERE quality_profile_name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);
DELETE FROM quality_groups WHERE quality_profile_name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);
DELETE FROM quality_profile_tags WHERE quality_profile_name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);
DELETE FROM quality_profiles WHERE name IN (
  'Alex_C.T - 1080p-2160p Plex Series', 'Alex_C.T - 4K Plex Series', 'Alex_C.T - Catalog 480p-1080p Plex Series',
  'Alex_C.T - 1080p-2160p Series', 'Alex_C.T - 4K Series',
  'Alex_C.T - Best Available Series', 'Alex_C.T - Best 1080p Series', 'Alex_C.T - Best 4K Series',
  'Alex_C.T - Catalog 480p-1080p Series'
);

-------------------------------------------------------------------------------
-- Profile quality groups
-------------------------------------------------------------------------------

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - 1080p-2160p Series', 'Default feature-first series profile. It compares Remux, BluRay, and WEB-DL releases across 1080p and 2160p in one quality group so HDR, Dolby Vision, audio, source, and language richness can outweigh resolution alone.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Series');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'Remux-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'WEBDL-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'Remux-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 1080p-2160p Series', 'Feature-Rich 1080p-2160p', 1, 1, 1);

-- Compatibility alias retained for Profilarr databases mapped to the v2 name.
INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best Available Series', 'Compatibility alias for Alex_C.T - 1080p-2160p Series. It preserves existing Profilarr mappings while using the same cross-resolution feature-first behavior and shared score matrix.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best Available Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best Available Series', 'Series');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'Remux-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'WEBDL-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'Remux-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best Available Series', 'Feature-Rich 1080p-2160p', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 1080p Series', 'Resolution-specific feature-first series profile. It compares 1080p Remux, BluRay, and WEB-DL releases by technical richness and keeps every accepted episode at 1080p.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Series', 'Series');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 1080p Series', '1080p');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 1080p Series', 'Feature-Rich 1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Series', 'Feature-Rich 1080p', 'Remux-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Series', 'Feature-Rich 1080p', 'Bluray-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 1080p Series', 'Feature-Rich 1080p', 'WEBDL-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 1080p Series', 'Feature-Rich 1080p', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Best 4K Series', 'Resolution-specific feature-first series profile. It compares 2160p Remux, BluRay, and WEB-DL releases by technical richness and keeps every accepted episode at 4K.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Series', 'Series');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Best 4K Series', '4K');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Best 4K Series', 'Feature-Rich 4K');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Series', 'Feature-Rich 4K', 'Remux-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Series', 'Feature-Rich 4K', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Best 4K Series', 'Feature-Rich 4K', 'WEBDL-2160p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Best 4K Series', 'Feature-Rich 4K', 1, 1, 1);

-- Compatibility alias retained for Profilarr databases mapped to the legacy name.
INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - 4K Series', 'Compatibility alias for Alex_C.T - Best 4K Series. It preserves existing Profilarr mappings while using the same strict 2160p feature group and shared score matrix.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Series', 'Series');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Series', '4K');
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - 4K Series', 'Feature-Rich 4K');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 4K Series', 'Feature-Rich 4K', 'Remux-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 4K Series', 'Feature-Rich 4K', 'Bluray-2160p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - 4K Series', 'Feature-Rich 4K', 'WEBDL-2160p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 4K Series', 'Feature-Rich 4K', 1, 1, 1);

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Relaxed series profile for older and scarce shows. It accepts DVD through 1080p, climbs by resolution and source quality, and uses the same feature-rich priorities as the primary series profiles.', 1, 0, 10000, 100);
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Sonarr');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Series');
INSERT INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Catalog');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Bluray-1080p', 1, 1, 1);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 1080p', 'WEBDL-1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 1080p', 'WEBRip-1080p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 1080p', 2, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Bluray-720p', 3, 1, 0);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 720p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 720p', 'WEBDL-720p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 720p', 'WEBRip-720p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 720p', 4, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'HDTV-720p', 5, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Bluray-576p', 6, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'Bluray-480p', 7, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'DVD', 8, 1, 0);
INSERT INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 480p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 480p', 'WEBDL-480p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 480p', 'WEBRip-480p');
INSERT INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Series', 'WEB 480p', 9, 1, 0);

-------------------------------------------------------------------------------
-- Shared series scoring
-------------------------------------------------------------------------------

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: Prefer English + Spanish', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: Spanish Audio Marker', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: English Marker', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: English-Only Backup', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: Spanish-Only Fallback', 'all', 250);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: Latino Spanish Fallback', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Language: Multi-Dual Audio Bonus', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Subtitles: Prefer English + Spanish', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Subtitles: Spanish Bonus', 'all', 60);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Subtitles: English Bonus', 'all', 40);

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Video: 2160p Resolution Bonus', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Codec: HEVC-x265 Preferred', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Codec: AV1 Preferred', 'all', 350);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Codec: VVC-x266 Future', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: Base HDR Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: HDR10 Bonus', 'all', 700);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: HDR10+ Bonus', 'all', 1200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: Dolby Vision Bonus', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: Dolby Vision + HDR Bonus', 'all', 1800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'HDR: Dolby Vision Only Fallback', 'all', 300);

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: Surround Bonus', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: 5.1 Surround Preferred', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: 6.1 Bonus', 'all', 650);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: 7.1 Bonus', 'all', 800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: Atmos Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: Lossless Track Bonus', 'all', 1300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: EAC3-AC3 Preferred', 'all', 300);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: AAC Fallback Marker', 'all', 20);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Audio: Stereo-2.0 Fallback', 'all', 5);

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Source: Remux Preferred', 'all', 1800);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', '4K: UHD BluRay Preferred', 'all', 1200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', '4K: WEB-DL Preferred', 'all', 600);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', '1080p: UHD BluRay Source Bonus', 'all', 900);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', '1080p: BluRay Preferred', 'all', 1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', '1080p: WEB-DL Preferred', 'all', 500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Series', 'Release: Proper-Repack-Rerip', 'all', 75);

-- Clone the canonical matrix so all series profiles tune from one source block.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best Available Series', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - 1080p-2160p Series';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best 1080p Series', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - 1080p-2160p Series';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Best 4K Series', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - 1080p-2160p Series';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - 4K Series', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - 1080p-2160p Series';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT 'Alex_C.T - Catalog 480p-1080p Series', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = 'Alex_C.T - 1080p-2160p Series';

-- Catalog-only lower-resolution source refiners.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '1080p: WEBRip Source', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '1080p: BDRip Source', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '720p: BluRay Preferred', 'all', 400);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '720p: WEB-DL Preferred', 'all', 200);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '720p: WEBRip Source', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '720p: BDRip Source', 'all', 40);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '576p: BluRay Preferred', 'all', 150);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '576p: WEB-DL Preferred', 'all', 60);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '576p: WEBRip Source', 'all', 30);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '576p: BDRip Source', 'all', 30);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '480p: BluRay Preferred', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '480p: WEB-DL Preferred', 'all', 50);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '480p: WEBRip Source', 'all', 25);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Series', '480p: BDRip Source', 'all', 25);

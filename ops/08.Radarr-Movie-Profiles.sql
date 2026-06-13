-- Alex_C.T Smart Plex modular Profilarr v2 PCD operations.
-- 08: Radarr movie quality profiles and custom-format scoring.
-- Requires 01 through 07.
--
-- Movie scoring philosophy:
-- - No negative movie scores.
-- - Better releases rise by stacking positive language, subtitle, codec,
--   HDR, audio, edition, and source bonuses.
-- - Remux avoidance is handled by the quality lanes and source preferences,
--   so the movie profiles themselves stay fully additive.
-- - Individual movie bonuses are intentionally stretched so stacked
--   feature-rich encodes can approach the 9000 to 10000 range without relying
--   on compound combo formats.
-- - Inside each major category, the intent is still a fallback ladder:
--   Dolby Vision + HDR > HDR10+ > HDR10 > base HDR > Main 10 SDR > codec-only,
--   and Atmos > strong surround/DD+ > weaker audio fallbacks.
-- Score-band guide for future tuning:
-- - 1400 to 1800: flagship signals such as top codec, source, or edition wins.
-- - 700 to 1100: strong source and premium-edition preferences that should
--   beat several minor extras on a weaker release.
-- - 150 to 900: meaningful quality lifts such as Atmos, surround, HDR tiers,
--   and major cut/version perks.
-- - 25 to 375: lighter refiners such as language, subtitles, fallback HDR,
--   or boutique-edition bumps.
-- - 20 to 60: tiny fallback markers so weaker releases stay selectable without
--   pulling the ladder negative.

-- Additive 1080p movie profile.
INSERT OR REPLACE INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - 1080p Plex Movies', 'Additive 1080p movie profile. Movies only gain credit for features they actually have, so richer 1080p BluRay and WEB-DL releases rise by stacking language, subtitle, codec, HDR, audio, edition, and source bonuses without any negative movie scores. The score scale is intentionally stretched to 10000 so strong sources stand out at a glance in Profilarr.', 1, 0, 10000, 50);
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 1080p Plex Movies', 'Radarr');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 1080p Plex Movies', 'Movies');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 1080p Plex Movies', '1080p');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 1080p Plex Movies', 'Bluray-1080p', 1, 1, 1);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 1080p Plex Movies', 'WEBDL-1080p', 2, 1, 0);

-- Language (25 to 375): supporting usability without overwhelming source quality.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Language: Prefer English + Spanish', 'all', 375);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Language: Spanish Audio Marker', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Language: English Marker', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Language: English-Only Backup', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Language: Multi-Dual Audio Bonus', 'all', 50);

-- Subtitles (25 to 60): supporting accessibility and subtitle coverage.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Subtitles: Prefer English + Spanish', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Subtitles: Spanish Bonus', 'all', 40);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Subtitles: English Bonus', 'all', 25);

-- Codec and HDR (150 to 1700): strongest pure quality and efficiency signals.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Codec: AV1 Preferred', 'all', 1500);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Codec: VVC-x266 Future', 'all', 1000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: Base HDR Bonus', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: HDR10 Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: HDR10+ Bonus', 'all', 400);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: Dolby Vision Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: Dolby Vision + HDR Bonus', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'HDR: Dolby Vision Only Fallback', 'all', 150);

-- Audio (20 to 850): playback-friendly bonuses that refine otherwise similar picks.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: Surround Bonus', 'all', 550);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: 5.1 Surround Preferred', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: 6.1 Bonus', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: 7.1 Bonus', 'all', 150);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: Atmos Bonus', 'all', 850);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: EAC3-AC3 Preferred', 'all', 220);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: AAC Fallback Marker', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Audio: Stereo-2.0 Fallback', 'all', 20);

-- Editions and release fixes (30 to 1700): collector value and version upgrades.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: IMAX', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: IMAX Enhanced', 'all', 1600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Director''s Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Final Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Extended', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Ultimate Cut', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Special Edition', 'all', 450);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Expanded Ratio', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Open Matte', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: VAR', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Remastered', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Restored', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: 4K Scan', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: New Transfer', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Criterion', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Arrow', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Shout Factory', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: StudioCanal', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Collector''s Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Anniversary Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Edition: Unrated', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Release: Proper-Repack-Rerip', 'all', 30);

-- Source and resolution
-- Source (700 to 1400): keep real BluRay encodes ahead of comparable WEB-DLs.
-- Example: Movie.2024.1080p.BluRay.x265.DTS5.1 should beat
-- Movie.2024.1080p.WEB-DL.x265.DDP5.1 unless the WEB copy also stacks several
-- extra wins such as better language coverage, subtitles, and HDR markers.
-- Example: Movie.2024.1080p.UHD.BluRay.x265.HDR10.Atmos should comfortably
-- outrank a plain 1080p WEB-DL on source strength before the other bonuses stack.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', '1080p: UHD BluRay Source Bonus', 'all', 700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', '1080p: BluRay Preferred', 'all', 1400);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', '1080p: WEB-DL Preferred', 'all', 900);

-- Additive 4K movie profile.
INSERT OR REPLACE INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - 4K Plex Movies', 'Additive 4K movie profile. Movies only gain credit for features they actually have, so richer 2160p BluRay and WEB-DL releases rise by stacking language, subtitle, codec, HDR, audio, edition, and source bonuses without any negative movie scores. The score scale is intentionally stretched to 10000 so strong sources stand out at a glance in Profilarr.', 1, 0, 10000, 50);
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Plex Movies', 'Radarr');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Plex Movies', 'Movies');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - 4K Plex Movies', '4K');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 4K Plex Movies', 'Bluray-2160p', 1, 1, 1);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - 4K Plex Movies', 'WEBDL-2160p', 2, 1, 0);

-- Language (25 to 375): supporting usability without overwhelming source quality.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Language: Prefer English + Spanish', 'all', 375);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Language: Spanish Audio Marker', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Language: English Marker', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Language: English-Only Backup', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Language: Multi-Dual Audio Bonus', 'all', 50);

-- Subtitles (25 to 60): supporting accessibility and subtitle coverage.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Subtitles: Prefer English + Spanish', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Subtitles: Spanish Bonus', 'all', 40);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Subtitles: English Bonus', 'all', 25);

-- Codec and HDR (150 to 1700): strongest pure quality and efficiency signals.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Codec: AV1 Preferred', 'all', 1500);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Codec: VVC-x266 Future', 'all', 1000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: Base HDR Bonus', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: HDR10 Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: HDR10+ Bonus', 'all', 400);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: Dolby Vision Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: Dolby Vision + HDR Bonus', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'HDR: Dolby Vision Only Fallback', 'all', 150);

-- Audio (20 to 850): playback-friendly bonuses that refine otherwise similar picks.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: Surround Bonus', 'all', 550);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: 5.1 Surround Preferred', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: 6.1 Bonus', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: 7.1 Bonus', 'all', 150);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: Atmos Bonus', 'all', 850);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: EAC3-AC3 Preferred', 'all', 220);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: AAC Fallback Marker', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Audio: Stereo-2.0 Fallback', 'all', 20);

-- Editions and release fixes (30 to 1700): collector value and version upgrades.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: IMAX', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: IMAX Enhanced', 'all', 1600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Director''s Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Final Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Extended', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Ultimate Cut', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Special Edition', 'all', 450);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Expanded Ratio', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Open Matte', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: VAR', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Remastered', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Restored', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: 4K Scan', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: New Transfer', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Criterion', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Arrow', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Shout Factory', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: StudioCanal', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Collector''s Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Anniversary Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Edition: Unrated', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Release: Proper-Repack-Rerip', 'all', 30);

-- Source and resolution
-- Source (1100 to 1700): UHD BluRay should stay clearly ahead of comparable 4K WEB.
-- Example: Movie.2024.2160p.UHD.BluRay.x265.HDR10.Atmos should stay above
-- Movie.2024.2160p.WEB-DL.x265.DDP5.1 on source strength even before other
-- additive bonuses are counted.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', '4K: UHD BluRay Preferred', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', '4K: WEB-DL Preferred', 'all', 1100);

-- Additive catalog movie profile.
INSERT OR REPLACE INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Additive catalog movie profile for older or hard-to-find titles. Movies only gain credit for features they actually have, so 480p through 1080p options can still float upward on better language, subtitle, codec, HDR, audio, edition, and source signals without any negative movie scores. The score scale is intentionally stretched to 10000 so stronger sources still stand out clearly inside the catalog lane.', 1, 0, 10000, 50);
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Radarr');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Movies');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p');
INSERT OR REPLACE INTO quality_profile_tags (quality_profile_name, tag_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Catalog');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Bluray-1080p', 1, 1, 1);
INSERT OR REPLACE INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 1080p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 1080p', 'WEBDL-1080p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 1080p', 'WEBRip-1080p');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 1080p', 2, 1, 0);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Bluray-720p', 3, 1, 0);
INSERT OR REPLACE INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 720p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 720p', 'WEBDL-720p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 720p', 'WEBRip-720p');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 720p', 4, 1, 0);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Bluray-576p', 5, 1, 0);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Bluray-480p', 6, 1, 0);
INSERT OR REPLACE INTO quality_groups (quality_profile_name, name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 480p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 480p', 'WEBDL-480p');
INSERT OR REPLACE INTO quality_group_members (quality_profile_name, quality_group_name, quality_name) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 480p', 'WEBRip-480p');
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_group_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'WEB 480p', 7, 1, 0);
INSERT OR REPLACE INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'DVD', 8, 1, 0);

-- Language (25 to 375): supporting usability without overwhelming source quality.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Language: Prefer English + Spanish', 'all', 375);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Language: Spanish Audio Marker', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Language: English Marker', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Language: English-Only Backup', 'all', 25);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Language: Multi-Dual Audio Bonus', 'all', 50);

-- Subtitles (25 to 60): supporting accessibility and subtitle coverage.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Subtitles: Prefer English + Spanish', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Subtitles: Spanish Bonus', 'all', 40);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Subtitles: English Bonus', 'all', 25);

-- Codec and HDR (150 to 1700): strongest pure quality and efficiency signals.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Codec: AV1 Preferred', 'all', 1500);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Codec: VVC-x266 Future', 'all', 1000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: Base HDR Bonus', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: HDR10 Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: HDR10+ Bonus', 'all', 400);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: Dolby Vision Bonus', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: Dolby Vision + HDR Bonus', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'HDR: Dolby Vision Only Fallback', 'all', 150);

-- Audio (20 to 850): playback-friendly bonuses that refine otherwise similar picks.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: Surround Bonus', 'all', 550);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: 5.1 Surround Preferred', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: 6.1 Bonus', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: 7.1 Bonus', 'all', 150);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: Atmos Bonus', 'all', 850);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: EAC3-AC3 Preferred', 'all', 220);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: AAC Fallback Marker', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Audio: Stereo-2.0 Fallback', 'all', 20);

-- Editions and release fixes (30 to 1700): collector value and version upgrades.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: IMAX', 'all', 1700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: IMAX Enhanced', 'all', 1600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Director''s Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Final Cut', 'all', 800);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Extended', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Ultimate Cut', 'all', 600);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Special Edition', 'all', 450);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Expanded Ratio', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Open Matte', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: VAR', 'all', 350);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Remastered', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Restored', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: 4K Scan', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: New Transfer', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Criterion', 'all', 300);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Arrow', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Shout Factory', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: StudioCanal', 'all', 250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Collector''s Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Anniversary Edition', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Edition: Unrated', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Release: Proper-Repack-Rerip', 'all', 30);

-- Source and resolution
-- Catalog source gaps stay narrower than the main movie profiles so a rare but
-- feature-rich WEB release can still beat a crusty fallback encode when the
-- title does not have a truly strong disc-sourced option available.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p: UHD BluRay Source Bonus', 'all', 500);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p: BluRay Preferred', 'all', 1100);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p: WEB-DL Preferred', 'all', 700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p: WEBRip Source', 'all', 180);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '1080p: BDRip Source', 'all', 120);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '720p: BluRay Preferred', 'all', 700);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '720p: WEB-DL Preferred', 'all', 400);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '720p: WEBRip Source', 'all', 150);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '720p: BDRip Source', 'all', 100);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '576p: BluRay Preferred', 'all', 450);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '576p: WEB-DL Preferred', 'all', 200);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '576p: WEBRip Source', 'all', 60);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '576p: BDRip Source', 'all', 40);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '480p: BluRay Preferred', 'all', 320);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '480p: WEB-DL Preferred', 'all', 120);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '480p: WEBRip Source', 'all', 40);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', '480p: BDRip Source', 'all', 20);

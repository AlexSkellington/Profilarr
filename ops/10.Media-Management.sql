-- Alex_C.T Media Server modular Profilarr v2 PCD operations.
-- 10: Naming settings, media settings, and quality definitions.
-- Requires 01.Core-Tags-Languages-Qualities.sql.

INSERT OR IGNORE INTO tags (name) VALUES ('Media Management');
INSERT OR IGNORE INTO tags (name) VALUES ('Naming');
INSERT OR IGNORE INTO tags (name) VALUES ('Quality Definitions');
INSERT OR IGNORE INTO tags (name) VALUES ('Media Settings');
INSERT OR IGNORE INTO tags (name) VALUES ('Media Naming');

INSERT OR REPLACE INTO radarr_naming
(name, rename, movie_format, movie_folder_format, replace_illegal_characters, colon_replacement_format)
VALUES (
  'Alex_CT Media Server Radarr Naming',
  1,
  '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}} {edition-{Edition Tags}} - {[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{-Release Group}',
  '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}',
  1,
  'smart'
);

INSERT OR REPLACE INTO sonarr_naming
(name, rename, standard_episode_format, daily_episode_format, anime_episode_format, series_folder_format, season_folder_format, replace_illegal_characters, colon_replacement_format, custom_colon_replacement_format, multi_episode_style)
VALUES (
  'Alex_CT Media Server Sonarr Naming',
  1,
  '{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} - {[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{-Release Group}',
  '{Series TitleYear} - {Air-Date} - {Episode CleanTitle} - {[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{-Release Group}',
  '{Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} - {[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{-Release Group}',
  '{Series TitleYear}',
  'Season {season:00}',
  1,
  4,
  NULL,
  5
);

INSERT OR REPLACE INTO radarr_media_settings
(name, propers_repacks, enable_media_info)
VALUES ('Alex_CT Media Server Radarr Media Settings', 'preferAndUpgrade', 1);

INSERT OR REPLACE INTO sonarr_media_settings
(name, propers_repacks, enable_media_info)
VALUES ('Alex_CT Media Server Sonarr Media Settings', 'preferAndUpgrade', 1);

-- Quality definitions are stored in MiB per minute.
-- Source ladder: HDTV < WEBRip < WEBDL < Bluray < Remux.
--
-- Radarr 120-minute reference targets after the premium movie widening:
--   WEBDL-1080p  = 4.10 / 7.62 / 16.41 GiB
--   Bluray-1080p = 6.80 / 11.72 / 24.61 GiB
--   WEBDL-2160p  = 7.62 / 16.41 / 35.16 GiB
--   Bluray-2160p = 8.79 / 22.27 / 50.39 GiB
--
-- Sonarr 45-minute reference targets stay conservative on purpose:
--   Bluray-1080p = 1.54 / 2.42 / 4.39 GiB
--   WEBDL-2160p  = 1.76 / 3.96 / 7.91 GiB
--   Bluray-2160p = 3.30 / 5.49 / 10.55 GiB

-------------------------------------------------------------------------------
-- Radarr quality definitions
-------------------------------------------------------------------------------

DELETE FROM radarr_quality_definitions
WHERE name = 'Alex_CT Media Server Radarr Quality Definitions';

INSERT INTO radarr_quality_definitions
(name, quality_name, min_size, max_size, preferred_size) VALUES
('Alex_CT Media Server Radarr Quality Definitions', 'Unknown', 5, 90, 40),
('Alex_CT Media Server Radarr Quality Definitions', 'WORKPRINT', 0, 20, 8),
('Alex_CT Media Server Radarr Quality Definitions', 'CAM', 0, 20, 8),
('Alex_CT Media Server Radarr Quality Definitions', 'TELESYNC', 0, 25, 10),
('Alex_CT Media Server Radarr Quality Definitions', 'TELECINE', 2, 30, 12),
('Alex_CT Media Server Radarr Quality Definitions', 'REGIONAL', 3, 40, 15),
('Alex_CT Media Server Radarr Quality Definitions', 'DVDSCR', 2, 15, 6),
('Alex_CT Media Server Radarr Quality Definitions', 'SDTV', 2, 7, 4),
('Alex_CT Media Server Radarr Quality Definitions', 'DVD', 4, 12, 7),
('Alex_CT Media Server Radarr Quality Definitions', 'DVD-R', 5, 16, 9),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBRip-480p', 3, 9, 5),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBDL-480p', 3, 10, 6),
('Alex_CT Media Server Radarr Quality Definitions', 'Bluray-480p', 5, 14, 8),
('Alex_CT Media Server Radarr Quality Definitions', 'Bluray-576p', 6, 18, 10),
('Alex_CT Media Server Radarr Quality Definitions', 'HDTV-720p', 10, 28, 16),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBRip-720p', 12, 34, 20),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBDL-720p', 14, 38, 22),
('Alex_CT Media Server Radarr Quality Definitions', 'Bluray-720p', 18, 46, 28),
('Alex_CT Media Server Radarr Quality Definitions', 'HDTV-1080p', 25, 65, 40),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBRip-1080p', 30, 78, 48),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBDL-1080p', 35, 140, 65),
('Alex_CT Media Server Radarr Quality Definitions', 'Bluray-1080p', 58, 210, 100),
('Alex_CT Media Server Radarr Quality Definitions', 'Remux-1080p', 102, 320, 180),
('Alex_CT Media Server Radarr Quality Definitions', 'HDTV-2160p', 50, 120, 75),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBRip-2160p', 55, 150, 90),
('Alex_CT Media Server Radarr Quality Definitions', 'WEBDL-2160p', 65, 300, 140),
('Alex_CT Media Server Radarr Quality Definitions', 'Bluray-2160p', 75, 430, 190),
('Alex_CT Media Server Radarr Quality Definitions', 'Remux-2160p', 187, 650, 350),
('Alex_CT Media Server Radarr Quality Definitions', 'BR-DISK', 187, 1000, 500),
('Alex_CT Media Server Radarr Quality Definitions', 'Raw-HD', 100, 500, 250);

-------------------------------------------------------------------------------
-- Sonarr quality definitions
-------------------------------------------------------------------------------

DELETE FROM sonarr_quality_definitions
WHERE name = 'Alex_CT Media Server Sonarr Quality Definitions';

INSERT INTO sonarr_quality_definitions
(name, quality_name, min_size, max_size, preferred_size) VALUES
('Alex_CT Media Server Sonarr Quality Definitions', 'Unknown', 2, 8, 4),
('Alex_CT Media Server Sonarr Quality Definitions', 'SDTV', 2, 7, 4),
('Alex_CT Media Server Sonarr Quality Definitions', 'DVD', 4, 12, 7),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBRip-480p', 3, 9, 5),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBDL-480p', 3, 10, 6),
('Alex_CT Media Server Sonarr Quality Definitions', 'Bluray-480p', 5, 14, 8),
('Alex_CT Media Server Sonarr Quality Definitions', 'Bluray-576p', 6, 18, 10),
('Alex_CT Media Server Sonarr Quality Definitions', 'HDTV-720p', 8, 28, 15),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBRip-720p', 10, 32, 18),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBDL-720p', 12, 36, 20),
('Alex_CT Media Server Sonarr Quality Definitions', 'Bluray-720p', 15, 45, 25),
('Alex_CT Media Server Sonarr Quality Definitions', 'HDTV-1080p', 15, 55, 28),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBRip-1080p', 18, 65, 32),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBDL-1080p', 20, 75, 38),
('Alex_CT Media Server Sonarr Quality Definitions', 'Bluray-1080p', 35, 100, 55),
('Alex_CT Media Server Sonarr Quality Definitions', 'Remux-1080p', 69, 250, 130),
('Alex_CT Media Server Sonarr Quality Definitions', 'HDTV-2160p', 30, 120, 60),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBRip-2160p', 35, 150, 75),
('Alex_CT Media Server Sonarr Quality Definitions', 'WEBDL-2160p', 40, 180, 90),
('Alex_CT Media Server Sonarr Quality Definitions', 'Bluray-2160p', 75, 240, 125),
('Alex_CT Media Server Sonarr Quality Definitions', 'Remux-2160p', 187, 650, 350),
('Alex_CT Media Server Sonarr Quality Definitions', 'Raw-HD', 50, 250, 100);

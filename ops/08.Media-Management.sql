-- Alex_C.T Smart Plex modular Profilarr v2 PCD operations.
-- 08: Naming settings, media settings, and quality definitions.
-- Requires 01.Core-Tags-Languages-Qualities.sql.

INSERT OR REPLACE INTO tags (name) VALUES ('Media Management');
INSERT OR REPLACE INTO tags (name) VALUES ('Naming');
INSERT OR REPLACE INTO tags (name) VALUES ('Quality Definitions');
INSERT OR REPLACE INTO tags (name) VALUES ('Media Settings');
INSERT OR REPLACE INTO tags (name) VALUES ('Plex Naming');

INSERT OR REPLACE INTO radarr_naming
(name, rename, movie_format, movie_folder_format, replace_illegal_characters, colon_replacement_format)
VALUES (
  'Alex_CT Smart Plex Radarr Naming',
  1,
  '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}} {edition-{Edition Tags}} - {[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo VideoCodec]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{-Release Group}',
  '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}',
  1,
  'smart'
);

INSERT OR REPLACE INTO sonarr_naming
(name, rename, standard_episode_format, daily_episode_format, anime_episode_format, series_folder_format, season_folder_format, replace_illegal_characters, colon_replacement_format, custom_colon_replacement_format, multi_episode_style)
VALUES (
  'Alex_CT Smart Plex Sonarr Naming',
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
VALUES ('Alex_CT Smart Plex Radarr Media Settings', 'preferAndUpgrade', 1);

INSERT OR REPLACE INTO sonarr_media_settings
(name, propers_repacks, enable_media_info)
VALUES ('Alex_CT Smart Plex Sonarr Media Settings', 'preferAndUpgrade', 1);

-- Radarr quality definitions, stored as MiB/min.
DELETE FROM radarr_quality_definitions
WHERE name = 'Alex_CT Smart Plex Radarr Quality Definitions';

INSERT OR REPLACE INTO radarr_quality_definitions
(name, quality_name, min_size, max_size, preferred_size) VALUES
('Alex_CT Smart Plex Radarr Quality Definitions', 'Unknown', 10, 90, 45),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WORKPRINT', 0, 30, 10),
('Alex_CT Smart Plex Radarr Quality Definitions', 'CAM', 0, 25, 8),
('Alex_CT Smart Plex Radarr Quality Definitions', 'TELESYNC', 0, 30, 10),
('Alex_CT Smart Plex Radarr Quality Definitions', 'TELECINE', 2, 35, 12),
('Alex_CT Smart Plex Radarr Quality Definitions', 'REGIONAL', 3, 40, 15),
('Alex_CT Smart Plex Radarr Quality Definitions', 'DVDSCR', 2, 15, 6),
('Alex_CT Smart Plex Radarr Quality Definitions', 'SDTV', 2, 8, 4),
('Alex_CT Smart Plex Radarr Quality Definitions', 'DVD', 2, 10, 5),
('Alex_CT Smart Plex Radarr Quality Definitions', 'DVD-R', 4, 15, 8),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBDL-480p', 2, 10, 5),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBRip-480p', 2, 10, 5),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Bluray-480p', 3, 12, 6),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Bluray-576p', 3, 14, 7),
('Alex_CT Smart Plex Radarr Quality Definitions', 'HDTV-720p', 7, 40, 16),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBDL-720p', 7, 50, 18),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBRip-720p', 7, 45, 17),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Bluray-720p', 9, 55, 22),
('Alex_CT Smart Plex Radarr Quality Definitions', 'HDTV-1080p', 28, 85, 42),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBDL-1080p', 35, 125, 54),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBRip-1080p', 32, 115, 48),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Bluray-1080p', 68, 102, 85),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Remux-1080p', 60, 180, 95),
('Alex_CT Smart Plex Radarr Quality Definitions', 'HDTV-2160p', 32, 110, 52),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBDL-2160p', 36, 145, 60),
('Alex_CT Smart Plex Radarr Quality Definitions', 'WEBRip-2160p', 34, 135, 56),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Bluray-2160p', 42, 170, 72),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Remux-2160p', 120, 450, 220),
('Alex_CT Smart Plex Radarr Quality Definitions', 'BR-DISK', 120, 450, 220),
('Alex_CT Smart Plex Radarr Quality Definitions', 'Raw-HD', 25, 100, 50);

-- Sonarr quality definitions, stored as MiB/min.
DELETE FROM sonarr_quality_definitions
WHERE name = 'Alex_CT Smart Plex Sonarr Quality Definitions';

INSERT OR REPLACE INTO sonarr_quality_definitions
(name, quality_name, min_size, max_size, preferred_size) VALUES
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Unknown', 2, 8, 4),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'SDTV', 2, 8, 4),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBRip-480p', 2, 7, 3),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBDL-480p', 2, 7, 4),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'DVD', 2, 8, 4),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Bluray-480p', 3, 10, 5),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Bluray-576p', 3, 12, 6),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'HDTV-720p', 4, 28, 10),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'HDTV-1080p', 16, 58, 24),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Raw-HD', 25, 100, 50),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBRip-720p', 5, 32, 12),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBDL-720p', 5, 34, 13),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Bluray-720p', 7, 40, 16),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBRip-1080p', 19, 72, 30),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBDL-1080p', 20, 80, 36),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Bluray-1080p', 25, 95, 44),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Remux-1080p', 60, 140, 90),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'HDTV-2160p', 31, 150, 60),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBRip-2160p', 38, 210, 85),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'WEBDL-2160p', 42, 220, 92),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Bluray-2160p', 50, 240, 105),
('Alex_CT Smart Plex Sonarr Quality Definitions', 'Remux-2160p', 120, 450, 220);

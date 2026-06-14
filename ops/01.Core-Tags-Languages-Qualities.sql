-- Alex_C.T Media Server modular Profilarr v2 PCD operations.
-- 01: Core tags, languages, and quality names.
-- Import first.
--
-- IMPORTANT:
-- Use INSERT OR IGNORE for schema-seeded qualities.
-- SQLite INSERT OR REPLACE deletes the existing row before inserting it again,
-- which cascades into quality_api_mappings and prevents Profilarr from mapping
-- most quality definitions to Radarr/Sonarr.

INSERT OR IGNORE INTO tags (name) VALUES ('Media Server');
INSERT OR IGNORE INTO tags (name) VALUES ('Language');
INSERT OR IGNORE INTO tags (name) VALUES ('Subtitles');
INSERT OR IGNORE INTO tags (name) VALUES ('Codec');
INSERT OR IGNORE INTO tags (name) VALUES ('HDR / 4K');
INSERT OR IGNORE INTO tags (name) VALUES ('Audio');
INSERT OR IGNORE INTO tags (name) VALUES ('Blocking');
INSERT OR IGNORE INTO tags (name) VALUES ('Scoring');
INSERT OR IGNORE INTO tags (name) VALUES ('Movies');
INSERT OR IGNORE INTO tags (name) VALUES ('Series');
INSERT OR IGNORE INTO tags (name) VALUES ('Radarr');
INSERT OR IGNORE INTO tags (name) VALUES ('Sonarr');
INSERT OR IGNORE INTO tags (name) VALUES ('1080p');
INSERT OR IGNORE INTO tags (name) VALUES ('4K');
INSERT OR IGNORE INTO tags (name) VALUES ('Catalog');
INSERT OR IGNORE INTO tags (name) VALUES ('Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Size Bands');
INSERT OR IGNORE INTO tags (name) VALUES ('Movie Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Compact');
INSERT OR IGNORE INTO tags (name) VALUES ('Premium');
INSERT OR IGNORE INTO tags (name) VALUES ('Remux');
INSERT OR IGNORE INTO tags (name) VALUES ('720p');
INSERT OR IGNORE INTO tags (name) VALUES ('Archive');
INSERT OR IGNORE INTO tags (name) VALUES ('Editions');
INSERT OR IGNORE INTO tags (name) VALUES ('Release Fixes');

INSERT OR IGNORE INTO languages (name) VALUES ('Any');
INSERT OR IGNORE INTO languages (name) VALUES ('English');
INSERT OR IGNORE INTO languages (name) VALUES ('Spanish');

-- These names intentionally match the canonical names seeded by the
-- Dictionarry-Hub/schema dependency so their quality_api_mappings remain intact.
INSERT OR IGNORE INTO qualities (name) VALUES ('Unknown');
INSERT OR IGNORE INTO qualities (name) VALUES ('WORKPRINT');
INSERT OR IGNORE INTO qualities (name) VALUES ('CAM');
INSERT OR IGNORE INTO qualities (name) VALUES ('TELESYNC');
INSERT OR IGNORE INTO qualities (name) VALUES ('TELECINE');
INSERT OR IGNORE INTO qualities (name) VALUES ('DVDSCR');
INSERT OR IGNORE INTO qualities (name) VALUES ('REGIONAL');
INSERT OR IGNORE INTO qualities (name) VALUES ('SDTV');
INSERT OR IGNORE INTO qualities (name) VALUES ('DVD');
INSERT OR IGNORE INTO qualities (name) VALUES ('DVD-R');
INSERT OR IGNORE INTO qualities (name) VALUES ('HDTV-720p');
INSERT OR IGNORE INTO qualities (name) VALUES ('HDTV-1080p');
INSERT OR IGNORE INTO qualities (name) VALUES ('HDTV-2160p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBDL-480p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBDL-720p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBDL-1080p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBDL-2160p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBRip-480p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBRip-720p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBRip-1080p');
INSERT OR IGNORE INTO qualities (name) VALUES ('WEBRip-2160p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Bluray-480p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Bluray-576p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Bluray-720p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Bluray-1080p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Bluray-2160p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Remux-1080p');
INSERT OR IGNORE INTO qualities (name) VALUES ('Remux-2160p');
INSERT OR IGNORE INTO qualities (name) VALUES ('BR-DISK');
INSERT OR IGNORE INTO qualities (name) VALUES ('Raw-HD');


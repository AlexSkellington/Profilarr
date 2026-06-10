-- Alex_C.T Smart Plex modular Profilarr v2 PCD operations.
-- 10: Size-based micro-encode guards.
-- Supplemental protection against suspiciously tiny 1080p/4K releases.
-- Import last, after the profiles exist.
--
-- Quality Definitions in 08.Media-Management.sql are the primary runtime-aware
-- limits. These total-size guards only catch unusually tiny releases.

INSERT OR IGNORE INTO tags (name) VALUES ('Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Micro Encode');
INSERT OR IGNORE INTO tags (name) VALUES ('Bitrate Guard');

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES (
  'Size Guard: 1080p Only Marker',
  '(?i)^(?=.*\b1080p\b)(?!.*\b(?:2160p|4k)\b).*$',
  'Matches 1080p releases while excluding true 2160p/4K releases.'
);
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 1080p Only Marker', 'Size Guards');

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES (
  'Size Guard: 4K Marker',
  '(?i)^(?=.*\b(?:2160p|4k)\b).*$',
  'Matches releases tagged as 2160p or 4K.'
);
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 4K Marker', 'Size Guards');

-- 1080p movie under 5 GiB.
-- This is a hard-block score in the primary profile. The runtime-aware
-- Bluray-1080p Quality Definition in 08.Media-Management.sql remains the
-- actual 8-12 GiB guardrail for a typical 120-minute Blu-ray movie.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 1080p Movie Micro Encode',
  'Hard penalty for 1080p movie releases under 5 GiB. Helps reject starved x265/AV1 micro-encodes that have the right keywords but poor visual quality.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Movie Micro Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Movie Micro Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Movie Micro Encode', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Movie Micro Encode', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 1080p Movie Micro Encode', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Movie Micro Encode', 'size <= 5 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 1080p Movie Micro Encode', 'size <= 5 GiB', NULL, 5368709120);

-- 4K movie under 7 GiB.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 4K Movie Micro Encode',
  'Penalty for 2160p/4K movie releases under 7 GiB. Keeps compact 4K usable while discouraging very starved 4K encodes.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Micro Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Micro Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Micro Encode', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Movie Micro Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Movie Micro Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Movie Micro Encode', 'size <= 7 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Movie Micro Encode', 'size <= 7 GiB', NULL, 7516192768);

-- 4K movie under 4 GiB.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 4K Movie Tiny Encode',
  'Heavy penalty for 2160p/4K movie releases under 4 GiB. These are usually too starved for the curated 4K path.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Movie Tiny Encode', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Movie Tiny Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Movie Tiny Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Movie Tiny Encode', 'size <= 4 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Movie Tiny Encode', 'size <= 4 GiB', NULL, 4294967296);

-- 1080p episode under 300 MiB.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 1080p Episode Tiny Encode',
  'Light penalty for 1080p episode releases under 300 MiB. Kept mild because TV episode runtimes vary and season packs should not be judged like movies.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', NULL, 314572800);

-- 4K episode under 800 MiB.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 4K Episode Tiny Encode',
  'Penalty for 2160p/4K episode releases under 800 MiB. This catches very tiny 4K TV encodes while avoiding a hard block for normal episode-length variation.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', NULL, 838860800);

-- Radarr strict 1080p movie profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p Plex Movies', 'Size Guard: 1080p Movie Micro Encode', 'all', -50000);

-- Radarr strict 4K movie profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Size Guard: 4K Movie Micro Encode', 'all', -250);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Size Guard: 4K Movie Tiny Encode', 'all', -50000);

-- Radarr relaxed catalog profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Size Guard: 1080p Movie Micro Encode', 'all', -150);

-- Sonarr primary profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Size Guard: 1080p Episode Tiny Encode', 'all', -1000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Size Guard: 4K Episode Tiny Encode', 'all', -3500);

-- Sonarr strict 4K profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Series', 'Size Guard: 4K Episode Tiny Encode', 'all', -6000);

-- Sonarr relaxed catalog profile.
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Series', 'Size Guard: 1080p Episode Tiny Encode', 'all', -500);

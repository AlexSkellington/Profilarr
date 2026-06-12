-- Alex_C.T Smart Plex modular Profilarr v2 PCD operations.
-- 12: Series-only size-based micro-encode guards.
-- Import last, after the profiles exist.
--
-- Movies now use additive scoring without size penalties. Quality Definitions in
-- 10.Media-Management.sql remain the main runtime-aware guardrails, while these
-- total-size checks stay focused on suspiciously tiny TV releases.

INSERT OR IGNORE INTO tags (name) VALUES ('Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Micro Encode');
INSERT OR IGNORE INTO tags (name) VALUES ('Bitrate Guard');

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES (
  'Size Guard: 1080p Only Marker',
  '(?i)^(?=.*\b1080p\b)(?!.*\b(?:2160p|4k)\b).*$',
  'Matches 1080p releases while excluding true 2160p or 4K releases.'
);
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 1080p Only Marker', 'Size Guards');

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES (
  'Size Guard: 4K Marker',
  '(?i)^(?=.*\b(?:2160p|4k)\b).*$',
  'Matches releases tagged as 2160p or 4K.'
);
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 4K Marker', 'Size Guards');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 1080p Episode Tiny Encode',
  'Light penalty for 1080p episode releases under 300 MiB. Kept mild because TV runtimes vary and season packs should not be judged like movies.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', NULL, 314572800);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Guard: 4K Episode Tiny Encode',
  'Penalty for 2160p or 4K episode releases under 800 MiB. This catches very tiny 4K TV encodes while avoiding a hard block for normal runtime variation.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', NULL, 838860800);

INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Size Guard: 1080p Episode Tiny Encode', 'all', -1000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Size Guard: 4K Episode Tiny Encode', 'all', -3500);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Series', 'Size Guard: 4K Episode Tiny Encode', 'all', -6000);
INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Series', 'Size Guard: 1080p Episode Tiny Encode', 'all', -500);

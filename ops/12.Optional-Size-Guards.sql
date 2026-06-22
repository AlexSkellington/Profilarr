-- Alex_C.T modular Profilarr v4 PCD operations.
-- 12: Optional series tiny-release helpers.
-- Requires 01 through 09. No size helper is attached to a managed profile.

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Size Guard: 1080p Only Marker', '(?i)^(?=.*\b1080p\b)(?!.*\b(?:2160p|4k)\b).*$', 'Matches 1080p releases while excluding true 2160p or 4K releases.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 1080p Only Marker', 'Size Guards');
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Size Guard: 4K Marker', '(?i)^(?=.*\b(?:2160p|4k)\b).*$','Matches releases tagged as 2160p or 4K.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 4K Marker', 'Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Micro Encode');
INSERT OR IGNORE INTO tags (name) VALUES ('Bitrate Guard');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Optional helper for 1080p episode releases under 300 MiB. Total release size is only a rough signal because episode runtimes and season packs vary.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', NULL, 314572800);
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Optional helper for 2160p episode releases under 800 MiB. It is intentionally unattached because total release size is not runtime-normalized.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', NULL, 838860800);

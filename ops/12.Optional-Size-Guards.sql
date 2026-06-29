-- Alex_C.T modular Profilarr v4 PCD operations.
-- 12: Movie size bonuses and optional series tiny-release helpers.
-- Requires 01 through 09. Movie bonuses are cumulative total-size proxies for
-- bitrate; episode tiny-release helpers remain unattached.

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Size Guard: 1080p Only Marker', '(?i)^(?=.*\b1080p\b)(?!.*\b(?:2160p|4k)\b).*$', 'Matches 1080p releases while excluding true 2160p or 4K releases.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 1080p Only Marker', 'Size Guards');
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Size Guard: 4K Marker', '(?i)^(?=.*\b(?:2160p|4k)\b).*$','Matches releases tagged as 2160p or 4K.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Size Guard: 4K Marker', 'Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Micro Encode');
INSERT OR IGNORE INTO tags (name) VALUES ('Bitrate Guard');
INSERT OR IGNORE INTO tags (name) VALUES ('Size Bonus');
INSERT OR IGNORE INTO tags (name) VALUES ('Bitrate Proxy');

-- Cumulative movie bonuses. Runtime is unavailable during release matching,
-- so these deliberately use total file size as a modest bitrate proxy.
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 1080p 8 GiB+', 'Adds 100 points to 1080p movies at least 8 GiB. Larger releases also match the higher cumulative tiers.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 8 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 8 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 8 GiB+', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 1080p 8 GiB+', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 8 GiB+', 'size >= 8 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 1080p 8 GiB+', 'size >= 8 GiB', 8589934592, 1099511627776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 1080p 12 GiB+', 'Adds another 100 points to 1080p movies at least 12 GiB.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 12 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 12 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 12 GiB+', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 1080p 12 GiB+', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 12 GiB+', 'size >= 12 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 1080p 12 GiB+', 'size >= 12 GiB', 12884901888, 1099511627776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 1080p 18 GiB+', 'Adds another 100 points to 1080p movies at least 18 GiB, for a maximum cumulative size bonus of 300.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 18 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 1080p 18 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 18 GiB+', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 1080p 18 GiB+', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 1080p 18 GiB+', 'size >= 18 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 1080p 18 GiB+', 'size >= 18 GiB', 19327352832, 1099511627776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 4K 14 GiB+', 'Adds 100 points to 4K movies at least 14 GiB. Larger releases also match the higher cumulative tiers.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 14 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 14 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 14 GiB+', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 4K 14 GiB+', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 14 GiB+', 'size >= 14 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 4K 14 GiB+', 'size >= 14 GiB', 15032385536, 1099511627776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 4K 22 GiB+', 'Adds another 100 points to 4K movies at least 22 GiB.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 22 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 22 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 22 GiB+', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 4K 22 GiB+', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 22 GiB+', 'size >= 22 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 4K 22 GiB+', 'size >= 22 GiB', 23622320128, 1099511627776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Bonus: 4K 32 GiB+', 'Adds another 100 points to 4K movies at least 32 GiB, for a maximum cumulative size bonus of 300.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 32 GiB+', 'Size Bonus');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Bonus: 4K 32 GiB+', 'Bitrate Proxy');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 32 GiB+', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Bonus: 4K 32 GiB+', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Bonus: 4K 32 GiB+', 'size >= 32 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Bonus: 4K 32 GiB+', 'size >= 32 GiB', 34359738368, 1099511627776);

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Size Bonus: 1080p 8 GiB+', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Size Bonus: 1080p 12 GiB+', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 1080p Movies', 'Size Bonus: 1080p 18 GiB+', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 4K Movies', 'Size Bonus: 4K 14 GiB+', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 4K Movies', 'Size Bonus: 4K 22 GiB+', 'all', 100);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Best 4K Movies', 'Size Bonus: 4K 32 GiB+', 'all', 100);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Optional helper for 1080p episode releases under 300 MiB. Total release size is only a rough signal because episode runtimes and season packs vary.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 1080p Episode Tiny Encode', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 1080p Episode Tiny Encode', 'size <= 300 MiB', 0, 314572800);
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Optional helper for 2160p episode releases under 800 MiB. It is intentionally unattached because total release size is not runtime-normalized.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Guard: 4K Episode Tiny Encode', 'Micro Encode');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Guard: 4K Episode Tiny Encode', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Guard: 4K Episode Tiny Encode', 'size <= 800 MiB', 0, 838860800);

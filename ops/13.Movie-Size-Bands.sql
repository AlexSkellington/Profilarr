-- Alex_C.T Media Server modular Profilarr v2 PCD operations.
-- 13: Movie-only size-band eligibility helpers.
-- Import last, after the movie profiles exist.
--
-- These are total-size gates, not runtime-normalized bitrate controls.
-- Quality Definitions in 10.Media-Management.sql remain the main MiB/min
-- guardrails, while these helpers keep each movie profile inside its intended
-- compact, premium, or remux total-size lane.

INSERT OR IGNORE INTO tags (name) VALUES ('Size Bands');
INSERT OR IGNORE INTO tags (name) VALUES ('Movie Size Guards');
INSERT OR IGNORE INTO tags (name) VALUES ('Compact');
INSERT OR IGNORE INTO tags (name) VALUES ('Premium');
INSERT OR IGNORE INTO tags (name) VALUES ('Remux');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 1080p Compact Eligible',
  'Mandatory helper for compact 1080p movie profiles. Matches 1080p releases between about 3.5 GiB and 12 GiB so compact profiles stay in their intended size lane.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Compact Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Compact Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Compact Eligible', 'Compact');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Compact Eligible', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 1080p Compact Eligible', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Compact Eligible', '3.5 GiB to 12 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 1080p Compact Eligible', '3.5 GiB to 12 GiB', 3758096384, 12884901888);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 1080p Premium Eligible',
  'Mandatory helper for premium 1080p movie profiles. Matches 1080p releases between about 7.5 GiB and 24 GiB so the premium lane can stay closer to remux-sized encodes without turning fully remux-first.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Premium Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Premium Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Premium Eligible', 'Premium');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Premium Eligible', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 1080p Premium Eligible', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Premium Eligible', '7.5 GiB to 24 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 1080p Premium Eligible', '7.5 GiB to 24 GiB', 8053063680, 25769803776);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 1080p Remux Eligible',
  'Mandatory helper for remux-first 1080p movie profiles. Matches 1080p releases from about 18 GiB upward so the remux lane stays open to true remuxes and very large premium encodes.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Remux Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Remux Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 1080p Remux Eligible', 'Remux');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Remux Eligible', '1080p marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 1080p Remux Eligible', '1080p marker', 'Size Guard: 1080p Only Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 1080p Remux Eligible', '18 GiB and up', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 1080p Remux Eligible', '18 GiB and up', 19327352832, NULL);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 4K Compact Eligible',
  'Mandatory helper for compact 4K movie profiles. Matches 2160p or 4K releases between about 8 GiB and 22 GiB so compact 4K stays noticeably leaner than the premium and remux lanes.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Compact Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Compact Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Compact Eligible', 'Compact');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Compact Eligible', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 4K Compact Eligible', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Compact Eligible', '8 GiB to 22 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 4K Compact Eligible', '8 GiB to 22 GiB', 8589934592, 23622320128);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 4K Premium Eligible',
  'Mandatory helper for premium 4K movie profiles. Matches 2160p or 4K releases between about 18 GiB and 50 GiB so the premium lane can ride much closer to remux-sized encodes while still staying below true disk-rip territory most of the time.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Premium Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Premium Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Premium Eligible', 'Premium');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Premium Eligible', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 4K Premium Eligible', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Premium Eligible', '18 GiB to 50 GiB', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 4K Premium Eligible', '18 GiB to 50 GiB', 19327352832, 53687091200);

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES (
  'Size Band: 4K Remux Eligible',
  'Mandatory helper for remux-first 4K movie profiles. Matches 2160p or 4K releases from about 35 GiB upward so the remux lane stays open to true remuxes and very large premium encodes.',
  0
);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Remux Eligible', 'Size Bands');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Remux Eligible', 'Movie Size Guards');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Size Band: 4K Remux Eligible', 'Remux');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Remux Eligible', '4K marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Size Band: 4K Remux Eligible', '4K marker', 'Size Guard: 4K Marker');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Size Band: 4K Remux Eligible', '35 GiB and up', 'size', 'all', 0, 1);
INSERT OR REPLACE INTO condition_sizes (custom_format_name, condition_name, min_bytes, max_bytes) VALUES ('Size Band: 4K Remux Eligible', '35 GiB and up', 37580963840, NULL);

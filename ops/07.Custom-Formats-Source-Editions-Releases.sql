-- Alex_C.T Media Server modular Profilarr v2 PCD operations.
-- 07: Source, edition, and release-fix custom formats.
-- Requires 01 through 04.

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Source: Block Remux-Raw Disk', 'Optional strict detector for remux, BD remux, BR-DISK, BD-DISK, and raw-HD style releases. Additive movie profiles can omit it entirely, while stricter profiles can still use it to keep oversized source-grade releases out.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Source: Block Remux-Raw Disk', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Source: Block Remux-Raw Disk', 'Source: Block Remux-Raw Disk', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Source: Block Remux-Raw Disk', 'Source: Block Remux-Raw Disk', 'Source: Block Remux-Raw Disk');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: IMAX', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: IMAX', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: IMAX', 'Edition: IMAX', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: IMAX', 'Edition: IMAX', 'Edition: IMAX');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: IMAX Enhanced', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: IMAX Enhanced', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: IMAX Enhanced', 'Edition: IMAX Enhanced', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: IMAX Enhanced', 'Edition: IMAX Enhanced', 'Edition: IMAX Enhanced');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Open Matte', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Open Matte', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Open Matte', 'Edition: Open Matte', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Open Matte', 'Edition: Open Matte', 'Edition: Open Matte');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: VAR', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: VAR', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: VAR', 'Edition: VAR', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: VAR', 'Edition: VAR', 'Edition: VAR');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Expanded Ratio', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Expanded Ratio', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Expanded Ratio', 'Edition: Expanded Ratio', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Expanded Ratio', 'Edition: Expanded Ratio', 'Edition: Expanded Ratio');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Remastered', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Remastered', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Remastered', 'Edition: Remastered', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Remastered', 'Edition: Remastered', 'Edition: Remastered');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Restored', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Restored', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Restored', 'Edition: Restored', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Restored', 'Edition: Restored', 'Edition: Restored');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: 4K Scan', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: 4K Scan', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: 4K Scan', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: 4K Scan', 'Edition: 4K Scan', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: 4K Scan', 'Edition: 4K Scan', 'Edition: 4K Scan');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Criterion', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Criterion', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Criterion', 'Edition: Criterion', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Criterion', 'Edition: Criterion', 'Edition: Criterion');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Arrow', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Arrow', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Arrow', 'Edition: Arrow', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Arrow', 'Edition: Arrow', 'Edition: Arrow');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Shout Factory', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Shout Factory', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Shout Factory', 'Edition: Shout Factory', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Shout Factory', 'Edition: Shout Factory', 'Edition: Shout Factory');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: StudioCanal', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: StudioCanal', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: StudioCanal', 'Edition: StudioCanal', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: StudioCanal', 'Edition: StudioCanal', 'Edition: StudioCanal');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: New Transfer', 'Quality-edition bonus for New Transfer, New Master, New Scan, Newly Transferred, and Newly Scanned tags. It sits below IMAX/Remastered/Restored but above vague content-edition wording.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: New Transfer', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: New Transfer', 'Edition: New Transfer', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: New Transfer', 'Edition: New Transfer', 'Edition: New Transfer');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Director''s Cut', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Director''s Cut', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Director''s Cut', 'Edition: Director''s Cut', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Director''s Cut', 'Edition: Director''s Cut', 'Edition: Director''s Cut');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Final Cut', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Final Cut', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Final Cut', 'Edition: Final Cut', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Final Cut', 'Edition: Final Cut', 'Edition: Final Cut');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Extended', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Extended', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Extended', 'Edition: Extended', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Extended', 'Edition: Extended', 'Edition: Extended');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Ultimate Cut', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Ultimate Cut', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Ultimate Cut', 'Edition: Ultimate Cut', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Ultimate Cut', 'Edition: Ultimate Cut', 'Edition: Ultimate Cut');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Unrated', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Unrated', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Unrated', 'Edition: Unrated', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Unrated', 'Edition: Unrated', 'Edition: Unrated');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Special Edition', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Special Edition', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Special Edition', 'Edition: Special Edition', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Special Edition', 'Edition: Special Edition', 'Edition: Special Edition');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Collector''s Edition', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Collector''s Edition', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Collector''s Edition', 'Edition: Collector''s Edition', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Collector''s Edition', 'Edition: Collector''s Edition', 'Edition: Collector''s Edition');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Anniversary Edition', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Anniversary Edition', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Anniversary Edition', 'Edition: Anniversary Edition', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Anniversary Edition', 'Edition: Anniversary Edition', 'Edition: Anniversary Edition');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Fan Edit', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Fan Edit', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Fan Edit', 'Edition: Fan Edit', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Fan Edit', 'Edition: Fan Edit', 'Edition: Fan Edit');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: Fan Restoration', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: Fan Restoration', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: Fan Restoration', 'Edition: Fan Restoration', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: Fan Restoration', 'Edition: Fan Restoration', 'Edition: Fan Restoration');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Edition: UpScale', 'Managed media-server custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Edition: UpScale', 'Editions');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Edition: UpScale', 'Edition: UpScale', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Edition: UpScale', 'Edition: UpScale', 'Edition: UpScale');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Release: Proper-Repack-Rerip', 'Modest release-fix bonus for PROPER, REPACK, RERIP, REAL.PROPER, and higher-version proper/repack tags. It is intentionally sized to fix same-tier releases without overpowering BluRay/source/HDR/audio scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Release: Proper-Repack-Rerip', 'Release Fixes');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Release: Proper-Repack-Rerip', 'Release: Proper-Repack-Rerip', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Release: Proper-Repack-Rerip', 'Release: Proper-Repack-Rerip', 'Release: Proper-Repack-Rerip');



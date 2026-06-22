-- Alex_C.T modular Profilarr v4 PCD operations.
-- 03: Video codec regexes, custom formats, conditions, and bindings.
-- Requires 01.

INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Codec: AV1 Preferred', '(?i)\bav1\b', 'High-efficiency alternate codec signal. AV1 stays available for efficient releases, but movie profiles can score it slightly below x265/HEVC when compatibility and consistency matter more than theoretical efficiency.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: AV1 Preferred', 'Codec');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: AV1 Preferred', 'Scoring');
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Codec: VVC-x266 Future', '(?i)\b(?:vvc|h[ ._-]?266|x[ ._-]?266)\b', 'Third-place codec preference. H.266, x266, and VVC are recognized, but they stay below x265 and AV1 in every managed profile.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: VVC-x266 Future', 'Codec');
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Codec: HEVC-x265 Preferred', '(?i)\b(?:hevc|h[ ._-]?265|x[ ._-]?265)\b', 'Primary codec preference across the managed profiles. x265, H.265, and HEVC are scored highest for the best balance of quality, size, and playback compatibility.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: HEVC-x265 Preferred', 'Codec');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: HEVC-x265 Preferred', 'Scoring');
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Codec: x264-H264 Fallback or Penalty', '(?i)\b(?:avc|[xh][ ._-]?264)\b', 'Compatibility codec detector. The default additive profiles simply leave it unused, while optional stricter profiles can still attach it if they want to penalize or block x264/H.264 explicitly.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Blocking');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Scoring');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: AV1 Preferred', 'High-efficiency alternate codec signal. AV1 stays available for efficient releases, but movie profiles can score it slightly below x265/HEVC when compatibility and consistency matter more than theoretical efficiency.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: AV1 Preferred', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: AV1 Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Codec: AV1 Preferred', 'Codec: AV1 Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: AV1 Preferred', 'Codec: AV1 Preferred', 'Codec: AV1 Preferred');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: VVC-x266 Future', 'Third-place codec preference. H.266, x266, and VVC are recognized, but they stay below x265 and AV1 in every managed profile.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: VVC-x266 Future', 'Codec');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Codec: VVC-x266 Future', 'Codec: VVC-x266 Future', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: VVC-x266 Future', 'Codec: VVC-x266 Future', 'Codec: VVC-x266 Future');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: HEVC-x265 Preferred', 'Primary codec preference across the managed profiles. x265, H.265, and HEVC are scored highest for the best balance of quality, size, and playback compatibility.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: HEVC-x265 Preferred', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: HEVC-x265 Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Codec: HEVC-x265 Preferred', 'Codec: HEVC-x265 Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: HEVC-x265 Preferred', 'Codec: HEVC-x265 Preferred', 'Codec: HEVC-x265 Preferred');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Compatibility codec detector. Strict profiles can still score or block x264, H.264, or AVC when needed, while additive movie profiles can omit it so richer codecs win by bonuses alone.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Blocking');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty');

-- Alex_C.T Smart Plex modular Profilarr v2 PCD operations.
-- 06: Codec, HDR, audio, and resolution/source custom formats.
-- Requires 01 through 04.

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: AV1 Preferred', 'High-efficiency alternate codec signal. AV1 stays available for compact releases, but movie profiles can score it slightly below x265/HEVC when compatibility and consistency matter more than theoretical efficiency.', 0);
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

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Soft fallback score for explicit 10-bit SDR / HEVC Main 10 style releases when HDR/Dolby Vision is not advertised. This helps profiles prefer 10-bit by itself after true HDR/DV options, without allowing weak sources to beat the BluRay target ladder.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Compatibility codec detector. Strict profiles can still score or block x264, H.264, or AVC when needed, while additive movie profiles can omit it so richer codecs win by bonuses alone.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Blocking');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty', 'Codec: x264-H264 Fallback or Penalty');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: Base HDR Bonus', 'Base HDR bonus. Keeps HDR above SDR, while still letting the more specific Dolby Vision plus HDR and HDR10+ combinations rise higher.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Base HDR Bonus', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Base HDR Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: Base HDR Bonus', 'HDR: Base HDR Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: Base HDR Bonus', 'HDR: Base HDR Bonus', 'HDR: Base HDR Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: HDR10 Bonus', 'Extra HDR score for HDR10. This sits above generic HDR but below Dolby Vision paired with HDR and below HDR10+.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: HDR10 Bonus', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: HDR10 Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: HDR10 Bonus', 'HDR: HDR10 Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: HDR10 Bonus', 'HDR: HDR10 Bonus', 'HDR: HDR10 Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: HDR10+ Bonus', 'Top non-Dolby-Vision HDR bonus for HDR10+ and HDR10 Plus tags. Combined with Dolby Vision, this becomes the strongest HDR path.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: HDR10+ Bonus', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: HDR10+ Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: HDR10+ Bonus', 'HDR: HDR10+ Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: HDR10+ Bonus', 'HDR: HDR10+ Bonus', 'HDR: HDR10+ Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: Dolby Vision Bonus', 'Standalone Dolby Vision signal for movie scoring. Lets profiles reward Dolby Vision directly without bundling it together with HDR or surround requirements.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision Bonus', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: Dolby Vision Bonus', 'HDR: Dolby Vision Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: Dolby Vision Bonus', 'HDR: Dolby Vision Bonus', 'HDR: Dolby Vision Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: Dolby Vision + HDR Bonus', 'Rewards Dolby Vision only when HDR, HDR10, or HDR10+ is also present. This builds the preferred Dolby Vision plus HDR ladders without overvaluing DV-only releases.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision + HDR Bonus', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision + HDR Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: Dolby Vision + HDR Bonus', 'HDR: Dolby Vision + HDR Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: Dolby Vision + HDR Bonus', 'HDR: Dolby Vision + HDR Bonus', 'HDR: Dolby Vision + HDR Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: Penalize SDR When HDR Expected', 'Optional strict-profile detector for efficient-codec 1080p or 2160p releases that do not advertise HDR, HDR10, HDR10+, DoVi, DV, or Dolby Vision. Additive movie profiles can omit it, while stricter profiles can still force HDR to outrank SDR explicitly.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Penalize SDR When HDR Expected', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: Penalize SDR When HDR Expected', 'HDR: Penalize SDR When HDR Expected', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: Penalize SDR When HDR Expected', 'HDR: Penalize SDR When HDR Expected', 'HDR: Penalize SDR When HDR Expected');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K Gate: Block Missing HDR', 'Optional strict 4K detector for releases that do not advertise HDR. Useful when a profile wants HDR to be a hard requirement instead of a bonus.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Gate: Block Missing HDR', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Gate: Block Missing HDR', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K Gate: Block Missing HDR', '4K Gate: Block Missing HDR', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K Gate: Block Missing HDR', '4K Gate: Block Missing HDR', '4K Gate: Block Missing HDR');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('HDR: Dolby Vision Only Fallback', 'Small Dolby Vision-only fallback score. DV-only releases stay above SDR when necessary, but below every Dolby Vision plus HDR combination.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision Only Fallback', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('HDR: Dolby Vision Only Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('HDR: Dolby Vision Only Fallback', 'HDR: Dolby Vision Only Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('HDR: Dolby Vision Only Fallback', 'HDR: Dolby Vision Only Fallback', 'HDR: Dolby Vision Only Fallback');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: Surround Bonus', 'Standalone surround-audio signal for movie scoring. Matches explicit 5.1+ channel layouts plus Atmos, DTS-HD, and TrueHD style markers without bundling the score together with HDR or codec rules.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Surround Bonus', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Surround Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: Surround Bonus', 'Audio: Surround Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: Surround Bonus', 'Audio: Surround Bonus', 'Audio: Surround Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: 5.1 Surround Preferred', 'Primary surround-audio bonus for 5.1, 6-channel, and 5.1ch tags. This is the main compatibility target for a Plex setup built around a 5.1-capable soundbar.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 5.1 Surround Preferred', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 5.1 Surround Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: 5.1 Surround Preferred', 'Audio: 5.1 Surround Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: 5.1 Surround Preferred', 'Audio: 5.1 Surround Preferred', 'Audio: 5.1 Surround Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: Atmos Bonus', 'Top audio bonus for Dolby Atmos, DDP Atmos, EC3 JOC, and Atmos tags. Atmos is preferred when available because it still rides on a practical Dolby Digital Plus playback path.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Atmos Bonus', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Atmos Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: Atmos Bonus', 'Audio: Atmos Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: Atmos Bonus', 'Audio: Atmos Bonus', 'Audio: Atmos Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: EAC3-AC3 Preferred', 'Preferred Dolby audio-format bonus for EAC3, DDP, DD+, AC3, and Dolby Digital tags. These formats are highly compatible for Plex, eARC, and streaming-style playback.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: EAC3-AC3 Preferred', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: EAC3-AC3 Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: EAC3-AC3 Preferred', 'Audio: EAC3-AC3 Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: EAC3-AC3 Preferred', 'Audio: EAC3-AC3 Preferred', 'Audio: EAC3-AC3 Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: 6.1 Bonus', 'Secondary channel-layout bonus for 6.1 audio. It stays below the main 5.1 and Dolby-format preferences, but above 7.1 and stereo in the fallback ladder.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 6.1 Bonus', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 6.1 Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: 6.1 Bonus', 'Audio: 6.1 Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: 6.1 Bonus', 'Audio: 6.1 Bonus', 'Audio: 6.1 Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: 7.1 Bonus', 'Smaller channel-layout bonus for 7.1 audio. It remains below the 5.1-first compatibility target and below 6.1 in the current managed fallback order.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 7.1 Bonus', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: 7.1 Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: 7.1 Bonus', 'Audio: 7.1 Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: 7.1 Bonus', 'Audio: 7.1 Bonus', 'Audio: 7.1 Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: AAC Fallback Marker', 'Lowest acceptable audio-codec lane. AAC remains allowed so weak fallback releases can still download, but it sits behind EAC3, AC3, DDP, and Atmos once those exist.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: AAC Fallback Marker', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: AAC Fallback Marker', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: AAC Fallback Marker', 'Audio: AAC Fallback Marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: AAC Fallback Marker', 'Audio: AAC Fallback Marker', 'Audio: AAC Fallback Marker');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: Stereo-2.0 Fallback', 'Low-tier stereo fallback signal for 2.0, 2.1, stereo, mono, and dual-mono style tags. Additive movie profiles can give it a tiny credit so weak audio stays below surround-heavy releases without any negative scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Stereo-2.0 Fallback', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Stereo-2.0 Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: Stereo-2.0 Fallback', 'Audio: Stereo-2.0 Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: Stereo-2.0 Fallback', 'Audio: Stereo-2.0 Fallback', 'Audio: Stereo-2.0 Fallback');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Audio: Lossless Size Penalty', 'Optional space-awareness detector for TrueHD, DTS-HD MA, FLAC, PCM, and LPCM. Stricter profiles can use it as a penalty, while additive movie profiles can omit it and let other bonuses drive the choice.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Lossless Size Penalty', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Audio: Lossless Size Penalty', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Audio: Lossless Size Penalty', 'Audio: Lossless Size Penalty', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Audio: Lossless Size Penalty', 'Audio: Lossless Size Penalty', 'Audio: Lossless Size Penalty');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('1080p: UHD BluRay Source Bonus', 'Small positive score for 1080p encodes sourced from UHD BluRay. This replaces the old accidental 4K bonus on 1080p UHD-source releases, so they get credit for the cleaner source without being treated as true 4K.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('1080p: UHD BluRay Source Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p: UHD BluRay Source Bonus', '1080p: UHD BluRay Source Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p: UHD BluRay Source Bonus', '1080p: UHD BluRay Source Bonus', '1080p: UHD BluRay Source Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('1080p: BluRay Preferred', '1080p-only source bonus for BluRay releases. This keeps 1080p BluRay preference separate from the true 4K UHD BluRay preference.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('1080p: BluRay Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p: BluRay Preferred', '1080p: BluRay Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p: BluRay Preferred', '1080p: BluRay Preferred', '1080p: BluRay Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('1080p: WEB-DL Preferred', '1080p-only source bonus for WEB-DL releases. It helps rank clean 1080p WEB-DL fallbacks without applying any 4K-specific logic.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('1080p: WEB-DL Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p: WEB-DL Preferred', '1080p: WEB-DL Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p: WEB-DL Preferred', '1080p: WEB-DL Preferred', '1080p: WEB-DL Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('1080p: WEBRip Source', '1080p-only WEBRip source detector. Strict movie profiles can penalize or block it, while relaxed catalog and series profiles can keep it as a weaker fallback without borrowing generic or 4K source formats.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('1080p: WEBRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p: WEBRip Source', '1080p: WEBRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p: WEBRip Source', '1080p: WEBRip Source', '1080p: WEBRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('1080p: BDRip Source', '1080p-only BDRip source detector. It keeps 1080p BDRip handling separate from true BluRay and from 4K source rules.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('1080p: BDRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p: BDRip Source', '1080p: BDRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p: BDRip Source', '1080p: BDRip Source', '1080p: BDRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('720p: BluRay Preferred', '720p-only BluRay source bonus. Keeps 720p BluRay ranking separate from 1080p and 4K BluRay rules.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('720p: BluRay Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p: BluRay Preferred', '720p: BluRay Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p: BluRay Preferred', '720p: BluRay Preferred', '720p: BluRay Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('720p: WEB-DL Preferred', '720p-only WEB-DL source bonus for clean lower-resolution fallbacks.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('720p: WEB-DL Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p: WEB-DL Preferred', '720p: WEB-DL Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p: WEB-DL Preferred', '720p: WEB-DL Preferred', '720p: WEB-DL Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('720p: WEBRip Source', '720p-only WEBRip source detector for relaxed catalog fallbacks. It does not apply to 1080p or 4K titles.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('720p: WEBRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p: WEBRip Source', '720p: WEBRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p: WEBRip Source', '720p: WEBRip Source', '720p: WEBRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('720p: BDRip Source', '720p-only BDRip source detector for older or hard-to-find catalog releases.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('720p: BDRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p: BDRip Source', '720p: BDRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p: BDRip Source', '720p: BDRip Source', '720p: BDRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('576p: BluRay Preferred', '576p-only BluRay source bonus for PAL/576p-style archive releases.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('576p: BluRay Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('576p: BluRay Preferred', '576p: BluRay Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('576p: BluRay Preferred', '576p: BluRay Preferred', '576p: BluRay Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('576p: WEB-DL Preferred', '576p-only WEB-DL source bonus for lower-resolution catalog fallbacks.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('576p: WEB-DL Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('576p: WEB-DL Preferred', '576p: WEB-DL Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('576p: WEB-DL Preferred', '576p: WEB-DL Preferred', '576p: WEB-DL Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('576p: WEBRip Source', '576p-only WEBRip source detector for archive/catalog scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('576p: WEBRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('576p: WEBRip Source', '576p: WEBRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('576p: WEBRip Source', '576p: WEBRip Source', '576p: WEBRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('576p: BDRip Source', '576p-only BDRip source detector for archive/catalog scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('576p: BDRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('576p: BDRip Source', '576p: BDRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('576p: BDRip Source', '576p: BDRip Source', '576p: BDRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('480p: BluRay Preferred', '480p-only BluRay source bonus for older catalog or archive releases.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('480p: BluRay Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('480p: BluRay Preferred', '480p: BluRay Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('480p: BluRay Preferred', '480p: BluRay Preferred', '480p: BluRay Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('480p: WEB-DL Preferred', '480p-only WEB-DL source bonus for low-resolution catalog fallbacks.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('480p: WEB-DL Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('480p: WEB-DL Preferred', '480p: WEB-DL Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('480p: WEB-DL Preferred', '480p: WEB-DL Preferred', '480p: WEB-DL Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('480p: WEBRip Source', '480p-only WEBRip source detector for relaxed fallback scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('480p: WEBRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('480p: WEBRip Source', '480p: WEBRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('480p: WEBRip Source', '480p: WEBRip Source', '480p: WEBRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('480p: BDRip Source', '480p-only BDRip source detector for relaxed fallback scoring.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('480p: BDRip Source', 'Smart Plex');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('480p: BDRip Source', '480p: BDRip Source', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('480p: BDRip Source', '480p: BDRip Source', '480p: BDRip Source');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K: Block x264-H264', 'Optional strict 4K detector for 2160p releases encoded as x264, H.264, or AVC. Additive movie profiles can skip it, while stricter profiles can still reserve 4K for HEVC, AV1, or VVC.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: Block x264-H264', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: Block x264-H264', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K: Block x264-H264', '4K: Block x264-H264', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K: Block x264-H264', '4K: Block x264-H264', '4K: Block x264-H264');
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K: UHD BluRay Preferred', 'Rewards 4K UHD BluRay or 4K BluRay source tags. Used to prefer cleaner 4K disc-sourced encodes when the file still fits the space-balanced rules.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: UHD BluRay Preferred', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: UHD BluRay Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K: UHD BluRay Preferred', '4K: UHD BluRay Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K: UHD BluRay Preferred', '4K: UHD BluRay Preferred', '4K: UHD BluRay Preferred');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K: WEB-DL Preferred', 'Rewards 4K WEB-DL source tags. Useful for compact, clean 2160p HDR releases that are often smaller than BluRay-derived encodes.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: WEB-DL Preferred', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K: WEB-DL Preferred', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K: WEB-DL Preferred', '4K: WEB-DL Preferred', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K: WEB-DL Preferred', '4K: WEB-DL Preferred', '4K: WEB-DL Preferred');


INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K Source: Block WEBRip', 'Optional strict 4K source detector for WEBRip releases. Additive movie profiles can skip it, while stricter profiles can reserve 4K for cleaner WEB-DL or UHD BluRay style sources.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Source: Block WEBRip', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Source: Block WEBRip', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K Source: Block WEBRip', '4K Source: Block WEBRip', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K Source: Block WEBRip', '4K Source: Block WEBRip', '4K Source: Block WEBRip');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K Source: Block BDRip', 'Optional strict 4K source detector for BDRip releases. Additive movie profiles can skip it, while stricter profiles can reserve 4K for stronger WEB-DL and UHD BluRay style releases.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Source: Block BDRip', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Source: Block BDRip', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K Source: Block BDRip', '4K Source: Block BDRip', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K Source: Block BDRip', '4K Source: Block BDRip', '4K Source: Block BDRip');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K Audio: Block AAC-Only', 'Optional strict 4K audio detector for releases that only advertise AAC audio. Additive movie profiles can skip it, while stricter profiles can still require stronger surround-friendly audio such as EAC3, AC3, DDP, or Atmos.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Audio: Block AAC-Only', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Audio: Block AAC-Only', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Audio: Block AAC-Only', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K Audio: Block AAC-Only', '4K Audio: Block AAC-Only', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K Audio: Block AAC-Only', '4K Audio: Block AAC-Only', '4K Audio: Block AAC-Only');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('4K Gate: Block Missing 5.1+ Surround', 'Optional strict 4K detector for releases that do not show 5.1, 6.1, 7.1, or a known surround-capable codec marker. Additive movie profiles can skip it and let surround bonuses reward richer releases instead.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Gate: Block Missing 5.1+ Surround', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('4K Gate: Block Missing 5.1+ Surround', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('4K Gate: Block Missing 5.1+ Surround', '4K Gate: Block Missing 5.1+ Surround', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('4K Gate: Block Missing 5.1+ Surround', '4K Gate: Block Missing 5.1+ Surround', '4K Gate: Block Missing 5.1+ Surround');

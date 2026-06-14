-- Alex_C.T Media Server modular Profilarr v2 PCD operations.
-- 05: Language and subtitle custom formats, tags, conditions, and regex bindings.
-- Requires 01 through 04.

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Prefer English + Spanish', 'Highest language preference. Rewards releases that appear to include both English and Spanish/Latino language indicators, or a strong Latino/multi-audio signal, so the shared media-server library gets the best bilingual copy first.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Prefer English + Spanish', 'Language');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Prefer English + Spanish', 'Language: Prefer English + Spanish', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Prefer English + Spanish', 'Language: Prefer English + Spanish', 'Language: Prefer English + Spanish');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: English Marker', 'Tiny English-tag confirmation bonus. English is treated as the last language fallback, so this exists mainly to confirm the tag rather than drive the decision.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: English Marker', 'Language');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: English Marker', 'Language: English Marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: English Marker', 'Language: English Marker', 'Language: English Marker');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Spanish Audio Marker', 'Standalone Spanish-audio signal for movie scoring. Matches Spanish, Castellano, Latino, LATAM, and related tags without requiring English or multi-audio to be present.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Spanish Audio Marker', 'Language');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Spanish Audio Marker', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Spanish Audio Marker', 'Language: Spanish Audio Marker', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Spanish Audio Marker', 'Language: Spanish Audio Marker', 'Language: Spanish Audio Marker');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Spanish-Only Fallback', 'Preferred single-language fallback. Rewards explicit Spanish or Castellano tags when a true bilingual English+Spanish release is not available.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Spanish-Only Fallback', 'Language');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Spanish-Only Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Spanish-Only Fallback', 'Language: Spanish-Only Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Spanish-Only Fallback', 'Language: Spanish-Only Fallback', 'Language: Spanish-Only Fallback');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Latino Spanish Fallback', 'Secondary Spanish-friendly fallback for Latino, LATAM, Mexican, or ES-style tags that often imply Spanish audio even when English is not clearly labeled.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Latino Spanish Fallback', 'Language');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Latino Spanish Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Latino Spanish Fallback', 'Language: Latino Spanish Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Latino Spanish Fallback', 'Language: Latino Spanish Fallback', 'Language: Latino Spanish Fallback');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: English-Only Backup', 'Last language fallback. English-only releases stay usable, but they should lose to EN+ES, Spanish, Multi, and Latino-tagged options.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: English-Only Backup', 'Language');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: English-Only Backup', 'Language: English-Only Backup', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: English-Only Backup', 'Language: English-Only Backup', 'Language: English-Only Backup');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Multi-Dual Audio Bonus', 'Middle-tier multilingual bonus. Rewards Multi, Multi5, dual-audio, and dual-language tags, but keeps them below explicit EN+ES and single-language Spanish priorities.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Multi-Dual Audio Bonus', 'Language');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Multi-Dual Audio Bonus', 'Audio');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Multi-Dual Audio Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Multi-Dual Audio Bonus', 'Language: Multi-Dual Audio Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Multi-Dual Audio Bonus', 'Language: Multi-Dual Audio Bonus', 'Language: Multi-Dual Audio Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Language: Block Other Languages', 'Optional strict-profile detector for releases tagged as languages outside the intended English or Spanish-friendly target set, such as French, German, Hindi, Russian, Japanese, and similar tags. Additive movie profiles can omit it entirely.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Block Other Languages', 'Language');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Language: Block Other Languages', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Language: Block Other Languages', 'Language: Block Other Languages', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Language: Block Other Languages', 'Language: Block Other Languages', 'Language: Block Other Languages');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Subtitles: Prefer English + Spanish', 'Rewards releases that appear to include subtitle support for both English and Spanish. This is a strong usability bonus for mixed-language media-server playback.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: Prefer English + Spanish', 'Subtitles');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Subtitles: Prefer English + Spanish', 'Subtitles: Prefer English + Spanish', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Subtitles: Prefer English + Spanish', 'Subtitles: Prefer English + Spanish', 'Subtitles: Prefer English + Spanish');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Subtitles: English Bonus', 'Small subtitle bonus for English subtitle indicators. Useful when audio language is acceptable but subtitle support is still helpful.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: English Bonus', 'Subtitles');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: English Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Subtitles: English Bonus', 'Subtitles: English Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Subtitles: English Bonus', 'Subtitles: English Bonus', 'Subtitles: English Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Subtitles: Spanish Bonus', 'Subtitle bonus for Spanish or Latino subtitle indicators. Helps prefer releases that are easier to use for Spanish viewers.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: Spanish Bonus', 'Subtitles');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: Spanish Bonus', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Subtitles: Spanish Bonus', 'Subtitles: Spanish Bonus', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Subtitles: Spanish Bonus', 'Subtitles: Spanish Bonus', 'Subtitles: Spanish Bonus');

INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Subtitles: Block Hardcoded-Burned-In', 'Optional strict-profile detector for hardcoded, hardsubbed, burned-in, or burnt-in subtitle tags. Additive movie profiles can omit it entirely, while stricter profiles can still use it to avoid non-toggleable subtitles.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: Block Hardcoded-Burned-In', 'Subtitles');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Subtitles: Block Hardcoded-Burned-In', 'Blocking');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Subtitles: Block Hardcoded-Burned-In', 'Subtitles: Block Hardcoded-Burned-In', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Subtitles: Block Hardcoded-Burned-In', 'Subtitles: Block Hardcoded-Burned-In', 'Subtitles: Block Hardcoded-Burned-In');



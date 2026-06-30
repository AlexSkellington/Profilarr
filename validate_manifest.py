#!/usr/bin/env python3
import json
import re
import sqlite3
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent
OPS = ROOT / "ops"

REQUIRED_FILES = [
    "pcd.json",
    "README.md",
    ".gitignore",
    "validate_manifest.py",
    "ops/01.Core-Tags-Languages-Qualities.sql",
    "ops/02.Language-Subtitles.sql",
    "ops/03.Codecs.sql",
    "ops/04.Video-HDR-Resolution.sql",
    "ops/05.Audio.sql",
    "ops/06.Sources-Releases.sql",
    "ops/07.Editions.sql",
    "ops/08.Radarr-Movie-Profiles.sql",
    "ops/09.Sonarr-Series-Profiles.sql",
    "ops/10.Media-Management.sql",
    "ops/11.Delay-Profiles.sql",
    "ops/12.Optional-Size-Guards.sql",
]

OLD_FILES = [
    "download",
    "ops/02.Regular-Expressions-Language-Subtitles.sql",
    "ops/03.Regular-Expressions-Codecs-HDR-Audio.sql",
    "ops/04.Regular-Expressions-Resolution-Source-Editions.sql",
    "ops/05.Custom-Formats-Language-Subtitles.sql",
    "ops/06.Custom-Formats-Codec-HDR-Audio-Resolution.sql",
    "ops/07.Custom-Formats-Source-Editions-Releases.sql",
    "ops/12.Series-Size-Guards.sql",
    "ops/1.Smart-Managed-Library.sql",
    "ops/2.Smart-Plex-Media-Management.sql",
    "ops/3.Smart-Plex-Delay-Profile.sql",
    "ops/4.Smart-Plex-Micro-Encode-Guards.sql",
    "ops/05.Custom-Formats.sql",
    "ops/06.Radarr-Movie-Profiles.sql",
    "ops/07.Sonarr-Series-Profiles.sql",
    "ops/08.Media-Management.sql",
    "ops/09.Delay-Profiles.sql",
    "ops/10.Micro-Encode-Guards.sql",
]

MOVIE_PROFILES = {
    "Alex_C.T - Best 1080p Movies",
    "Alex_C.T - Best 4K Movies",
    "Alex_C.T - Catalog 480p-1080p Movies",
}
SERIES_PROFILES = {
    "Alex_C.T - Best 1080p Series",
    "Alex_C.T - Best 4K Series",
    "Alex_C.T - Catalog 480p-1080p Series",
}
EXPECTED_PROFILES = MOVIE_PROFILES | SERIES_PROFILES
STRICT_PROFILES = {
    "Alex_C.T - Best 1080p Movies",
    "Alex_C.T - Best 4K Movies",
    "Alex_C.T - Best 1080p Series",
    "Alex_C.T - Best 4K Series",
}
REDUNDANT_SOURCE_SCORE_NAMES = {
    "4K: UHD BluRay Preferred",
    "4K: WEB-DL Preferred",
    "1080p: BluRay Preferred",
    "1080p: WEB-DL Preferred",
}
EXPECTED_UPGRADE_SCORE_INCREMENT = {profile: 1 for profile in EXPECTED_PROFILES}
EXPECTED_NEGATIVE_SCORES = {
    "Alex_C.T - Best 1080p Movies": {
        "Language: Block Other Languages": -50000,
        "Subtitles: Block Hardcoded-Burned-In": -50000,
        "Codec: x264-H264 Fallback or Penalty": -800,
    },
    "Alex_C.T - Best 4K Movies": {
        "Language: Block Other Languages": -50000,
        "Subtitles: Block Hardcoded-Burned-In": -50000,
        "4K Gate: Block Missing HDR": -50000,
        "4K: Block x264-H264": -50000,
        "4K Audio: Block AAC-Only": -50000,
        "4K Gate: Block Missing 5.1+ Surround": -50000,
        "4K Source: Block BDRip": -50000,
    },
    "Alex_C.T - Best 1080p Series": {
        "Language: Block Other Languages": -50000,
        "Subtitles: Block Hardcoded-Burned-In": -50000,
    },
    "Alex_C.T - Best 4K Series": {
        "Language: Block Other Languages": -50000,
        "Subtitles: Block Hardcoded-Burned-In": -50000,
        "4K Gate: Block Missing HDR": -50000,
        "4K: Block x264-H264": -50000,
        "4K Audio: Block AAC-Only": -50000,
        "4K Gate: Block Missing 5.1+ Surround": -50000,
        "4K Source: Block BDRip": -50000,
    },
    "Alex_C.T - Catalog 480p-1080p Movies": {},
    "Alex_C.T - Catalog 480p-1080p Series": {},
}
STRICT_BLOCKER_NAMES = {
    name for scores in EXPECTED_NEGATIVE_SCORES.values() for name in scores
}

EXPECTED_QUALITY_ORDER = {
    "Alex_C.T - Best 1080p Movies": ["Bluray-1080p", "WEBDL-1080p"],
    "Alex_C.T - Best 4K Movies": ["Bluray-2160p", "WEBDL-2160p"],
    "Alex_C.T - Catalog 480p-1080p Movies": [
        "Bluray-1080p",
        "WEBDL-1080p",
        "WEBRip-1080p",
        "Bluray-720p",
        "WEBDL-720p",
        "WEBRip-720p",
        "Bluray-576p",
        "Bluray-480p",
        "WEBDL-480p",
        "WEBRip-480p",
        "DVD",
    ],
    "Alex_C.T - Best 1080p Series": ["Bluray-1080p", "WEBDL-1080p"],
    "Alex_C.T - Best 4K Series": ["Bluray-2160p", "WEBDL-2160p"],
    "Alex_C.T - Catalog 480p-1080p Series": [
        "Bluray-1080p",
        "WEBDL-1080p",
        "WEBRip-1080p",
        "Bluray-720p",
        "WEBDL-720p",
        "WEBRip-720p",
        "HDTV-720p",
        "Bluray-576p",
        "Bluray-480p",
        "WEBDL-480p",
        "WEBRip-480p",
        "DVD",
    ],
}

errors = []


def fail(message):
    errors.append(message)


def read(path):
    return (ROOT / path).read_text(encoding="utf-8-sig")


for rel in REQUIRED_FILES:
    if not (ROOT / rel).exists():
        fail(f"Missing required file: {rel}")

for rel in OLD_FILES:
    if (ROOT / rel).exists():
        fail(f"Superseded file should be removed: {rel}")

sql_files = sorted(OPS.glob("*.sql")) if OPS.exists() else []
if len(sql_files) != 12:
    fail(f"Expected exactly 12 SQL operation files, found {len(sql_files)}")

try:
    data = json.loads(read("pcd.json"))
except Exception as exc:
    fail(f"pcd.json is not valid JSON: {exc}")
    data = {}

for key in ["name", "version", "description", "arr_types", "dependencies", "profilarr"]:
    if key not in data:
        fail(f"pcd.json missing required key: {key}")

if data.get("version") != "4.2.4":
    fail("pcd.json version should be 4.2.4 for the movie efficient-codec preference update")
if sorted(data.get("arr_types", [])) != ["radarr", "sonarr"]:
    fail("pcd.json arr_types should be exactly ['radarr', 'sonarr']")
if data.get("profilarr", {}).get("minimum_version") != "2.0.0":
    fail("pcd.json profilarr.minimum_version should be 2.0.0")

texts = {path.name: path.read_text(encoding="utf-8-sig") for path in sql_files}
combined = "\n".join(texts.values())

profile_literal_pattern = r"Alex_C\.T - [^'`\r\n]+(?:Movies|Series)"
profile_module_text = texts.get("08.Radarr-Movie-Profiles.sql", "") + texts.get("09.Sonarr-Series-Profiles.sql", "")
for group_table in ["quality_groups", "quality_group_members", "quality_group_name"]:
    if group_table in profile_module_text:
        fail(f"Profile modules must use direct checked qualities, found: {group_table}")

profile_literals = set(re.findall(profile_literal_pattern, profile_module_text))
if profile_literals != EXPECTED_PROFILES:
    fail(
        "Profile modules contain names outside the canonical six: "
        f"missing={sorted(EXPECTED_PROFILES - profile_literals)}, "
        f"extra={sorted(profile_literals - EXPECTED_PROFILES)}"
    )

documented_profiles = set(re.findall(r"`(Alex_C\.T - [^`]+(?:Movies|Series))`", read("README.md")))
if documented_profiles != EXPECTED_PROFILES:
    fail(
        "README profile names differ from the canonical six: "
        f"missing={sorted(EXPECTED_PROFILES - documented_profiles)}, "
        f"extra={sorted(documented_profiles - EXPECTED_PROFILES)}"
    )


def sql_names(pattern, text):
    return [match.replace("''", "'") for match in re.findall(pattern, text, flags=re.I | re.S)]


profile_pattern = (
    r"INSERT(?:\s+OR\s+REPLACE)?\s+INTO\s+quality_profiles\s*"
    r"\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'"
)
defined_profiles = set(sql_names(profile_pattern, combined))
if defined_profiles != EXPECTED_PROFILES:
    fail(
        "Managed profile definitions differ from the expected six: "
        f"missing={sorted(EXPECTED_PROFILES - defined_profiles)}, "
        f"extra={sorted(defined_profiles - EXPECTED_PROFILES)}"
    )

regex_pattern = (
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+regular_expressions\s*"
    r"\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'"
)
format_pattern = (
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+custom_formats\s*"
    r"\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'"
)
regex_names = sql_names(regex_pattern, combined)
format_names = sql_names(format_pattern, combined)

for label, names in [("regular expression", regex_names), ("custom format", format_names)]:
    duplicates = sorted(name for name, count in Counter(names).items() if count > 1)
    if duplicates:
        fail(f"Duplicate {label} definitions: {duplicates}")

regex_set = set(regex_names)
format_set = set(format_names)

condition_regex_refs = set(
    sql_names(
        r"INSERT\s+OR\s+REPLACE\s+INTO\s+condition_patterns\s*"
        r"\([^)]*\)\s*VALUES\s*\('(?:[^']|'')+',\s*'(?:[^']|'')+',\s*'((?:[^']|'')+)'",
        combined,
    )
)
missing_regexes = sorted(condition_regex_refs - regex_set)
if missing_regexes:
    fail(f"Condition patterns reference undefined regular expressions: {missing_regexes}")

format_ref_patterns = [
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+custom_format_tags\s*\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'",
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+custom_format_conditions\s*\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'",
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+condition_patterns\s*\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'",
    r"INSERT\s+OR\s+REPLACE\s+INTO\s+condition_sizes\s*\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'",
]
format_refs = set()
for pattern in format_ref_patterns:
    format_refs.update(sql_names(pattern, combined))
missing_formats = sorted(format_refs - format_set)
if missing_formats:
    fail(f"Bindings reference undefined custom formats: {missing_formats}")

profile_format_refs = set(
    sql_names(
        r"INSERT(?:\s+OR\s+REPLACE)?\s+INTO\s+quality_profile_custom_formats\s*"
        r"\([^)]*\)\s*VALUES\s*\('(?:[^']|'')+',\s*'((?:[^']|'')+)'",
        combined,
    )
)
missing_profile_formats = sorted(profile_format_refs - format_set)
if missing_profile_formats:
    fail(f"Profiles reference undefined custom formats: {missing_profile_formats}")


def expected_owner(name):
    if name.startswith(("Language:", "Subtitles:")):
        return "02.Language-Subtitles.sql"
    if name.startswith("Codec:"):
        return "03.Codecs.sql"
    if name.startswith(("Audio:", "4K Audio:")) or name == "4K Gate: Block Missing 5.1+ Surround":
        return "05.Audio.sql"
    if name.startswith(("Video:", "HDR:")) or name in {"4K Gate: Block Missing HDR", "4K: Block x264-H264"}:
        return "04.Video-HDR-Resolution.sql"
    if name.startswith("Edition:"):
        return "07.Editions.sql"
    if name.startswith(("Size Guard:", "Size Bonus:")):
        return "12.Optional-Size-Guards.sql"
    return "06.Sources-Releases.sql"


for filename, text in texts.items():
    names = sql_names(regex_pattern, text) + sql_names(format_pattern, text)
    for name in names:
        owner = expected_owner(name)
        if filename != owner:
            fail(f"{name} belongs in {owner}, not {filename}")

required_markers = {
    "02.Language-Subtitles.sql": ["Language: Prefer English + Spanish", "Subtitles: Prefer English + Spanish"],
    "03.Codecs.sql": ["Codec: HEVC-x265 Preferred", "Codec: AV1 Preferred"],
    "04.Video-HDR-Resolution.sql": ["Video: 10-bit SDR / Main 10 Fallback", "HDR: Dolby Vision + HDR Bonus"],
    "05.Audio.sql": ["Audio: 7.1 Bonus", "Audio: Lossless Track Bonus", "Audio: Atmos Bonus"],
    "06.Sources-Releases.sql": ["4K: UHD BluRay Preferred", "1080p: BluRay Preferred", "Release: Proper-Repack-Rerip"],
    "07.Editions.sql": ["Edition: IMAX", "Edition: Director''s Cut"],
    "10.Media-Management.sql": ["Alex_CT Media Server Radarr Quality Definitions", "Alex_CT Media Server Sonarr Quality Definitions"],
    "11.Delay-Profiles.sql": ["Alex_CT Media Server Usenet Preferred Delay"],
    "12.Optional-Size-Guards.sql": ["Size Bonus: 1080p 8 GiB+", "Size Bonus: 4K 32 GiB+", "Size Guard: 4K Episode Tiny Encode"],
}
for filename, markers in required_markers.items():
    for marker in markers:
        if marker not in texts.get(filename, ""):
            fail(f"{filename} is missing expected marker: {marker}")


def create_mock_schema(connection, sql):
    table_columns = {}
    insert_pattern = r"INSERT(?:\s+OR\s+(?:IGNORE|REPLACE))?\s+INTO\s+(\w+)\s*\(([^)]+)\)"
    for table, columns in re.findall(insert_pattern, sql, flags=re.I | re.S):
        table_columns.setdefault(table, [])
        for column in columns.split(","):
            column = column.strip()
            if column not in table_columns[table]:
                table_columns[table].append(column)

    for table, columns in table_columns.items():
        quoted = ", ".join(f'"{column}"' for column in columns)
        connection.execute(f'CREATE TABLE "{table}" ({quoted})')


connection = sqlite3.connect(":memory:")
try:
    create_mock_schema(connection, combined)
    connection.executescript(combined)
except sqlite3.Error as exc:
    fail(f"SQL execution failed against the generated structural schema: {exc}")

if not errors:
    db_profiles = {row[0] for row in connection.execute("SELECT name FROM quality_profiles")}
    if db_profiles != EXPECTED_PROFILES:
        fail(f"Executed SQL produced unexpected profiles: {sorted(db_profiles)}")

    for profile in EXPECTED_PROFILES:
        row = connection.execute(
            "SELECT minimum_custom_format_score, upgrade_until_score, upgrade_score_increment FROM quality_profiles WHERE name = ?",
            (profile,),
        ).fetchone()
        if row is None or int(row[0]) != 0 or int(row[1]) != 10000:
            fail(f"{profile} should use minimum score 0 and keeper score 10000")
        if row is None or int(row[2]) != EXPECTED_UPGRADE_SCORE_INCREMENT[profile]:
            fail(
                f"{profile} should use upgrade score increment "
                f"{EXPECTED_UPGRADE_SCORE_INCREMENT[profile]}"
            )

    for profile, expected_order in EXPECTED_QUALITY_ORDER.items():
        rows = list(
            connection.execute(
                "SELECT quality_name, position, enabled, upgrade_until "
                "FROM quality_profile_qualities WHERE quality_profile_name = ? ORDER BY position",
                (profile,),
            )
        )
        actual_order = [row[0] for row in rows]
        if actual_order != expected_order:
            fail(f"{profile} checked-quality order differs: expected={expected_order}, actual={actual_order}")
        if any(int(row[2]) != 1 for row in rows):
            fail(f"{profile} should enable every listed quality")
        cutoffs = [row[0] for row in rows if int(row[3]) == 1]
        if cutoffs != expected_order[:1]:
            fail(f"{profile} should upgrade through its first listed quality: {expected_order[0]}")

    def score_map(profile):
        return {
            row[0]: int(row[1])
            for row in connection.execute(
                "SELECT custom_format_name, score FROM quality_profile_custom_formats WHERE quality_profile_name = ?",
                (profile,),
            )
        }

    def without_size_bonus(scores):
        return {name: score for name, score in scores.items() if not name.startswith("Size Bonus:")}

    def additive_matrix(scores):
        return {
            name: score
            for name, score in scores.items()
            if not name.startswith("Size Bonus:") and name not in STRICT_BLOCKER_NAMES
        }

    movie_scores = score_map("Alex_C.T - Best 1080p Movies")
    movie_base_scores = additive_matrix(movie_scores)
    series_scores = score_map("Alex_C.T - Best 1080p Series")
    if additive_matrix(score_map("Alex_C.T - Best 4K Movies")) != movie_base_scores:
        fail("Alex_C.T - Best 4K Movies should inherit the canonical movie score matrix before size bonuses")
    if additive_matrix(score_map("Alex_C.T - Best 4K Series")) != additive_matrix(series_scores):
        fail("Alex_C.T - Best 4K Series should inherit the canonical series score matrix")

    for catalog, canonical in [
        ("Alex_C.T - Catalog 480p-1080p Movies", movie_base_scores),
        ("Alex_C.T - Catalog 480p-1080p Series", additive_matrix(series_scores)),
    ]:
        catalog_scores = score_map(catalog)
        if any(catalog_scores.get(name) != score for name, score in canonical.items()):
            fail(f"{catalog} does not preserve the canonical score matrix")

    for profile, scores in [
        ("Alex_C.T - Best 1080p Movies", movie_scores),
        ("Alex_C.T - Best 1080p Series", series_scores),
    ]:
        if "1080p: UHD BluRay Source Bonus" in scores:
            fail(f"{profile} should keep source scoring centralized without a stacking UHD-source bonus")
        if profile.endswith("Series") and scores.get("Audio: Atmos Bonus", 0) <= scores.get("Codec: HEVC-x265 Preferred", 0):
            fail(f"{profile} should value Atmos above a codec label")
        if scores.get("Audio: 7.1 Bonus", 0) <= scores.get("Audio: 6.1 Bonus", 0):
            fail(f"{profile} should prefer 7.1 over 6.1")
        if scores.get("Audio: 6.1 Bonus", 0) <= scores.get("Audio: 5.1 Surround Preferred", 0):
            fail(f"{profile} should prefer 6.1 over strong 5.1 credit")

    expected_movie_codec_scores = {
        "Codec: HEVC-x265 Preferred": 1400,
        "Codec: AV1 Preferred": 1300,
        "Codec: VVC-x266 Future": 800,
        "Codec: x264-H264 Fallback or Penalty": -800,
    }
    for name, score in expected_movie_codec_scores.items():
        if movie_scores.get(name) != score:
            fail(f"Alex_C.T - Best 1080p Movies should score {name} as {score}")

    for profile in EXPECTED_PROFILES:
        scores = score_map(profile)
        for name in REDUNDANT_SOURCE_SCORE_NAMES:
            if name in scores:
                fail(f"{profile} should not attach redundant strict source score: {name}")
        actual_negative_scores = {name: score for name, score in scores.items() if score < 0}
        if actual_negative_scores != EXPECTED_NEGATIVE_SCORES[profile]:
            fail(
                f"{profile} negative-score blockers differ: "
                f"expected={EXPECTED_NEGATIVE_SCORES[profile]}, actual={actual_negative_scores}"
            )

    expected_size_bonus_scores = {
        "Alex_C.T - Best 1080p Movies": {
            "Size Bonus: 1080p 8 GiB+": 100,
            "Size Bonus: 1080p 12 GiB+": 100,
            "Size Bonus: 1080p 18 GiB+": 100,
        },
        "Alex_C.T - Best 4K Movies": {
            "Size Bonus: 4K 14 GiB+": 100,
            "Size Bonus: 4K 22 GiB+": 100,
            "Size Bonus: 4K 32 GiB+": 100,
        },
    }
    for profile in EXPECTED_PROFILES:
        actual = {
            name: score for name, score in score_map(profile).items() if name.startswith("Size Bonus:")
        }
        expected = expected_size_bonus_scores.get(profile, {})
        if actual != expected:
            fail(f"{profile} size bonuses differ: expected={expected}, actual={actual}")

    expected_size_thresholds = {
        "Size Bonus: 1080p 8 GiB+": (8589934592, 1099511627776),
        "Size Bonus: 1080p 12 GiB+": (12884901888, 1099511627776),
        "Size Bonus: 1080p 18 GiB+": (19327352832, 1099511627776),
        "Size Bonus: 4K 14 GiB+": (15032385536, 1099511627776),
        "Size Bonus: 4K 22 GiB+": (23622320128, 1099511627776),
        "Size Bonus: 4K 32 GiB+": (34359738368, 1099511627776),
    }
    actual_size_thresholds = {
        row[0]: (int(row[1]), row[2])
        for row in connection.execute(
            "SELECT custom_format_name, min_bytes, max_bytes FROM condition_sizes "
            "WHERE custom_format_name LIKE 'Size Bonus:%'"
        )
    }
    if actual_size_thresholds != expected_size_thresholds:
        fail(
            f"Movie size-bonus thresholds differ: expected={expected_size_thresholds}, "
            f"actual={actual_size_thresholds}"
        )

    expected_size_guard_thresholds = {
        "Size Guard: 1080p Episode Tiny Encode": (0, 314572800),
        "Size Guard: 4K Episode Tiny Encode": (0, 838860800),
    }
    actual_size_guard_thresholds = {
        row[0]: (int(row[1]), int(row[2]))
        for row in connection.execute(
            "SELECT custom_format_name, min_bytes, max_bytes FROM condition_sizes "
            "WHERE custom_format_name LIKE 'Size Guard:%'"
        )
    }
    if actual_size_guard_thresholds != expected_size_guard_thresholds:
        fail(
            f"Episode size-guard thresholds differ: expected={expected_size_guard_thresholds}, "
            f"actual={actual_size_guard_thresholds}"
        )

    non_universal_size_conditions = list(
        connection.execute(
            "SELECT custom_format_name, name, arr_type FROM custom_format_conditions "
            "WHERE custom_format_name LIKE 'Size Bonus:%' AND arr_type != 'all'"
        )
    )
    if non_universal_size_conditions:
        fail(f"Movie size bonus conditions should use arr_type=all for more reliable sync: {non_universal_size_conditions}")

    non_universal_size_bindings = list(
        connection.execute(
            "SELECT quality_profile_name, custom_format_name, arr_type FROM quality_profile_custom_formats "
            "WHERE custom_format_name LIKE 'Size Bonus:%' AND arr_type != 'all'"
        )
    )
    if non_universal_size_bindings:
        fail(f"Movie size bonus bindings should use arr_type=all for more reliable sync: {non_universal_size_bindings}")

    blocker_conditions = list(
        connection.execute(
            "SELECT name, negate, required FROM custom_format_conditions "
            "WHERE custom_format_name = 'Language: Block Other Languages' ORDER BY name"
        )
    )
    expected_blocker_conditions = [
        ("Language: No English Marker", 1, 1),
        ("Language: No Multi Marker", 1, 1),
        ("Language: No Spanish Marker", 1, 1),
        ("Language: Other-Language Audio/Sub Marker", 0, 1),
    ]
    if blocker_conditions != expected_blocker_conditions:
        fail(
            "Language: Block Other Languages should use the four-condition deploy-safe structure: "
            f"expected={expected_blocker_conditions}, actual={blocker_conditions}"
        )

    remux_members = list(
        connection.execute(
            "SELECT quality_profile_name, quality_name FROM quality_profile_qualities WHERE quality_name LIKE 'Remux-%'"
        )
    )
    if remux_members:
        fail(f"Managed profiles must not enable Remux qualities: {remux_members}")

    remux_formats = [
        row[0] for row in connection.execute("SELECT name FROM custom_formats WHERE name LIKE '%Remux%'")
    ]
    if remux_formats:
        fail(f"The clean rebuild should not define Remux custom formats: {remux_formats}")

    attached_size_helpers = list(
        connection.execute(
            "SELECT quality_profile_name, custom_format_name FROM quality_profile_custom_formats "
            "WHERE custom_format_name LIKE 'Size Guard:%'"
        )
    )
    if attached_size_helpers:
        fail(f"Optional size helpers must remain unattached: {attached_size_helpers}")

    formats_without_conditions = list(
        connection.execute(
            "SELECT name FROM custom_formats WHERE name NOT IN "
            "(SELECT DISTINCT custom_format_name FROM custom_format_conditions)"
        )
    )
    if formats_without_conditions:
        fail(f"Custom formats without conditions: {formats_without_conditions}")

    release_conditions_without_patterns = list(
        connection.execute(
            "SELECT custom_format_name, name FROM custom_format_conditions c "
            "WHERE type = 'release_title' AND NOT EXISTS ("
            "SELECT 1 FROM condition_patterns p WHERE p.custom_format_name = c.custom_format_name "
            "AND p.condition_name = c.name)"
        )
    )
    if release_conditions_without_patterns:
        fail(f"Release-title conditions without regex bindings: {release_conditions_without_patterns}")

    size_conditions_without_bounds = list(
        connection.execute(
            "SELECT custom_format_name, name FROM custom_format_conditions c "
            "WHERE type = 'size' AND NOT EXISTS ("
            "SELECT 1 FROM condition_sizes s WHERE s.custom_format_name = c.custom_format_name "
            "AND s.condition_name = c.name)"
        )
    )
    if size_conditions_without_bounds:
        fail(f"Size conditions without byte bounds: {size_conditions_without_bounds}")

connection.close()

if errors:
    print("Validation failed:")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print("Centralized PCD checks passed (12 modules, 6 profiles).")

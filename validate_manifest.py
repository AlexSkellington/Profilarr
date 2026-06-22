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
    "Alex_C.T - Best Available Movies",
    "Alex_C.T - Best 1080p Movies",
    "Alex_C.T - Best 4K Movies",
    "Alex_C.T - Catalog 480p-1080p Movies",
}
SERIES_PROFILES = {
    "Alex_C.T - Best Available Series",
    "Alex_C.T - Best 1080p Series",
    "Alex_C.T - Best 4K Series",
    "Alex_C.T - Catalog 480p-1080p Series",
}
EXPECTED_PROFILES = MOVIE_PROFILES | SERIES_PROFILES

ALL_FEATURE_QUALITIES = {
    "Remux-2160p",
    "Bluray-2160p",
    "WEBDL-2160p",
    "Remux-1080p",
    "Bluray-1080p",
    "WEBDL-1080p",
}
FEATURE_1080P = {"Remux-1080p", "Bluray-1080p", "WEBDL-1080p"}
FEATURE_4K = {"Remux-2160p", "Bluray-2160p", "WEBDL-2160p"}

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

if data.get("version") != "2.0.0":
    fail("pcd.json version should be 2.0.0 for the centralized profile layout")
if sorted(data.get("arr_types", [])) != ["radarr", "sonarr"]:
    fail("pcd.json arr_types should be exactly ['radarr', 'sonarr']")
if data.get("profilarr", {}).get("minimum_version") != "2.0.0":
    fail("pcd.json profilarr.minimum_version should be 2.0.0")

texts = {path.name: path.read_text(encoding="utf-8-sig") for path in sql_files}
combined = "\n".join(texts.values())


def sql_names(pattern, text):
    return [match.replace("''", "'") for match in re.findall(pattern, text, flags=re.I | re.S)]


profile_pattern = (
    r"INSERT(?:\s+OR\s+REPLACE)?\s+INTO\s+quality_profiles\s*"
    r"\([^)]*\)\s*VALUES\s*\('((?:[^']|'')+)'"
)
defined_profiles = set(sql_names(profile_pattern, combined))
if defined_profiles != EXPECTED_PROFILES:
    fail(
        "Managed profile definitions differ from the expected eight: "
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
    if name.startswith(("Size Guard:", "Size Band:")):
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
    "04.Video-HDR-Resolution.sql": ["Video: 2160p Resolution Bonus", "HDR: Dolby Vision + HDR Bonus"],
    "05.Audio.sql": ["Audio: 7.1 Bonus", "Audio: Lossless Track Bonus", "Audio: Atmos Bonus"],
    "06.Sources-Releases.sql": ["Source: Remux Preferred", "Release: Proper-Repack-Rerip"],
    "07.Editions.sql": ["Edition: IMAX", "Edition: Director''s Cut"],
    "10.Media-Management.sql": ["Alex_CT Media Server Radarr Quality Definitions", "Alex_CT Media Server Sonarr Quality Definitions"],
    "11.Delay-Profiles.sql": ["Alex_CT Media Server Usenet Preferred Delay"],
    "12.Optional-Size-Guards.sql": ["Size Band: 1080p Compact Eligible", "Size Guard: 4K Episode Tiny Encode"],
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
            "SELECT minimum_custom_format_score, upgrade_until_score FROM quality_profiles WHERE name = ?",
            (profile,),
        ).fetchone()
        if row is None or int(row[0]) != 0 or int(row[1]) != 10000:
            fail(f"{profile} should use minimum score 0 and keeper score 10000")

    expected_groups = {
        ("Alex_C.T - Best Available Movies", "Feature-Rich 1080p-2160p"): ALL_FEATURE_QUALITIES,
        ("Alex_C.T - Best 1080p Movies", "Feature-Rich 1080p"): FEATURE_1080P,
        ("Alex_C.T - Best 4K Movies", "Feature-Rich 4K"): FEATURE_4K,
        ("Alex_C.T - Best Available Series", "Feature-Rich 1080p-2160p"): ALL_FEATURE_QUALITIES,
        ("Alex_C.T - Best 1080p Series", "Feature-Rich 1080p"): FEATURE_1080P,
        ("Alex_C.T - Best 4K Series", "Feature-Rich 4K"): FEATURE_4K,
    }
    for (profile, group), expected in expected_groups.items():
        actual = {
            row[0]
            for row in connection.execute(
                "SELECT quality_name FROM quality_group_members WHERE quality_profile_name = ? AND quality_group_name = ?",
                (profile, group),
            )
        }
        if actual != expected:
            fail(f"{profile} group members differ: expected={sorted(expected)}, actual={sorted(actual)}")

    def score_map(profile):
        return {
            row[0]: int(row[1])
            for row in connection.execute(
                "SELECT custom_format_name, score FROM quality_profile_custom_formats WHERE quality_profile_name = ?",
                (profile,),
            )
        }

    movie_scores = score_map("Alex_C.T - Best Available Movies")
    series_scores = score_map("Alex_C.T - Best Available Series")
    for sibling in ["Alex_C.T - Best 1080p Movies", "Alex_C.T - Best 4K Movies"]:
        if score_map(sibling) != movie_scores:
            fail(f"{sibling} does not inherit the canonical movie score matrix")
    for sibling in ["Alex_C.T - Best 1080p Series", "Alex_C.T - Best 4K Series"]:
        if score_map(sibling) != series_scores:
            fail(f"{sibling} does not inherit the canonical series score matrix")

    for catalog, canonical in [
        ("Alex_C.T - Catalog 480p-1080p Movies", movie_scores),
        ("Alex_C.T - Catalog 480p-1080p Series", series_scores),
    ]:
        catalog_scores = score_map(catalog)
        if any(catalog_scores.get(name) != score for name, score in canonical.items()):
            fail(f"{catalog} does not preserve the canonical feature score matrix")

    for profile, scores in [
        ("Alex_C.T - Best Available Movies", movie_scores),
        ("Alex_C.T - Best Available Series", series_scores),
    ]:
        if scores.get("HDR: Dolby Vision + HDR Bonus", 0) <= scores.get("Video: 2160p Resolution Bonus", 0):
            fail(f"{profile} should value Dolby Vision with HDR above resolution alone")
        if scores.get("Audio: Atmos Bonus", 0) <= scores.get("Codec: HEVC-x265 Preferred", 0):
            fail(f"{profile} should value Atmos above a codec label")
        if scores.get("Audio: 7.1 Bonus", 0) <= scores.get("Audio: 5.1 Surround Preferred", 0):
            fail(f"{profile} should prefer 7.1 while retaining strong 5.1 credit")
        if scores.get("Source: Remux Preferred", 0) <= scores.get("Video: 2160p Resolution Bonus", 0):
            fail(f"{profile} should treat Remux as a stronger bitrate/source signal than resolution alone")

    negative_scores = list(
        connection.execute("SELECT quality_profile_name, custom_format_name, score FROM quality_profile_custom_formats WHERE score < 0")
    )
    if negative_scores:
        fail(f"Managed profiles should remain additive, found negative scores: {negative_scores}")

    attached_size_helpers = list(
        connection.execute(
            "SELECT quality_profile_name, custom_format_name FROM quality_profile_custom_formats "
            "WHERE custom_format_name LIKE 'Size Band:%' OR custom_format_name LIKE 'Size Guard:%'"
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

    resolution_pattern = connection.execute(
        "SELECT pattern FROM regular_expressions WHERE name = 'Video: 2160p Resolution Bonus'"
    ).fetchone()
    if resolution_pattern is None or "uhd" in resolution_pattern[0].lower():
        fail("The 2160p bonus must not treat UHD-source 1080p encodes as 4K")

connection.close()

if errors:
    print("Validation failed:")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print("Centralized feature-rich PCD checks passed (12 modules, 8 profiles).")

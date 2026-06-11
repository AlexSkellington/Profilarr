#!/usr/bin/env python3
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent

REQUIRED_FILES = [
    "pcd.json",
    "README.md",
    ".gitignore",
    "validate_manifest.py",
    "ops/01.Core-Tags-Languages-Qualities.sql",
    "ops/02.Regular-Expressions-Language-Subtitles.sql",
    "ops/03.Regular-Expressions-Codecs-HDR-Audio.sql",
    "ops/04.Regular-Expressions-Resolution-Source-Editions.sql",
    "ops/05.Custom-Formats.sql",
    "ops/06.Radarr-Movie-Profiles.sql",
    "ops/07.Sonarr-Series-Profiles.sql",
    "ops/08.Media-Management.sql",
    "ops/09.Delay-Profiles.sql",
    "ops/10.Micro-Encode-Guards.sql",
]

OLD_FILES = [
    "download",
    "ops/1.Smart-Managed-Library.sql",
    "ops/2.Smart-Plex-Media-Management.sql",
    "ops/3.Smart-Plex-Delay-Profile.sql",
    "ops/4.Smart-Plex-Micro-Encode-Guards.sql",
]

EXPECTED_PROFILES = [
    "Alex_C.T - 1080p Plex Movies",
    "Alex_C.T - 4K Plex Movies",
    "Alex_C.T - Catalog 480p-1080p Plex Movies",
    "Alex_C.T - 1080p-2160p Plex Series",
    "Alex_C.T - 4K Plex Series",
    "Alex_C.T - Catalog 480p-1080p Plex Series",
]

EXPECTED_MICRO_GUARDS = [
    "Size Guard: 1080p Movie Micro Encode",
    "Size Guard: 4K Movie Micro Encode",
    "Size Guard: 4K Movie Tiny Encode",
    "Size Guard: 1080p Episode Tiny Encode",
    "Size Guard: 4K Episode Tiny Encode",
]

errors = []

def fail(message):
    errors.append(message)

def read(path):
    return (ROOT / path).read_text(encoding="utf-8")

for rel in REQUIRED_FILES:
    if not (ROOT / rel).exists():
        fail(f"Missing required file: {rel}")

for rel in OLD_FILES:
    if (ROOT / rel).exists():
        fail(f"Old file should be removed after migration: {rel}")

try:
    data = json.loads(read("pcd.json"))
except Exception as exc:
    fail(f"pcd.json is not valid JSON: {exc}")
    data = {}

for key in ["name", "version", "description", "arr_types", "dependencies", "profilarr"]:
    if key not in data:
        fail(f"pcd.json missing required key: {key}")

if sorted(data.get("arr_types", [])) != ["radarr", "sonarr"]:
    fail("pcd.json arr_types should be exactly ['radarr', 'sonarr']")

if data.get("profilarr", {}).get("minimum_version") != "2.0.0":
    fail("pcd.json profilarr.minimum_version should be 2.0.0")

combined = ""
if (ROOT / "ops").exists():
    for path in sorted((ROOT / "ops").glob("*.sql")):
        combined += "\n" + path.read_text(encoding="utf-8")

for profile in EXPECTED_PROFILES:
    if profile not in combined:
        fail(f"Missing expected profile: {profile}")

for guard in EXPECTED_MICRO_GUARDS:
    if guard not in combined:
        fail(f"Missing expected micro-encode guard: {guard}")

required_markers = [
    "Language: Prefer English + Spanish",
    "Codec: HEVC-x265 Preferred",
    "HDR: Dolby Vision + HDR Bonus",
    "Audio: 5.1 Surround Preferred",
    "4K Gate: Block Missing HDR",
    "Alex_CT Smart Plex Radarr Quality Definitions",
    "Alex_CT Smart Plex Sonarr Quality Definitions",
    "Alex_CT Smart Plex Usenet Preferred Delay",
]
for marker in required_markers:
    if marker not in combined:
        fail(f"Missing expected marker: {marker}")

checks = {
    "1080p movie cutoff is Bluray-1080p": r"Alex_C\.T - 1080p Plex Movies'.*?'Bluray-1080p'.*?upgrade_until\) VALUES .*?, 1\)",
    "4K movie cutoff is Bluray-2160p": r"Alex_C\.T - 4K Plex Movies'.*?'Bluray-2160p'.*?upgrade_until\) VALUES .*?, 1\)",
    "1080p series cutoff is Bluray-1080p": r"Alex_C\.T - 1080p-2160p Plex Series'.*?'Bluray-1080p'.*?upgrade_until\) VALUES .*?, 1\)",
    "4K series cutoff is Bluray-2160p": r"Alex_C\.T - 4K Plex Series'.*?'Bluray-2160p'.*?upgrade_until\) VALUES .*?, 1\)",
}
for label, pattern in checks.items():
    if not re.search(pattern, combined, flags=re.S):
        fail(f"Could not verify: {label}")

if "condition_sizes" not in read("ops/10.Micro-Encode-Guards.sql"):
    fail("Micro-encode guard file should use condition_sizes")

if errors:
    print("Validation failed:")
    for err in errors:
        print(f" - {err}")
    sys.exit(1)

print("Modular Smart Plex PCD checks passed.")

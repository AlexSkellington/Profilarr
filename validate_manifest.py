#!/usr/bin/env python3
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent

REQUIRED_MANIFEST_KEYS = [
    "name",
    "version",
    "description",
    "arr_types",
    "dependencies",
    "profilarr",
]

REQUIRED_FILES = [
    "pcd.json",
    "README.md",
    ".gitignore",
    "validate_manifest.py",
    "ops/1.Smart-Managed-Library.sql",
    "ops/2.Smart-Plex-Media-Management.sql",
    "ops/3.Smart-Plex-Delay-Profile.sql",
    "ops/4.Smart-Plex-Micro-Encode-Guards.sql",
]

EXPECTED_PROFILES = [
    "Alex_C.T - 1080p-2160p Plex Movies",
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


def fail(message: str) -> None:
    errors.append(message)


def read_text(path: str) -> str:
    return (ROOT / path).read_text(encoding="utf-8")


# Manifest
manifest_path = ROOT / "pcd.json"
if not manifest_path.exists():
    fail("Missing pcd.json")
else:
    try:
        data = json.loads(manifest_path.read_text(encoding="utf-8"))
    except Exception as exc:
        fail(f"pcd.json is not valid JSON: {exc}")
        data = {}

    for key in REQUIRED_MANIFEST_KEYS:
        if key not in data:
            fail(f"pcd.json missing required key: {key}")

    arr_types = data.get("arr_types", [])
    if sorted(arr_types) != ["radarr", "sonarr"]:
        fail("pcd.json arr_types should be exactly ['radarr', 'sonarr']")

    if data.get("profilarr", {}).get("minimum_version") != "2.0.0":
        fail("pcd.json profilarr.minimum_version should be 2.0.0")

# Required files
for rel in REQUIRED_FILES:
    if not (ROOT / rel).exists():
        fail(f"Missing required file: {rel}")

# Accidental old ignore file
if (ROOT / "download").exists():
    fail("Remove or rename the accidental 'download' file to .gitignore")

# README should use real case-sensitive filenames
if (ROOT / "README.md").exists():
    readme = read_text("README.md")
    for rel in REQUIRED_FILES:
        if rel.startswith("ops/") and rel not in readme:
            fail(f"README.md does not mention required ops file: {rel}")

# SQL sanity checks
ops1 = ROOT / "ops/1.Smart-Managed-Library.sql"
if ops1.exists():
    text = ops1.read_text(encoding="utf-8")
    for profile in EXPECTED_PROFILES:
        if profile not in text:
            fail(f"ops/1 missing expected profile: {profile}")

    checks = {
        "1080p movie cutoff is Bluray-1080p": r"Alex_C\.T - 1080p-2160p Plex Movies'.*?'Bluray-1080p'.*?upgrade_until\) VALUES .*?, 1\)",
        "4K movie cutoff is Bluray-2160p": r"Alex_C\.T - 4K Plex Movies'.*?'Bluray-2160p'.*?upgrade_until\) VALUES .*?, 1\)",
        "1080p series cutoff is Bluray-1080p": r"Alex_C\.T - 1080p-2160p Plex Series'.*?'Bluray-1080p'.*?upgrade_until\) VALUES .*?, 1\)",
        "4K series cutoff is Bluray-2160p": r"Alex_C\.T - 4K Plex Series'.*?'Bluray-2160p'.*?upgrade_until\) VALUES .*?, 1\)",
    }
    for label, pattern in checks.items():
        if not re.search(pattern, text, flags=re.S):
            fail(f"Could not verify: {label}")

ops2 = ROOT / "ops/2.Smart-Plex-Media-Management.sql"
if ops2.exists():
    text = ops2.read_text(encoding="utf-8")
    for marker in [
        "Alex_CT Smart Plex Radarr Quality Definitions",
        "Alex_CT Smart Plex Sonarr Quality Definitions",
        "Bluray-1080p",
        "Bluray-2160p",
    ]:
        if marker not in text:
            fail(f"ops/2 missing expected quality-definition marker: {marker}")

ops4 = ROOT / "ops/4.Smart-Plex-Micro-Encode-Guards.sql"
if ops4.exists():
    text = ops4.read_text(encoding="utf-8")
    for guard in EXPECTED_MICRO_GUARDS:
        if guard not in text:
            fail(f"ops/4 missing expected micro-encode guard: {guard}")
    if "condition_sizes" not in text:
        fail("ops/4 should use condition_sizes for size-based guards")

if errors:
    print("Validation failed:")
    for err in errors:
        print(f" - {err}")
    sys.exit(1)

print("PCD manifest and Smart Plex repo checks passed.")

#!/usr/bin/env python3
import json
from pathlib import Path

root = Path(__file__).resolve().parent
manifest = root / "pcd.json"

with manifest.open("r", encoding="utf-8") as f:
    data = json.load(f)

required = ["name", "version", "description", "arr_types", "dependencies", "profilarr"]
missing = [k for k in required if k not in data]
if missing:
    raise SystemExit(f"Missing required keys: {', '.join(missing)}")

if not isinstance(data["arr_types"], list) or not data["arr_types"]:
    raise SystemExit("arr_types must be a non-empty list")

if "https://github.com/Dictionarry-Hub/schema" not in data["dependencies"]:
    raise SystemExit("Missing Profilarr schema dependency")

print("OK: pcd.json looks valid.")

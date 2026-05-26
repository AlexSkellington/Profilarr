# Alejandro Smart Plex Profilarr PCD

A personal Profilarr-compliant database for Radarr and Sonarr, built for Alejandro's Smart Plex managed library setup.

This database is **not an empty starter shell**. It contains Alejandro's curated quality profiles, custom formats, tags, language rules, source preferences, codec scoring, audio rules, HDR/4K rules, blocking rules, and Plex-focused scoring logic.

The included operations are generated for Profilarr v2 and are intended to be managed from Profilarr as the source-of-truth, then synced into Radarr and Sonarr.

## What this database includes

- Curated Radarr quality profiles
- Curated Sonarr quality profiles
- Custom formats for movies and series
- English and Spanish language preference logic
- Subtitle/language helper formats
- Codec scoring, including efficient encode preferences
- HDR/4K preference and blocking logic
- Audio scoring and surround-sound gates
- Source scoring for BluRay, WEB-DL, WEBRip, BDRip, Remux, and related tiers
- Catalog-friendly lower-resolution profiles
- Strict Plex-oriented upgrade/scoring behavior

## Files

```text
pcd.json      # Database manifest
ops/          # Profilarr PCD operation SQL files
tweaks/       # Optional local SQL tweaks/variants
```

Main operation file:

```text
ops/1.smart-plex-managed-library.sql
```

This file contains the Smart Plex managed library profiles, custom formats, tags, and scoring rules.

## How to use

1. Create or open your GitHub repository, for example:
   `alejandro-smart-plex-profilarr-pcd`

2. Upload these files to that repository.

3. In Profilarr, go to **Databases** and link this GitHub repository.

4. After it links successfully, select this database under:
   - **Custom Formats**
   - **Quality Profiles**
   - **Regular Expressions / Tags / Related configuration areas**

5. Review the profiles and formats, then sync them to the correct Radarr/Sonarr instances.

## Recommended workflow

Use this database as your personal source-of-truth.

Make future changes inside Profilarr whenever possible, then publish/export the resulting operations back into this database so your curated setup remains reproducible.

Avoid manually editing the same managed profiles directly in Radarr/Sonarr unless you intentionally want those changes outside Profilarr management. If Radarr/Sonarr is edited directly, Profilarr may not know about those changes and a future sync can overwrite them.

## Notes for your setup

This database is designed around your Smart Plex logic, including strict BluRay-target behavior, strong Plex compatibility, English/Spanish preference handling, HDR/4K rules, surround-audio gates, and profile separation between movie, series, 4K, 1080p/2160p, and catalog-style use cases.

Unlike the original blank starter README, this repo is no longer described as having no profiles or formats. It now represents your curated Smart Plex managed library database.

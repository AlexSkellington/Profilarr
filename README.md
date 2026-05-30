# Alejandro Smart Plex Profilarr PCD

A personal Profilarr-compliant database for Radarr and Sonarr, built for Alejandro's Smart Plex managed library setup.

This database contains Alejandro's curated quality profiles, custom formats, regular expressions, tags, scoring logic, and media-management settings. It is intended to be managed in Profilarr as the source-of-truth and then synced into Radarr and Sonarr.

## What this database includes

- Curated Radarr quality profiles
- Curated Sonarr quality profiles
- Custom formats and regular expressions
- English and Spanish language preference logic
- Codec, source, audio, HDR/4K, edition, and blocking rules
- Micro-encode size guards
- Plex-focused naming settings
- Radarr and Sonarr media settings
- Radarr and Sonarr quality definitions
- Usenet-first delay profile

## Files

```text
pcd.json
ops/1.Smart-Managed-Library.sql              # Profiles, custom formats, scoring, tags, regex rules
ops/2.Smart-Plex-Media-Management.sql        # Naming settings, media settings, quality definitions
ops/3.Smart-Plex-Delay-Profile.sql           # Usenet-first delay profile
ops/4.Smart-Plex-Micro-Encode-Guards.sql     # Extra size-based micro-encode penalties
tweaks/                                       # Optional local SQL tweaks/variants
validate_manifest.py                         # Lightweight repo/manifest sanity checks
```

> GitHub paths are case-sensitive. Keep the filenames above exactly as written.

## How to use

1. Upload or commit these files to your GitHub PCD repository.
2. In Profilarr, go to **Databases** and update/relink the `Alex_C.T` database.
3. Rebuild/update the database from GitHub if Profilarr does not refresh automatically.
4. Check:
   - **Media Management → Naming Settings**
   - **Media Management → Media Settings**
   - **Media Management → Quality Definitions**
   - **Delay Profiles**
5. Sync the desired media-management configs, delay profile, and quality profiles to the correct Radarr/Sonarr instances.

## Recommended workflow

Use this database as your personal source-of-truth. Make future changes inside Profilarr when possible, then publish/export the resulting operations back into this repo so the setup stays reproducible.

Avoid manually editing the same managed profiles or media-management configs directly in Radarr/Sonarr unless you intentionally want those changes outside Profilarr management.

## Included media-management settings

`ops/2.Smart-Plex-Media-Management.sql` adds the Media Management section in Profilarr:

- Radarr Naming Settings using Alejandro's current movie format and TMDb folder format
- Sonarr Naming Settings using Alejandro's current standard, daily, anime, season folder, Smart Replace, and Prefixed Range settings
- Radarr Media Settings
- Sonarr Media Settings
- Radarr Quality Definitions matching the current Radarr MiB/min values
- Sonarr Quality Definitions reconstructed from the current Sonarr MiB/h and GiB/h display

Note: the pasted Sonarr settings did not include a separate Series Folder Format value. The required Profilarr field is set to `{Series TitleYear}` in the SQL file.

## Micro-encode guards

`ops/4.Smart-Plex-Micro-Encode-Guards.sql` adds extra custom formats that penalize suspiciously tiny 1080p and 4K releases.

These are intentionally separate from the main generated SQL so they can be tuned without touching the generated profile export. They are a second safety layer on top of the Radarr/Sonarr quality definitions.

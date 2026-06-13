# Alejandro Smart Plex Profilarr PCD

A personal modular Profilarr-compliant database for Radarr and Sonarr, built for Alejandro's Smart Plex managed library setup.

This database contains categorized custom formats, fully additive individual-bonus scoring for movies and series, media-management settings, quality definitions, a delay profile, and optional series-only size helpers.

## Import order

The files in `ops/` are numbered because dependency order matters:

```text
ops/01.Core-Tags-Languages-Qualities.sql
ops/02.Regular-Expressions-Language-Subtitles.sql
ops/03.Regular-Expressions-Codecs-HDR-Audio.sql
ops/04.Regular-Expressions-Resolution-Source-Editions.sql
ops/05.Custom-Formats-Language-Subtitles.sql
ops/06.Custom-Formats-Codec-HDR-Audio-Resolution.sql
ops/07.Custom-Formats-Source-Editions-Releases.sql
ops/08.Radarr-Movie-Profiles.sql
ops/09.Sonarr-Series-Profiles.sql
ops/10.Media-Management.sql
ops/11.Delay-Profiles.sql
ops/12.Series-Size-Guards.sql
```

GitHub paths are case-sensitive. Keep these filenames exactly as written.

## What each file does

- `01.Core-Tags-Languages-Qualities.sql`: base tags, languages, and quality names.
- `02.Regular-Expressions-Language-Subtitles.sql`: EN/ES/Latino language logic and subtitle rules.
- `03.Regular-Expressions-Codecs-HDR-Audio.sql`: HEVC/AV1/VVC/x264, HDR/DV, and audio rules.
- `04.Regular-Expressions-Resolution-Source-Editions.sql`: resolution-specific source rules, 4K gates, editions, and release fixes.
- `05.Custom-Formats-Language-Subtitles.sql`: language and subtitle custom formats, tags, conditions, and regex bindings.
- `06.Custom-Formats-Codec-HDR-Audio-Resolution.sql`: codec, HDR, audio, and resolution/source custom formats.
- `07.Custom-Formats-Source-Editions-Releases.sql`: source, edition, and release-fix custom formats.
- `08.Radarr-Movie-Profiles.sql`: Radarr movie profiles with fully additive scoring.
- `09.Sonarr-Series-Profiles.sql`: Sonarr series profiles with fully additive scoring.
- `10.Media-Management.sql`: Radarr/Sonarr naming, media settings, and quality definitions.
- `11.Delay-Profiles.sql`: Usenet-first delay profile.
- `12.Series-Size-Guards.sql`: optional series-only size helper formats for suspiciously tiny TV releases.

## Migration from the old layouts

Delete or move these old files from `ops/` so the repo stays clean:

```text
ops/1.Smart-Managed-Library.sql
ops/2.Smart-Plex-Media-Management.sql
ops/3.Smart-Plex-Delay-Profile.sql
ops/4.Smart-Plex-Micro-Encode-Guards.sql
ops/05.Custom-Formats.sql
ops/06.Radarr-Movie-Profiles.sql
ops/07.Sonarr-Series-Profiles.sql
ops/08.Media-Management.sql
ops/09.Delay-Profiles.sql
ops/10.Micro-Encode-Guards.sql
```

Then add the new numbered files.

## Recommended Profilarr workflow

Since this is a full modular restructure:

1. Unlink/remove the old `Alex_C.T` database in Profilarr.
2. Push this modular repo layout to GitHub.
3. Link the repo again in Profilarr.
4. Rebuild/update the database from GitHub.
5. Sync the desired profiles/settings to Radarr and Sonarr.

## Notes

Movie and series profiles are fully additive. Releases only gain points for features they actually have.

Compound combo formats such as "resolution + codec" or "HDR + surround" are no longer part of the default scoring path. Source, codec, Main 10, HDR tiers, audio tiers, release fixes, and editions are all rewarded individually so the ladders stay easier to reason about and maintain.

Movie profile weights are intentionally stretched so stacked feature-rich releases can land much closer to the 9000 to 10000 range on individual bonuses alone, without bringing back compound combo formats. This makes the visible movie score far more useful as a quick at-a-glance source-quality signal inside Profilarr.

MediaInfo is enabled for import-time metadata and for the rename templates, but the current PCD schema only exposes custom-format condition types such as `release_title`, `size`, `source`, `resolution`, and similar parsed fields. Codec, HDR, audio, and edition custom formats therefore still depend on release naming rather than true MediaInfo-backed custom-format matching at this layer today.

The default profiles no longer attach remux/raw-disk blockers, x264 penalties, HDR/4K hard gates, size penalties, or compound combo bonuses. Encoded BluRay and strong WEB-DL releases win through quality order plus positive source, codec, HDR, audio, language, subtitle, and edition bonuses, which keeps space use lower than a remux-first strategy.

Strict blocking custom formats still exist in the categorized custom-format files for optional use if you want harsher profiles again later.

The series size helpers use total release size, not true bitrate. Quality Definitions remain the main MB/min guardrail layer, and the helper formats are left unattached by default.

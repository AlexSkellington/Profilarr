# Alejandro Media Server Profilarr PCD

A personal modular Profilarr-compliant database for Radarr and Sonarr, built for Alejandro's shared media-server library setup.

This database contains categorized custom formats, additive individual-feature scoring for movies and series, media-management settings, quality definitions, a delay profile, optional series size guards, and movie size-band helpers for Compact, Premium, and Remux lanes.

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
ops/13.Movie-Size-Bands.sql
```

GitHub paths are case-sensitive. Keep these filenames exactly as written.

## What each file does

- `01.Core-Tags-Languages-Qualities.sql`: base tags, languages, and quality names.
- `02.Regular-Expressions-Language-Subtitles.sql`: EN/ES/Latino language logic and subtitle rules.
- `03.Regular-Expressions-Codecs-HDR-Audio.sql`: HEVC/AV1/VVC/x264, HDR/DV, and audio rules, including lossless-audio detection.
- `04.Regular-Expressions-Resolution-Source-Editions.sql`: resolution-specific source rules, 4K gates, editions, and release fixes.
- `05.Custom-Formats-Language-Subtitles.sql`: language and subtitle custom formats, tags, conditions, and regex bindings.
- `06.Custom-Formats-Codec-HDR-Audio-Resolution.sql`: codec, HDR, audio, lossless-audio, and resolution/source custom formats.
- `07.Custom-Formats-Source-Editions-Releases.sql`: source, edition, and release-fix custom formats.
- `08.Radarr-Movie-Profiles.sql`: Radarr movie profiles for Compact, Premium, Remux, and Catalog lanes.
- `09.Sonarr-Series-Profiles.sql`: Sonarr series profiles with additive scoring.
- `10.Media-Management.sql`: Radarr/Sonarr naming, media settings, and quality definitions.
- `11.Delay-Profiles.sql`: Usenet-first delay profile.
- `12.Series-Size-Guards.sql`: optional series-only size helper formats for suspiciously tiny TV releases.
- `13.Movie-Size-Bands.sql`: required movie size-band helpers used by the Compact, Premium, and Remux movie profiles.

## Movie profile set

- `Compact 1080p Movies` and `Compact 4K Movies`: closest to the current behavior. These stay size-aware, keep fully additive feature scoring, and aim for strong everyday encodes.
- `Premium 1080p Movies` and `Premium 4K Movies`: higher-bitrate encode lanes tuned to ride closer to remux territory while still favoring encoded releases.
- `Remux 1080p Movies` and `Remux 4K Movies`: soft remux-first lanes. They prefer remux qualities first, but still allow premium encodes as fallback.
- `Catalog 480p-1080p Movies`: relaxed additive lane for older or harder-to-find titles.

The movie profiles do not have true per-profile bitrate controls because Profilarr quality definitions are global per Arr type. The approximation is:

- Radarr quality definitions provide the main MiB-per-minute rails.
- Movie size-band custom formats provide per-profile total-size eligibility gates.
- Additive custom-format scoring still decides which eligible release is best.

That means size bands are total-size proxies, not runtime-normalized bitrate math. They are still useful for keeping each profile inside the space/quality lane you actually want.

## Series profile set

- `1080p-2160p Series`: 1080p-first series lane with compact 2160p fallback.
- `4K Series`: manual 4K lane for select shows.
- `Catalog 480p-1080p Series`: relaxed archive/catalog lane.

Series remain additive and keep the optional tiny-episode size guards unattached by default.

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

Compound combo formats such as "resolution + codec" or "HDR + surround" are not part of the default scoring path. Source, codec, Main 10, HDR tiers, audio tiers, lossless audio, release fixes, and editions are all rewarded individually so the ladders stay easier to reason about and maintain.

Movie profile weights are intentionally stretched so stacked feature-rich releases can land much closer to the visible top of each lane without bringing back compound combo formats. This makes the score far more useful as a quick at-a-glance quality signal inside Profilarr.

MediaInfo is enabled for import-time metadata and for the rename templates, but the current PCD schema still exposes custom-format condition types such as `release_title`, `size`, `source`, and `resolution`. Codec, HDR, audio, and edition custom formats therefore still depend on release naming rather than true MediaInfo-backed custom-format matching at this layer today.

Strict blocking custom formats still exist in the categorized custom-format files for optional use if you want harsher profiles again later.

# Alejandro Feature-Rich Profilarr PCD

A centralized Profilarr database for Radarr and Sonarr. It favors technically
rich releases with strong HDR/Dolby Vision, surround or lossless audio, trusted
sources, and high runtime-aware quality targets without forcing resolution to
win every comparison.

## Import order

The 12 files in `ops/` are ordered because later modules reference definitions
from earlier modules:

```text
ops/01.Core-Tags-Languages-Qualities.sql
ops/02.Language-Subtitles.sql
ops/03.Codecs.sql
ops/04.Video-HDR-Resolution.sql
ops/05.Audio.sql
ops/06.Sources-Releases.sql
ops/07.Editions.sql
ops/08.Radarr-Movie-Profiles.sql
ops/09.Sonarr-Series-Profiles.sql
ops/10.Media-Management.sql
ops/11.Delay-Profiles.sql
ops/12.Optional-Size-Guards.sql
```

GitHub paths are case-sensitive. Keep these filenames exactly as written.

## Module ownership

Each editable concern owns both its regular expressions and custom formats so
tuning does not require chasing definitions across multiple files.

- `01`: shared tags, languages, and canonical quality names.
- `02`: English/Spanish language and subtitle matching.
- `03`: HEVC, AV1, VVC, and x264 codec matching.
- `04`: 10-bit video, HDR10/HDR10+, Dolby Vision, and resolution preference.
- `05`: audio codecs, 5.1/6.1/7.1, Atmos, and lossless audio.
- `06`: Remux, BluRay, WEB-DL, weaker source detectors, and release fixes.
- `07`: IMAX, cuts, restorations, labels, and other movie editions.
- `08`: the four Radarr movie profiles and their shared score matrix.
- `09`: the four Sonarr series profiles and their shared score matrix.
- `10`: naming, media settings, and runtime-aware quality definitions.
- `11`: the shared Usenet-first delay profile.
- `12`: optional movie size bands and series tiny-release helpers.

## Movie profiles

- `Alex_C.T - Best Available Movies`: default. Compares Remux, BluRay, and
  WEB-DL across 1080p and 2160p in one quality group.
- `Alex_C.T - Best 1080p Movies`: the same feature scoring, constrained to
  1080p Remux, BluRay, and WEB-DL.
- `Alex_C.T - Best 4K Movies`: the same feature scoring, constrained to 2160p
  Remux, BluRay, and WEB-DL.
- `Alex_C.T - Catalog 480p-1080p Movies`: relaxed DVD-through-1080p ladder for
  old or scarce titles.

## Series profiles

- `Alex_C.T - Best Available Series`: default cross-resolution feature group.
- `Alex_C.T - Best 1080p Series`: strict 1080p feature group.
- `Alex_C.T - Best 4K Series`: strict 2160p feature group.
- `Alex_C.T - Catalog 480p-1080p Series`: relaxed archive/catalog ladder.

## Selection philosophy

Radarr and Sonarr normally compare quality position before custom-format score.
The three primary profiles therefore place their comparable qualities inside a
single quality group. This lets feature scoring choose between a rich 1080p
release and a weak 4K release instead of granting 4K an automatic win.

Scoring priorities are:

1. Dolby Vision with HDR fallback, HDR10+, and HDR10.
2. Atmos, lossless audio, 7.1, 6.1, and strong 5.1 audio.
3. Remux, UHD BluRay, BluRay, and clean WEB-DL source signals.
4. A modest 2160p preference so similarly featured 4K wins.
5. Language, subtitles, codecs, release fixes, and movie editions as refiners.

The primary profiles use a minimum custom-format score of `0`. A usable release
can download first and continue upgrading toward a feature-rich keeper score of
`10000`. Codec labels receive modest scores because HEVC or AV1 alone does not
prove that an encode is good.

## Bitrate and size

Quality definitions in `10.Media-Management.sql` are the main runtime-aware
MiB-per-minute controls. Their preferred sizes also provide Radarr's final size
tie-breaker after quality-group and custom-format comparisons.

The total-size helpers in `12.Optional-Size-Guards.sql` are intentionally not
attached to any managed profile. They remain available for manual experiments,
but fixed file-size bands distort short and long movies and should not decide
the default profile.

## Metadata limitation

Custom-format matching currently uses release names. MediaInfo is enabled for
imports and naming, but release-time codec, HDR, and audio decisions still rely
on advertised title markers. Runtime-aware quality definitions and source tags
are therefore strong proxies, not proof of the final stream bitrate.

## Migration from 1.x

Version 2.0 replaces the Compact/Premium/Remux profile grid and reorganizes the
custom-format modules. Remove these superseded files from `ops/`:

```text
ops/02.Regular-Expressions-Language-Subtitles.sql
ops/03.Regular-Expressions-Codecs-HDR-Audio.sql
ops/04.Regular-Expressions-Resolution-Source-Editions.sql
ops/05.Custom-Formats-Language-Subtitles.sql
ops/06.Custom-Formats-Codec-HDR-Audio-Resolution.sql
ops/07.Custom-Formats-Source-Editions-Releases.sql
ops/12.Series-Size-Guards.sql
```

For a clean Profilarr migration:

1. Push this complete layout to GitHub.
2. Unlink or remove the old `Alex_C.T` database in Profilarr.
3. Link the repository again and rebuild it from GitHub.
4. Sync the desired profiles and settings to Radarr and Sonarr.
5. Assign `Best Available` as the default and use the targeted or Catalog
   profiles only where the title needs that policy.

Run `validate_manifest.py` after every structural or profile change.

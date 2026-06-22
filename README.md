# Alejandro Profilarr PCD

A centralized Profilarr database for Radarr and Sonarr. It favors technically
rich encoded releases with strong HDR/Dolby Vision, surround or lossless audio,
trusted sources, and high runtime-aware quality targets.

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
- `04`: 10-bit video, HDR10/HDR10+, Dolby Vision, and video safeguards.
- `05`: audio codecs, 5.1/6.1/7.1, Atmos, and lossless audio.
- `06`: BluRay, WEB-DL, weaker source detectors, and release fixes.
- `07`: IMAX, cuts, restorations, labels, and other movie editions.
- `08`: the three Radarr movie profiles and their shared score matrix.
- `09`: the three Sonarr series profiles and their shared score matrix.
- `10`: naming, media settings, and runtime-aware quality definitions.
- `11`: the shared Usenet-first delay profile.
- `12`: optional series tiny-release helpers.

## Movie profiles

- `Alex_C.T - Best 1080p Movies`: checks Bluray-1080p and WEBDL-1080p.
- `Alex_C.T - Best 4K Movies`: checks Bluray-2160p and WEBDL-2160p.
- `Alex_C.T - Catalog 480p-1080p Movies`: relaxed DVD-through-1080p ladder for
  old or scarce titles.

## Series profiles

- `Alex_C.T - Best 1080p Series`: checks Bluray-1080p and WEBDL-1080p.
- `Alex_C.T - Best 4K Series`: checks Bluray-2160p and WEBDL-2160p.
- `Alex_C.T - Catalog 480p-1080p Series`: relaxed archive/catalog ladder.

Only these six movie and series profiles are created. No compatibility aliases
or retired profile names are retained.

## Selection philosophy

Radarr and Sonarr compare quality position before custom-format score. Each
strict profile checks BluRay first and WEB-DL second using the default qualities,
without creating custom groups. Custom-format scores rank competing releases
inside each checked quality. Catalog checks its fallback qualities individually
in descending order because availability matters most there.

Scoring priorities are:

1. Dolby Vision with HDR fallback, HDR10+, and HDR10.
2. Atmos, lossless audio, 7.1, 6.1, and strong 5.1 audio.
3. UHD BluRay, BluRay, and clean WEB-DL source signals.
4. Language, subtitles, codecs, release fixes, and movie editions as refiners.

The primary profiles use a minimum custom-format score of `0`. A usable release
can download first and continue upgrading toward a keeper score of
`10000`. Codec labels receive modest scores because HEVC or AV1 alone does not
prove that an encode is good.

## Bitrate and size

Quality definitions in `10.Media-Management.sql` are the main runtime-aware
MiB-per-minute controls. Their preferred sizes also provide Radarr's final size
tie-breaker after quality-group and custom-format comparisons.

The tiny-episode helpers in `12.Optional-Size-Guards.sql` are intentionally not
attached to any managed profile. Runtime-aware definitions remain the source of
truth for normal file sizing.

## Metadata limitation

Custom-format matching currently uses release names. MediaInfo is enabled for
imports and naming, but release-time codec, HDR, and audio decisions still rely
on advertised title markers. Runtime-aware quality definitions and source tags
are therefore strong proxies, not proof of the final stream bitrate.

## Clean rebuild

Version 4.0 is a clean rebuild and should not be layered over an existing
Profilarr database with stale mappings:

1. Push this complete layout to GitHub.
2. Unlink or remove the old `Alex_C.T` database (including database `12`) in Profilarr.
3. Link the repository again and rebuild it from GitHub.
4. Sync the desired profiles and settings to Radarr and Sonarr.
5. Assign `Best 1080p` as the default and select `Best 4K` or Catalog only where
   that policy is intentional.

Run `validate_manifest.py` after every structural or profile change.

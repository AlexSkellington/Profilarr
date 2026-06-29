# Alejandro Profilarr PCD

A centralized Profilarr database for Radarr and Sonarr. It favors technically
rich encoded releases with strong HDR/Dolby Vision, surround or lossless audio,
trusted sources, and high runtime-aware quality targets, while strict profiles
hard-block obvious bad fits before the first grab.

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
- `12`: cumulative movie size bonuses and optional series tiny-release helpers.

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
without creating custom groups. A short list of negative custom-format blockers
rejects clearly bad strict-profile matches before additive scoring matters.
Accepted releases are then ranked by positive score inside each checked
quality. Catalog stays permissive and checks its fallback qualities
individually in descending order because availability matters most there.

Scoring priorities are:

1. Strict-profile hard blockers for language-only wrong-language tags, hardcoded subtitles,
   and weak 4K metadata.
2. Dolby Vision with HDR fallback, HDR10+, and HDR10.
3. Atmos, lossless audio, 7.1, 6.1, and strong 5.1 audio.
4. Language, subtitles, codecs, release fixes, and movie editions as refiners.
5. Catalog-only lower-resolution source refiners and modest movie size bonuses
   break close archival ties.

The primary profiles use a minimum custom-format score of `0`. A usable release
can download first only if it clears the strict blockers, then continue
upgrading toward a keeper score of `10000`. Upgrade score increments are set to
`1`, so any higher accepted score counts as a real improvement. Codec labels
receive modest scores because HEVC or AV1 alone does not prove that an encode
is good. Source order in the strict profiles comes from the quality ladder
itself rather than extra BluRay-vs-WEB-DL score stacking.

## Bitrate and size

Quality definitions in `10.Media-Management.sql` are the main runtime-aware
MiB-per-minute controls. Their preferred sizes also provide Radarr's final size
tie-breaker after quality and custom-format comparisons.

File `12.Optional-Size-Guards.sql` adds cumulative movie bonuses as a
total-size proxy for bitrate. Best 1080p Movies gains `+100` at 8, 12, and 18
GiB; Best 4K Movies gains `+100` at 14, 22, and 32 GiB. The maximum is `+300`,
so size breaks close comparisons without overpowering major A/V scores. These
tiers cannot account for runtime, so longer movies may receive more credit than
their true bitrate warrants. The size specs are defined with universal Arr
conditions for more reliable deployment, and they now use explicit upper bounds
instead of open-ended null maxima because Radarr's size specification is a
bounded range. Tiny-episode helpers also use an explicit zero lower bound so
their payload matches the same Arr size-spec rules, while remaining unattached.

The strict `Language: Block Other Languages` helper is also intentionally built
from one explicit foreign-language marker plus negated English, Spanish, and
multi-audio checks instead of one giant regex. That keeps mixed-language
releases allowed while making the custom format easier for Arr and Profilarr to
sync consistently.

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

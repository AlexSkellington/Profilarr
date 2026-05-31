# Alex_C.T Profilarr - Integrated HEVC Main 10 / 10-bit SDR fallback updater
# Run from the root of the Profilarr repo:
#   powershell -ExecutionPolicy Bypass -File .\Apply-Main10-Integrated-Update.ps1
#
# This edits existing files only. It does NOT create ops/11.

$ErrorActionPreference = 'Stop'

function Read-FileText {
    param([Parameter(Mandatory=$true)][string]$Path)
    return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Write-FileText {
    param(
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$true)][string]$Text
    )
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Text, $utf8NoBom)
}

function Require-File {
    param([Parameter(Mandatory=$true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Required file not found: $Path. Run this script from the root of the Profilarr repo."
    }
}

function Insert-After {
    param(
        [Parameter(Mandatory=$true)][string]$File,
        [Parameter(Mandatory=$true)][string]$Anchor,
        [Parameter(Mandatory=$true)][string]$Insert,
        [Parameter(Mandatory=$true)][string]$Marker
    )

    $text = Read-FileText -Path $File

    if ($text.Contains($Marker)) {
        Write-Host "Already present: $Marker in $File"
        return
    }

    if (-not $text.Contains($Anchor)) {
        throw "Anchor not found in $File:`n$Anchor"
    }

    $text = $text.Replace($Anchor, $Anchor + "`r`n" + $Insert)
    Write-FileText -Path $File -Text $text
    Write-Host "Updated: $File"
}

function Replace-Exact {
    param(
        [Parameter(Mandatory=$true)][string]$File,
        [Parameter(Mandatory=$true)][string]$Old,
        [Parameter(Mandatory=$true)][string]$New,
        [Parameter(Mandatory=$true)][string]$Marker
    )

    $text = Read-FileText -Path $File

    if ($text.Contains($Marker)) {
        Write-Host "Already updated: $File"
        return
    }

    if (-not $text.Contains($Old)) {
        throw "Original line not found in $File. It may have changed already or the file does not match the expected version."
    }

    $text = $text.Replace($Old, $New)
    Write-FileText -Path $File -Text $text
    Write-Host "Updated: $File"
}

$repoRoot = (Get-Location).Path
$ops = Join-Path $repoRoot 'ops'

$f03 = Join-Path $ops '03.Regular-Expressions-Codecs-HDR-Audio.sql'
$f04 = Join-Path $ops '04.Regular-Expressions-Resolution-Source-Editions.sql'
$f05 = Join-Path $ops '05.Custom-Formats.sql'
$f06 = Join-Path $ops '06.Radarr-Movie-Profiles.sql'
$f07 = Join-Path $ops '07.Sonarr-Series-Profiles.sql'

@($f03, $f04, $f05, $f06, $f07) | ForEach-Object { Require-File -Path $_ }

# Backup once per run
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupDir = Join-Path $repoRoot ("backup-main10-" + $stamp)
New-Item -ItemType Directory -Path $backupDir | Out-Null
Copy-Item -LiteralPath $f03 -Destination (Join-Path $backupDir (Split-Path $f03 -Leaf))
Copy-Item -LiteralPath $f04 -Destination (Join-Path $backupDir (Split-Path $f04 -Leaf))
Copy-Item -LiteralPath $f05 -Destination (Join-Path $backupDir (Split-Path $f05 -Leaf))
Copy-Item -LiteralPath $f06 -Destination (Join-Path $backupDir (Split-Path $f06 -Leaf))
Copy-Item -LiteralPath $f07 -Destination (Join-Path $backupDir (Split-Path $f07 -Leaf))
Write-Host "Backup created: $backupDir"

# 03 - Add regex + tags after HEVC/x265 scoring tag.
$anchor03 = "INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Codec: HEVC-x265 Preferred', 'Scoring');"
$insert03 = @"
INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('Video: 10-bit SDR / Main 10 Fallback', '(?i)^(?=.*\b(?:x265|h[ ._-]?265|hevc|av1|x266|h[ ._-]?266|vvc)\b)(?=.*\b(?:10[ ._-]?bit|10b|main[ ._-]?10|yuv420p10le)\b)(?!.*(?:\bhdr\b|\bhdr10\b|\bhdr10plus\b|\bhdr10\+|\bdovi\b|\bdv\b|dolby[ ._-]?vision)).*$', 'Fallback visual-quality bonus for efficient-codec releases that explicitly advertise 10-bit/Main 10 but do not advertise HDR, HDR10, HDR10+, DoVi, DV, or Dolby Vision. This lets 10-bit SDR sit above plain 8-bit HEVC/x265 while staying below true HDR/Dolby Vision.');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Codec');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'HDR / 4K');
INSERT OR REPLACE INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Scoring');
"@
Insert-After -File $f03 -Anchor $anchor03 -Insert $insert03 -Marker "Video: 10-bit SDR / Main 10 Fallback"

# 03 - Update SDR penalty to not penalize explicit Main 10 / 10-bit SDR.
$oldPenalty03 = "INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('HDR: Penalize SDR When HDR Expected', '(?i)^(?=.*\b(?:1080p|2160p|4k|uhd)\b)(?=.*\b(?:x265|h[ ._-]?265|hevc|av1|x266|h[ ._-]?266|vvc)\b)(?!.*(?:\bhdr\b|\bhdr10\b|\bhdr10plus\b|\bhdr10\+|\bdovi\b|\bdv\b|dolby[ ._-]?vision)).*$', 'Visual-protection penalty for efficient-codec 1080p/2160p releases that do not advertise HDR, HDR10, HDR10+, DoVi, DV, or Dolby Vision. Movies use this strongly to stop SDR replacing HDR; Sonarr uses a lighter version because HDR is less common on shows.');"
$newPenalty03 = "INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('HDR: Penalize SDR When HDR Expected', '(?i)^(?=.*\b(?:1080p|2160p|4k|uhd)\b)(?=.*\b(?:x265|h[ ._-]?265|hevc|av1|x266|h[ ._-]?266|vvc)\b)(?!.*(?:\bhdr\b|\bhdr10\b|\bhdr10plus\b|\bhdr10\+|\bdovi\b|\bdv\b|dolby[ ._-]?vision|\b(?:10[ ._-]?bit|10b|main[ ._-]?10|yuv420p10le)\b)).*$', 'Visual-protection penalty for efficient-codec 1080p/2160p releases that advertise neither HDR/Dolby Vision nor explicit 10-bit/Main 10. Explicit 10-bit SDR is handled by the Video: 10-bit SDR / Main 10 Fallback custom format.');"
Replace-Exact -File $f03 -Old $oldPenalty03 -New $newPenalty03 -Marker "explicit 10-bit/Main 10"

# 04 - Update 4K Missing HDR gate to allow explicit Main 10 / 10-bit fallback.
$oldGate04 = "INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('4K Gate: Block Missing HDR', '(?i)^(?=.*\b(?:2160p|4k)\b)(?!.*(?:\bhdr\b|\bhdr10\b|\bhdr10plus\b|\bhdr10\+|\bdovi\b|\bdv\b|dolby[ ._-]?vision)).*$', 'Managed Smart Plex custom format. Matches release-title tokens and applies the profile score assigned in each curated quality profile.');"
$newGate04 = "INSERT OR REPLACE INTO regular_expressions (name, pattern, description) VALUES ('4K Gate: Block Missing HDR', '(?i)^(?=.*\b(?:2160p|4k)\b)(?!.*(?:\bhdr\b|\bhdr10\b|\bhdr10plus\b|\bhdr10\+|\bdovi\b|\bdv\b|dolby[ ._-]?vision|\b(?:10[ ._-]?bit|10b|main[ ._-]?10|yuv420p10le)\b)).*$', 'Blocks or heavily penalizes 2160p/4K releases that advertise neither HDR/Dolby Vision nor explicit 10-bit/Main 10. This preserves HDR-first behavior while allowing 10-bit SDR as a controlled fallback.');"
Replace-Exact -File $f04 -Old $oldGate04 -New $newGate04 -Marker "10-bit/Main 10. This preserves HDR-first"

# 05 - Add custom format after HEVC/x265 custom format binding.
$anchor05 = "INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Codec: HEVC-x265 Preferred', 'Codec: HEVC-x265 Preferred', 'Codec: HEVC-x265 Preferred');"
$insert05 = @"
INSERT OR REPLACE INTO custom_formats (name, description, include_in_rename) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Soft fallback score for explicit 10-bit SDR / HEVC Main 10 style releases when HDR/Dolby Vision is not advertised. This helps profiles prefer 10-bit by itself after true HDR/DV options, without allowing weak sources to beat the BluRay target ladder.', 0);
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Codec');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'HDR / 4K');
INSERT OR REPLACE INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Scoring');
INSERT OR REPLACE INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback', 'release_title', 'all', 0, 1);
INSERT OR REPLACE INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback', 'Video: 10-bit SDR / Main 10 Fallback');
"@
Insert-After -File $f05 -Anchor $anchor05 -Insert $insert05 -Marker "Video: 10-bit SDR / Main 10 Fallback"

# 06 - Add Radarr scores.
$radarrScores = @(
    @{ File=$f06; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 650);"; Marker="Alex_C.T - 1080p-2160p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback" },
    @{ File=$f06; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 650);"; Marker="Alex_C.T - 4K Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback" },
    @{ File=$f06; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 450);"; Marker="Alex_C.T - Catalog 480p-1080p Plex Movies', 'Video: 10-bit SDR / Main 10 Fallback" }
)

foreach ($item in $radarrScores) {
    Insert-After -File $item.File -Anchor $item.Anchor -Insert $item.Insert -Marker $item.Marker
}

# 07 - Add Sonarr scores.
$sonarrScores = @(
    @{ File=$f07; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 1080p-2160p Plex Series', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 650);"; Marker="Alex_C.T - 1080p-2160p Plex Series', 'Video: 10-bit SDR / Main 10 Fallback" },
    @{ File=$f07; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Series', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - 4K Plex Series', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 650);"; Marker="Alex_C.T - 4K Plex Series', 'Video: 10-bit SDR / Main 10 Fallback" },
    @{ File=$f07; Anchor="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Series', 'Codec: HEVC-x265 Preferred', 'all', 3500);"; Insert="INSERT OR REPLACE INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('Alex_C.T - Catalog 480p-1080p Plex Series', 'Video: 10-bit SDR / Main 10 Fallback', 'all', 450);"; Marker="Alex_C.T - Catalog 480p-1080p Plex Series', 'Video: 10-bit SDR / Main 10 Fallback" }
)

foreach ($item in $sonarrScores) {
    Insert-After -File $item.File -Anchor $item.Anchor -Insert $item.Insert -Marker $item.Marker
}

Write-Host ""
Write-Host "Validation:"
Select-String -Path (Join-Path $ops '*.sql') -Pattern "Video: 10-bit SDR / Main 10 Fallback","yuv420p10le" | ForEach-Object {
    Write-Host ("  " + $_.Path.Replace($repoRoot + '\','') + ":" + $_.LineNumber + " " + $_.Line.Trim())
}

Write-Host ""
Write-Host "Done. Review with:"
Write-Host "  git diff -- ops/03.Regular-Expressions-Codecs-HDR-Audio.sql ops/04.Regular-Expressions-Resolution-Source-Editions.sql ops/05.Custom-Formats.sql ops/06.Radarr-Movie-Profiles.sql ops/07.Sonarr-Series-Profiles.sql"
Write-Host ""
Write-Host "Then commit/push:"
Write-Host "  git add ops/03.Regular-Expressions-Codecs-HDR-Audio.sql ops/04.Regular-Expressions-Resolution-Source-Editions.sql ops/05.Custom-Formats.sql ops/06.Radarr-Movie-Profiles.sql ops/07.Sonarr-Series-Profiles.sql"
Write-Host "  git commit -m `"Add Main 10 SDR fallback scoring`""
Write-Host "  git push"

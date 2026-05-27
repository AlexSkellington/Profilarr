-- Alex_C.T Smart Plex delay-profile Profilarr v2 PCD operations.
-- Adds a conservative Usenet-first delay profile for Radarr/Sonarr sync.
-- Upload this as ops/3.smart-plex-delay-profile.sql after ops/1 and ops/2.

-- Profilarr's delay_profiles entity is shared and can be synced to Radarr/Sonarr instances.
-- This profile prefers Usenet immediately and gives torrents a 60-minute delay as fallback.
-- It bypasses the delay when the release is already the highest accepted quality.
-- Custom-format score bypass is disabled to avoid surprise grabs until you tune it intentionally.

INSERT OR REPLACE INTO delay_profiles (
  name,
  preferred_protocol,
  usenet_delay,
  torrent_delay,
  bypass_if_highest_quality,
  bypass_if_above_custom_format_score,
  minimum_custom_format_score
) VALUES (
  'Alex_CT Smart Plex Usenet Preferred Delay',
  'prefer_usenet',
  0,
  60,
  1,
  0,
  NULL
);

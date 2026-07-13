#!/usr/bin/env bash
set -euo pipefail

# JST 9:00 に発火するよう workflow を UTC 0:00 で起動しているため、
# UTC の曜日・週番号がそのまま JST の曜日・週番号と一致する
WEEKDAY=$(date -u +%u)   # 1=月曜 ... 7=日曜
WEEK=$(date -u +%V)      # ISO週番号（01-53）
VARIANT=$(( (10#$WEEK - 1) % 4 ))

MESSAGE=$(jq -r --arg wd "$WEEKDAY" --argjson idx "$VARIANT" '.[$wd][$idx]' content.json)

curl -sf -H "Content-Type: application/json" \
  -d "$(jq -n --arg content "$MESSAGE" '{content: $content}')" \
  "$DISCORD_WEBHOOK_URL"

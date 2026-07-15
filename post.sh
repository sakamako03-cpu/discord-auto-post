#!/usr/bin/env bash
set -euo pipefail

START_DATE="2026-07-20"
TODAY=$(date -u +%Y-%m-%d)
if [[ "$TODAY" < "$START_DATE" ]]; then
  echo "配信開始日（$START_DATE）より前のため、投稿をスキップします。"
  exit 0
fi

WEEKDAY=$(date -u +%u)   # 1=月曜 ... 7=日曜
WEEK=$(date -u +%V)      # ISO週番号（01-53）
VARIANT=$(( (10#$WEEK - 1) % 4 ))

MESSAGE=$(jq -r --arg wd "$WEEKDAY" --argjson idx "$VARIANT" '.[$wd][$idx]' content.json)

curl -sf -H "Content-Type: application/json" \
  -d "$(jq -n --arg content "$MESSAGE" '{content: $content}')" \
  "$DISCORD_WEBHOOK_URL"

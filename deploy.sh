#!/usr/bin/env bash
set -euo pipefail

: "${VIBE_KEY:?Set VIBE_KEY env var}"
: "${SOURCE_URL:?Set SOURCE_URL to public tar.gz of repo}"

SERVER_ID="1bca73f7-c34d-4e7f-92a1-7f9aa893d67d"
BASE="https://vibecode.bitrix24.tech/v1"

curl -sS -X POST "$BASE/infra/servers/$SERVER_ID/deploy?stream=false" \
  -H "X-Api-Key: $VIBE_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"source\":{\"url\":\"$SOURCE_URL\"}}" | jq '.'

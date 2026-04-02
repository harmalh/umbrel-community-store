#!/usr/bin/env bash
# Umbrel sources this when resolving docker-compose. Keep in sync with umbrel-app.yml "port:".
_E_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_PNUM="$(grep -E '^[[:space:]]*port:' "${_E_ROOT}/umbrel-app.yml" | head -1 | tr -cd '0-9')"
export APP_PAPERCLIP_PUBLISHED_PORT="${_PNUM:-23100}"

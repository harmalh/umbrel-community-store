#!/usr/bin/env bash
# Umbrel sources this when resolving docker-compose. Keep in sync with umbrel-app.yml "port:".
_E_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_PNUM="$(grep -E '^[[:space:]]*port:' "${_E_ROOT}/umbrel-app.yml" | head -1 | tr -cd '0-9')"
export APP_PAPERCLIP_PUBLISHED_PORT="${_PNUM:-23100}"

# Paperclip authenticated+private rejects unknown Host headers (403). Add LAN IPv4 so
# http://192.168.x.x:PORT works; see paperclip doc/DOCKER.md PAPERCLIP_ALLOWED_HOSTNAMES.
_LAN_IP=""
if command -v ip >/dev/null 2>&1; then
    _LAN_IP="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<NF;i++)if($i=="src"){print $(i+1);exit}}')"
fi
if [[ -z "${_LAN_IP}" ]]; then
    _LAN_IP="$(hostname -I 2>/dev/null | awk '{ print $1 }')"
fi
export APP_PAPERCLIP_LAN_IP="${_LAN_IP}"

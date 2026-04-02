# shellcheck shell=bash
# Sourced by Paperclip hooks. Host-published port must match umbrel-app.yml "port:".
_pc_hook_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_paperclip_pkg_root="$(cd "${_pc_hook_dir}/.." && pwd)"

paperclip_published_host_port() {
    local mf p
    mf="${_paperclip_pkg_root}/umbrel-app.yml"
    if [[ -f "${mf}" ]]; then
        p="$(grep -E '^[[:space:]]*port:' "${mf}" | head -1 | tr -cd '0-9')"
        if [[ -n "${p}" ]]; then
            echo "${p}"
            return
        fi
    fi
    echo "23100"
}

# Primary IPv4 for Host header when users open http://<LAN-IP>:port (Paperclip private mode).
paperclip_lan_ipv4() {
    local lan
    if command -v ip >/dev/null 2>&1; then
        lan="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<NF;i++)if($i=="src"){print $(i+1);exit}}')"
    fi
    if [[ -z "${lan}" ]]; then
        lan="$(hostname -I 2>/dev/null | awk '{ print $1 }')"
    fi
    echo "${lan}"
}

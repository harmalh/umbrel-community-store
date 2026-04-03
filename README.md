# Harm Alhusen Lab - Umbrel Community App Store

Canonical install surface for Harm's packaged Umbrel apps.

Add this repository in umbrelOS under:

`App Store -> Community app stores`

Store URL:

`https://github.com/harmalh/umbrel-community-store`

## Store Identity

| Field | Value |
|-------|-------|
| Store id | `harmalh` |
| Apps | `harmalh-paperclip`, `harmalh-paperclip-hermes`, `harmalh-hermes-agent`, `harmalh-hermes-workspace`, `harmalh-opencode`, `harmalh-worldmonitor` |
| Published ports | `harmalh-paperclip` -> `23100`, `harmalh-paperclip-hermes` -> `23140`, `harmalh-hermes-agent` -> `23110`, `harmalh-hermes-workspace` -> `23130`, `harmalh-opencode` -> `23120`, `harmalh-worldmonitor` -> `23150` |

Per Umbrel community store rules, each app folder name must match its
`umbrel-app.yml` `id`, and each `id` must start with the store id.

## Install Prerequisites

- `harmalh-hermes-agent`: `ghcr.io/harmalh/hermes-agent-umbrel` must be public or otherwise anonymously pullable by the Umbrel host.
- `harmalh-hermes-workspace`: `ghcr.io/harmalh/hermes-workspace-ui-umbrel` and `ghcr.io/harmalh/hermes-workspace-api-umbrel` must be public or otherwise anonymously pullable by the Umbrel host.
- `harmalh-paperclip`: `ghcr.io/harmalh/paperclip-umbrel` must be public or otherwise anonymously pullable by the Umbrel host.
- `harmalh-paperclip-hermes`: `ghcr.io/harmalh/paperclip-hermes-umbrel` must be public or otherwise anonymously pullable by the Umbrel host.
- `harmalh-opencode`: the app publishes on `23120` instead of `80` to avoid host port collisions.
- `harmalh-worldmonitor`: `ghcr.io/harmalh/worldmonitor-umbrel`, `worldmonitor-umbrel-ais-relay`, and `worldmonitor-umbrel-redis-rest` must be public or otherwise anonymously pullable by the Umbrel host.

## Packaging Source Repos

| App folder | Packaging + CI + image builds |
|------------|-------------------------------|
| `harmalh-paperclip/` | [harmalh/umbrel-paperclip](https://github.com/harmalh/umbrel-paperclip) |
| `harmalh-paperclip-hermes/` | [harmalh/umbrel-paperclip-hermes](https://github.com/harmalh/umbrel-paperclip-hermes) |
| `harmalh-hermes-agent/` | [harmalh/umbrel-hermes-agent](https://github.com/harmalh/umbrel-hermes-agent) |
| `harmalh-hermes-workspace/` | [harmalh/umbrel-hermes-workspace](https://github.com/harmalh/umbrel-hermes-workspace) |
| `harmalh-opencode/` | [harmalh/umbrel-opencode](https://github.com/harmalh/umbrel-opencode) |
| `harmalh-worldmonitor/` | [harmalh/umbrel-worldmonitor](https://github.com/harmalh/umbrel-worldmonitor) |

Copy packaging from those repos into this store when you cut a release. See
`docs/RELEASE_CHECKLIST.md`.

## CI

`.github/workflows/ci.yml` validates `umbrel-app-store.yml`, every app manifest,
and YAML parsing of all `docker-compose.yml` files. Full `docker compose config`
is intentionally skipped because Umbrel injects `app_proxy`.

## Device Testing

Follow `docs/UMBREL_DEVICE_TESTING.md`. Record real-device outcomes in the table
below after testing.

## Tested On umbrelOS

| Date | Environment | umbrelOS version | Apps verified | Notes |
|------|-------------|------------------|---------------|-------|
| 2026-04-02 | Physical Umbrel on LAN (`umbrel.local`) | 1.5 | Store listing: Paperclip, Hermes Gateway, OpenCode; installed: `harmalh-paperclip` | Install from the community store completed; Paperclip appeared on the dashboard. Restart, reinstall, and persistence were not exercised in that pass. |
| 2026-04-03 | Workstation packaging and CI | - | `harmalh-opencode` synced to v0.2.1 and `harmalh-worldmonitor` synced to digest-pinned GHCR images | Native Umbrel installs were not re-run in that pass. Refresh the community store on-device and follow the device-testing checklist before relying on those builds. |

## Official Umbrel App Store

Official submissions still go through `getumbrel/umbrel-apps`. See
`docs/OFFICIAL_SUBMISSION.md`.

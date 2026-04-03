# Harm Alhusen Lab — Umbrel Community App Store

Canonical **install surface** for native Umbrel testing of Harm’s packaged apps.
Add this repository URL in **umbrelOS → App Store → Community app stores**.

**Store URL to paste in Umbrel:** `https://github.com/harmalh/umbrel-community-store`

## Store identity

| Field | Value |
|-------|--------|
| Store `id` | `harmalh` (prefix for every app `id` and folder name) |
| Apps | `harmalh-paperclip`, `harmalh-hermes-agent`, `harmalh-opencode`, `harmalh-worldmonitor` |
| Published ports | `harmalh-paperclip` → `23100`, `harmalh-hermes-agent` → `23110`, `harmalh-opencode` → `23120`, `harmalh-worldmonitor` → `23150` |

Per [Umbrel’s community store template](https://github.com/getumbrel/umbrel-community-app-store), each app folder name **must** match its `umbrel-app.yml` `id`, and that id **must** start with the store id.

## Install prerequisites

- `harmalh-hermes-agent`: `ghcr.io/harmalh/hermes-agent-umbrel` must be public or otherwise anonymously pullable by the Umbrel host.
- `harmalh-opencode`: the app proxy now publishes on `23120` instead of `80` to avoid host port collisions.
- `harmalh-worldmonitor`: `ghcr.io/harmalh/worldmonitor-umbrel`, `worldmonitor-umbrel-ais-relay`, and `worldmonitor-umbrel-redis-rest` must all be public or otherwise anonymously pullable by the Umbrel host.

## Packaging source repos

| App folder | Packaging + CI + image builds |
|------------|-------------------------------|
| `harmalh-paperclip/` | [harmalh/umbrel-paperclip](https://github.com/harmalh/umbrel-paperclip) |
| `harmalh-hermes-agent/` | [harmalh/umbrel-hermes-agent](https://github.com/harmalh/umbrel-hermes-agent) |
| `harmalh-opencode/` | [harmalh/umbrel-opencode](https://github.com/harmalh/umbrel-opencode) |
| `harmalh-worldmonitor/` | [harmalh/umbrel-worldmonitor](https://github.com/harmalh/umbrel-worldmonitor) |

Copy packaging from those repos into this store when you cut a release (see [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md)). Longer term, automate sync to avoid drift.

## CI

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) validates `umbrel-app-store.yml`, every `*/umbrel-app.yml`, and YAML-parse of all `docker-compose.yml` files. Full `docker compose config` is skipped because `app_proxy` is injected by Umbrel.

## Device testing

Follow [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md). Record results in **Tested on umbrelOS** below.

## Tested on umbrelOS

Fill this **right after** you complete device testing (see [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md)). Include **hardware / environment** (e.g. Raspberry Pi, Umbrel Home, Linux VM) for traceability and future official submissions.

| Date | Environment (hardware / VM) | umbrelOS version | Apps verified | Notes |
|------|----------------------------|------------------|---------------|-------|
| 2026-04-02 | Physical Umbrel on LAN (`umbrel.local`) | 1.5 | Store listing: Paperclip, Hermes Agent, OpenCode; **installed:** `harmalh-paperclip` | Install from **Harm Alhusen Lab** completed; Paperclip appears on dashboard; CPU/memory rose on launch. Restart / stop-start / uninstall-reinstall / persistence not exercised in this pass. Cursor integrated browser opened `http://umbrel.local:3100/` in extra tabs with an error shell—use the normal Umbrel “open app” flow in a desktop browser to confirm the Paperclip UI. |
| 2026-04-03 | — (packaging / CI on workstation) | — | **`harmalh-opencode`:** compose + store sync to v0.2.1; published port `23120`; `ghcr.io/anomalyco/opencode:beta` pinned to a tested digest | Native Umbrel install not re-run in this pass. After you push to GitHub, refresh the community store on-device and follow [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md) section 5 (OpenCode checklist). |
| 2026-04-03 | — (GitHub Actions; digest-pinned images) | — | **`harmalh-worldmonitor`:** GHCR build succeeded (workflow 23928371735); compose uses `main@sha256` for web, ais-relay, redis-rest | Ensure each `ghcr.io/harmalh/worldmonitor-umbrel*` package is **Public** before device install. Complete section 6 in [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md) on hardware. |

## Official Umbrel App Store

Submission process: [docs/OFFICIAL_SUBMISSION.md](docs/OFFICIAL_SUBMISSION.md).

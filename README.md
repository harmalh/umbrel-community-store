# Harm Alhusen Lab — Umbrel Community App Store

Canonical **install surface** for native Umbrel testing of Harm’s packaged apps.
Add this repository URL in **umbrelOS → App Store → Community app stores**.

**Store URL to paste in Umbrel:** `https://github.com/harmalh/umbrel-community-store`

## Store identity

| Field | Value |
|-------|--------|
| Store `id` | `harmalh` (prefix for every app `id` and folder name) |
| Apps | `harmalh-paperclip`, `harmalh-hermes-agent`, `harmalh-opencode` |

Per [Umbrel’s community store template](https://github.com/getumbrel/umbrel-community-app-store), each app folder name **must** match its `umbrel-app.yml` `id`, and that id **must** start with the store id.

## Packaging source repos

| App folder | Packaging + CI + image builds |
|------------|-------------------------------|
| `harmalh-paperclip/` | [harmalh/umbrel-paperclip](https://github.com/harmalh/umbrel-paperclip) |
| `harmalh-hermes-agent/` | [harmalh/umbrel-hermes-agent](https://github.com/harmalh/umbrel-hermes-agent) |
| `harmalh-opencode/` | [harmalh/umbrel-opencode](https://github.com/harmalh/umbrel-opencode) |

Copy packaging from those repos into this store when you cut a release (see [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md)). Longer term, automate sync to avoid drift.

## CI

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) validates `umbrel-app-store.yml`, every `*/umbrel-app.yml`, and YAML-parse of all `docker-compose.yml` files. Full `docker compose config` is skipped because `app_proxy` is injected by Umbrel.

## Device testing

Follow [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md). Record results in **Tested on umbrelOS** below.

## Tested on umbrelOS

Fill this **right after** you complete device testing (see [docs/UMBREL_DEVICE_TESTING.md](docs/UMBREL_DEVICE_TESTING.md)). Include **hardware / environment** (e.g. Raspberry Pi, Umbrel Home, Linux VM) for traceability and future official submissions.

| Date | Environment (hardware / VM) | umbrelOS version | Apps verified | Notes |
|------|----------------------------|------------------|---------------|-------|
| _TBD_ | _e.g. Raspberry Pi 4 / Umbrel Home_ | _from Settings or About_ | _Paperclip + stubs_ | _persistence / reinstall findings_ |

## Official Umbrel App Store

Submission process: [docs/OFFICIAL_SUBMISSION.md](docs/OFFICIAL_SUBMISSION.md).

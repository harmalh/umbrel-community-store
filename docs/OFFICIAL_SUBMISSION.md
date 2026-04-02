# Preparing submission to the official Umbrel App Store

The reviewed catalog lives in **[getumbrel/umbrel-apps](https://github.com/getumbrel/umbrel-apps)**. Community stores are for **staging and testing**, not a substitute for that process.

## Before you open a PR

1. Prove the app on **real umbrelOS** (install from your community store or equivalent).
2. Pin images to **digests** where possible; follow upstream Umbrel conventions for `docker-compose.yml`.
3. Ensure `umbrel-app.yml` metadata is complete: description, icons, gallery, support links, release notes.
4. Read the current **contributing / submission** section of `getumbrel/umbrel-apps` README for branch naming and review expectations.

## What reviewers may change

Umbrel may adjust compose (ports, IPs), resolve conflicts, or refine manifests before merge. Treat your community store packaging as **evidence**, and expect iteration in the official PR.

## Links

- Official apps repo: https://github.com/getumbrel/umbrel-apps
- Community store template: https://github.com/getumbrel/umbrel-community-app-store

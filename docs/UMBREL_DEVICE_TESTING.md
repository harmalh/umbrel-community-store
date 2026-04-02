# Umbrel device testing checklist

Use this on your Umbrel (e.g. `http://umbrel.local`) after pushing the store to GitHub.

## Prerequisites

- Store repo is public (or your Umbrel can access the private Git URL if supported).
- GitHub Actions on `harmalh/umbrel-community-store` `main` are green.

## Add the community store

1. Open **App Store** in umbrelOS.
2. Find **Community app stores** (or equivalent) and choose **Add**.
3. Enter: `https://github.com/harmalh/umbrel-community-store`
4. Confirm **Harm Alhusen Lab** (or your store name) appears.

## Install and smoke-test each app

### Paperclip (`harmalh-paperclip`)

1. Install from the community store listing.
2. Open the app from the Umbrel dashboard.
3. Confirm UI loads, sign-in flow as expected.
4. Restart the app or device; confirm data persists under `APP_DATA_DIR`.

### Hermes Agent stub (`harmalh-hermes-agent`)

1. Install; open the app.
2. Expect a simple HTML stub page from nginx.

### OpenCode stub (`harmalh-opencode`)

1. Same as Hermes.

## After testing

Update the **Tested on umbrelOS** table in the repo [README.md](../README.md) with date, umbrelOS version, and short notes.

# Umbrel Device Testing

Use this checklist on your Umbrel after the store is on GitHub and Actions are
green.

Store URL:

`https://github.com/harmalh/umbrel-community-store`

## 1. Add The Community Store

1. Open the Umbrel App Store.
2. Open Community app stores.
3. Add `https://github.com/harmalh/umbrel-community-store`.
4. Confirm the store name is **Harm Alhusen Lab**.
5. Confirm these listings appear with sensible names, icons, and descriptions:
   - `harmalh-paperclip`
   - `harmalh-paperclip-hermes`
   - `harmalh-hermes-agent`
   - `harmalh-hermes-workspace`
   - `harmalh-opencode`
   - `harmalh-worldmonitor`

## 2. Core Install Checks

For every full app you care about, validate:

- install succeeds
- app opens from the Umbrel dashboard
- icon and listing look correct
- restart works
- uninstall and reinstall behave as expected

Focus first on:

- `harmalh-hermes-workspace`
- `harmalh-paperclip`
- `harmalh-paperclip-hermes`
- `harmalh-worldmonitor`

## 3. Hermes Gateway

Validate:

- `ghcr.io/harmalh/hermes-agent-umbrel` is public
- install succeeds
- the status/setup page opens
- `harmalh-hermes-agent_hermes_1` stays up
- data under `APP_DATA_DIR/data` survives restart

This app is intentionally a headless gateway/runtime, not the full Hermes UI.

## 4. Hermes Workspace

Validate:

- `ghcr.io/harmalh/hermes-workspace-ui-umbrel` and
  `ghcr.io/harmalh/hermes-workspace-api-umbrel` are public
- install succeeds
- the browser UI opens from Umbrel
- the UI can reach the backend at `hermes-api:8642`
- sessions, memory, skills, files, and terminal survive restart

## 5. Paperclip And Paperclip Hermes

For `harmalh-paperclip` and `harmalh-paperclip-hermes`, validate:

- install succeeds
- `/bootstrap-entry/` opens correctly
- the first-admin invite flow works
- `/api/health` becomes ready
- restart preserves Paperclip state

For `harmalh-paperclip-hermes` specifically, also validate:

- `ghcr.io/harmalh/paperclip-hermes-umbrel` is public
- Hermes CLI is present in the running container
- a `hermes_local` employee can be created in the Paperclip UI
- Hermes session continuity survives restarts

## 6. World Monitor And OpenCode

Validate:

- `harmalh-worldmonitor` brings up its expected multi-container stack
- the World Monitor UI loads correctly
- `harmalh-opencode` still installs and opens its current landing page

## 7. Record Results

After testing, update the `Tested On umbrelOS` table in the store `README.md`
with:

- date
- hardware or environment
- umbrelOS version
- apps verified
- notable issues or caveats

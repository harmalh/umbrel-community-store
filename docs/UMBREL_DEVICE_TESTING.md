# Umbrel device testing — recommended order

Use this on your Umbrel (e.g. `http://umbrel.local`) after the store is on GitHub and Actions are green.

The [community store template](https://github.com/getumbrel/umbrel-community-app-store) is consumed by **adding the store’s GitHub URL in the umbrelOS UI**—not by cloning on your PC.

**Store URL:** `https://github.com/harmalh/umbrel-community-store`

---

## 1. Add the community store in the Umbrel UI

1. Open **App Store** in umbrelOS.
2. Open **Community app stores** (wording may vary slightly by version) and choose **Add**.
3. Paste: `https://github.com/harmalh/umbrel-community-store`
4. Confirm the store appears (this repo’s store name: **Harm Alhusen Lab**).
5. Open the store listing and **verify every app** shows up with sensible **names, icons, and descriptions**:
   - `harmalh-paperclip` — Paperclip
   - `harmalh-hermes-agent` — Hermes Agent (gateway + status page; GHCR `ghcr.io/harmalh/hermes-agent-umbrel` digest-pinned — see [umbrel-hermes-agent README](https://github.com/harmalh/umbrel-hermes-agent))
   - `harmalh-opencode` — OpenCode (stub)
   - `harmalh-worldmonitor` — World Monitor (multi-container; GHCR images must be **public** or pullable — see [umbrel-worldmonitor README](https://github.com/harmalh/umbrel-worldmonitor))

If something is wrong in the listing, fix `umbrel-app.yml` (and assets URLs) in this repo, push, and refresh the store on Umbrel.

---

## 2. Full apps: Paperclip and World Monitor

**Paperclip** is a primary **full web UI** app. **World Monitor** is also a full multi-container app (web + AIS relay + Redis + redis-rest); ensure [harmalh/umbrel-worldmonitor](https://github.com/harmalh/umbrel-worldmonitor) Actions have pushed digest-pinned images and GHCR packages are **public** before installing.

**Hermes Agent** uses `ghcr.io/harmalh/hermes-agent-umbrel` (multi-arch, digest-pinned in compose; rebuild via [umbrel-hermes-agent Actions](https://github.com/harmalh/umbrel-hermes-agent/actions) when you bump upstream). OpenCode remains a minimal nginx stub until replaced.

**Goal for each full app is “good enough,” not perfection:**

- [ ] Install succeeds
- [ ] App opens from the Umbrel dashboard
- [ ] Store/dashboard **icon and listing** look correct
- [ ] **Uninstall** then **reinstall** works (expect data loss on uninstall unless you have a backup strategy)
- [ ] **Restart** the app (or host) works
- [ ] No obvious packaging failure (compose, proxy, env)

For **World Monitor** specifically, confirm **four** containers are up after install (`web`, `ais-relay`, `redis`, `redis-rest`) and the UI loads; if the UI is blank, check logs for Redis or relay errors.

Umbrel’s model assumes users use the **web UI**, not SSH—so a working UI path matters most here.

---

## 3. Test restart and persistence (repeat per full app)

Official packaging guidance stresses **volumes** and **what survives** stop/start vs uninstall.

After **Paperclip** is running:

- [ ] Create or change some **state you care about** (e.g. sign in, create a workspace, or any in-app setting).
- [ ] **Restart** the app from Umbrel; confirm expected state is still there.
- [ ] **Stop** then **start** the app; confirm again.
- [ ] **Uninstall** then **reinstall**; confirm behavior matches expectations (usually **data gone** unless you documented otherwise).

Repeat the same pattern for **World Monitor** after it is installed (e.g. UI preferences or cached data you care about). World Monitor persists Redis under `${APP_DATA_DIR}/redis` for the stack’s cache layer.

Anything **not** on a persisted volume is discarded on container recreation; even volume data is typically removed on **uninstall**—so this test is one of the most valuable real-device checks.

---

## 4. Fill the “Tested on umbrelOS” table in the store README

As soon as **Paperclip**, **World Monitor**, and (optionally) **Hermes** / **OpenCode** are verified to the level you need, update the table in [README.md](../README.md).

For eventual **official** submissions, Umbrel expects you to describe the **environment you tested on** (e.g. Raspberry Pi, Umbrel Home, x86 VM). Recording that now improves traceability even for a community store.

---

## 5. Hermes Agent (gateway) and OpenCode (stub)

**Hermes Agent**

- [ ] **`hermes-agent-umbrel` on GHCR is [public](https://github.com/harmalh?tab=packages)** — Umbrel pulls without `docker login`; a **private** package causes install to abort immediately (see [umbrel-hermes-agent README](https://github.com/harmalh/umbrel-hermes-agent#ghcr-package-must-be-public-umbrel-install))
- [ ] GHCR image pulls (`0.2.0@sha256:a7ee8728416b9e368b108f645978f4426b6556d64dc20c6a0a7427a21ba8e1ea` per store `docker-compose.yml`); rebuild via Actions when changing upstream
- [ ] Native **install** works from the store
- [ ] App **opens** from Umbrel (status/setup page)
- [ ] **`hermes` container** stays up (`docker logs harmalh-hermes-agent_hermes_1`); configure gateway via `docker exec` or `.env` under `APP_DATA_DIR/data`
- [ ] **Restart** preserves data under `data/`; **uninstall** clears app data as usual

**OpenCode** (still a minimal nginx stub)

- [ ] Install opens a **landing page** with packaging pointers

Defer full OpenCode product packaging until you swap in a real image.

---

## 6. World Monitor (multi-container)

- [ ] GHCR packages **worldmonitor-umbrel**, **worldmonitor-umbrel-ais-relay**, **worldmonitor-umbrel-redis-rest** are **public** (or your node can pull them)
- [ ] **Install** from the community store succeeds
- [ ] App **opens** from Umbrel; static UI and API routes behave (watch for proxy / `Origin` issues — see upstream nginx)
- [ ] **Restart** app: Redis volume under `redis/` retains data as expected for the stack
- [ ] **Uninstall** / **reinstall**: confirm expected data reset

---

## Prerequisites

- Store repo is **public** (or Umbrel can reach your private URL, if you use that).
- [GitHub Actions](https://github.com/harmalh/umbrel-community-store/actions) on `main` are green.

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
5. Open the store listing and **verify all three apps** show up with sensible **names, icons, and descriptions**:
   - `harmalh-paperclip` — Paperclip
   - `harmalh-hermes-agent` — Hermes Agent (stub)
   - `harmalh-opencode` — OpenCode (stub)

If something is wrong in the listing, fix `umbrel-app.yml` (and assets URLs) in this repo, push, and refresh the store on Umbrel.

---

## 2. Install Paperclip first

Paperclip is the first **real** app (full web UI). Hermes and OpenCode can stay **minimal nginx stubs** until you replace them.

**Goal for this step is “good enough,” not perfection:**

- [ ] Install succeeds
- [ ] App opens from the Umbrel dashboard
- [ ] Store/dashboard **icon and listing** look correct
- [ ] **Uninstall** then **reinstall** works (expect data loss on uninstall unless you have a backup strategy)
- [ ] **Restart** the app (or host) works
- [ ] No obvious packaging failure (compose, proxy, env)

Umbrel’s model assumes users use the **web UI**, not SSH—so a working UI path matters most here.

---

## 3. Test restart and persistence (do this right after Paperclip works)

Official packaging guidance stresses **volumes** and **what survives** stop/start vs uninstall.

After Paperclip is running:

- [ ] Create or change some **state you care about** (e.g. sign in, create a workspace, or any in-app setting).
- [ ] **Restart** the app from Umbrel; confirm expected state is still there.
- [ ] **Stop** then **start** the app; confirm again.
- [ ] **Uninstall** then **reinstall**; confirm behavior matches expectations (usually **data gone** unless you documented otherwise).

Anything **not** on a persisted volume is discarded on container recreation; even volume data is typically removed on **uninstall**—so this test is one of the most valuable real-device checks.

---

## 4. Fill the “Tested on umbrelOS” table in the store README

As soon as Paperclip (and optionally the stubs) are verified, update the table in [README.md](../README.md).

For eventual **official** submissions, Umbrel expects you to describe the **environment you tested on** (e.g. Raspberry Pi, Umbrel Home, x86 VM). Recording that now improves traceability even for a community store.

---

## 5. Hermes Agent and OpenCode — keep minimal for now

The nginx stub apps are **intentional**: Umbrel allows **server-style** apps that expose a **simple page** with setup or connection details instead of a full product UI.

**Enough for this phase:**

- [ ] Native **install** works from the store
- [ ] App **opens** from Umbrel
- [ ] **Landing page** explains what this is and points to the packaging repo / next steps
- [ ] **Volumes** and hooks behave (e.g. `APP_DATA_DIR` for stub HTML)

Defer deep Hermes/OpenCode feature packaging until Paperclip and persistence testing feel solid.

---

## Prerequisites

- Store repo is **public** (or Umbrel can reach your private URL, if you use that).
- [GitHub Actions](https://github.com/harmalh/umbrel-community-store/actions) on `main` are green.

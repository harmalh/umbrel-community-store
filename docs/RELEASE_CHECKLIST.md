# Release checklist (store + packaging repos)

## Per-app packaging repo (`umbrel-paperclip`, `umbrel-hermes-agent`, `umbrel-opencode`, `umbrel-worldmonitor`)

1. Merge changes on `main`; confirm **CI** workflow is green.
2. Build and push container images (manual or workflow); pin digests in `docker-compose.yml` when ready for production.
3. Bump `version` and `releaseNotes` in `umbrel-app.yml` (packaging copy).
4. Tag the repo if you use tag-based releases (optional).

## Community store (`umbrel-community-store`)

1. Copy updated `docker-compose.yml`, `umbrel-app.yml`, `assets/`, `hooks/` from the packaging repo into the matching **`harmalh-*` folder** (folder name = app id).
2. Ensure `app_proxy` `APP_HOST` matches `{folder}_{service}_1` (e.g. `harmalh-paperclip_web_1`).
3. Update icon/gallery URLs if they should point at this store repo’s `main` branch.
4. Run store **CI** on GitHub (YAML parse of compose/manifests); full `docker compose config` is not used because of Umbrel `app_proxy` merge.
5. Commit with a clear message (e.g. `store: sync harmalh-paperclip from umbrel-paperclip@<sha>`).
6. Push `main`; confirm store **CI** passes.

## Automation (future)

- Dependabot: enabled for GitHub Actions in this store (see `.github/dependabot.yml`).
- Optional: script or CI job to copy from packaging repos on release tags (TODO).

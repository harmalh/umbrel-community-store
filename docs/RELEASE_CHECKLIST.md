# Release Checklist

## Per-App Packaging Repo

Applies to:

- `umbrel-paperclip`
- `umbrel-paperclip-hermes`
- `umbrel-hermes-agent`
- `umbrel-hermes-workspace`
- `umbrel-opencode`
- `umbrel-worldmonitor`

For each packaging repo:

1. Merge changes on `main`.
2. Confirm CI is green.
3. Build and push container images if the release changes runtime artifacts.
4. Pin digests in `docker-compose.yml` when the build is ready for production.
5. Bump `version` and `releaseNotes` in the repo's `umbrel-app.yml`.

## Community Store

For `umbrel-community-store`:

1. Copy the updated app files from the packaging repo into the matching
   `harmalh-*` folder.
2. Confirm `app_proxy` `APP_HOST` matches `{app_id}_{service}_1`.
3. Update icon and gallery URLs so they point at this store repo when needed.
4. Run store CI and confirm YAML validation passes.
5. Commit with a clear sync message such as:
   `store: sync harmalh-hermes-workspace from umbrel-hermes-workspace@<sha>`
6. Push `main` and confirm store CI passes.

## Future Automation

- Optional CI to sync packaging repos into this store on tagged releases.
- Optional digest-pinning automation after successful image builds.

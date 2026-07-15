# Hamsterfish Build Monitor Homebrew Tap

## Authentication

For private GitHub repositories, Build Monitor needs a token with access to the
organization repositories and Actions metadata. The app checks these GitHub auth
options:

1. Token pasted into the in-app token field.
2. `GITHUB_TOKEN` environment variable.
3. `GH_TOKEN` environment variable.
4. `gh auth token`, if the GitHub CLI is installed and authenticated.

For Google Cloud Logging and Cloud Monitoring, the app checks these auth options:

1. `GOOGLE_OAUTH_ACCESS_TOKEN` environment variable.
2. `GCP_ACCESS_TOKEN` environment variable.
3. `GCLOUD_ACCESS_TOKEN` environment variable.
4. `gcloud auth print-access-token`, if the Google Cloud CLI is authenticated.
5. `gcloud auth application-default print-access-token`, if application-default
   credentials are configured.

The preferred local setup is:

```sh
gh auth login
gcloud auth login
gcloud auth application-default login
```

Tokens must not be committed to configuration files. UI preferences are stored in
`user-settings.json`, but pasted tokens are not written there.

## Install

```sh
brew tap IngmarStempellConsid/hamsterfish_buildmonitor
brew install IngmarStempellConsid/hamsterfish_buildmonitor/buildmonitor
```

If this tap or the mirrored release is private, set a read-only GitHub token for
Homebrew before installing:

```sh
export HOMEBREW_GITHUB_API_TOKEN=...
```

## Files

The formula installs the app launcher as `buildmonitor`. Config files live in:

```text
$(brew --prefix)/etc/buildmonitor/workflows.txt
$(brew --prefix)/etc/buildmonitor/gcp-projects.txt
$(brew --prefix)/etc/buildmonitor/metrics.txt
$(brew --prefix)/etc/buildmonitor/user-settings.json
```

The full application README is installed with the package and is also included in
the release archive.

# homebrew-tap

Personal [Homebrew](https://brew.sh) tap for [jmarette](https://github.com/jmarette)'s tools.

## Install

```console
$ brew install jmarette/tap/git-id
```

or, equivalently:

```console
$ brew tap jmarette/tap
$ brew install git-id
```

> **Known issue with Homebrew 6.0.x:** the new tap-trust check can make
> builds from third-party taps fail silently
> (`Error: Failure while executing ... build.rb ... exited with 1`, with empty
> build logs) — even after `brew trust jmarette/tap`. Until this is fixed
> upstream, work around it with:
>
> ```console
> $ HOMEBREW_NO_REQUIRE_TAP_TRUST=1 brew install jmarette/tap/git-id
> ```

## Formulae

| Formula | Description |
|---|---|
| [`git-id`](Formula/git-id.rb) | Manage Git identities and route them to directories via native conditional includes |

## Cutting a new git-id release

Releases are automated with
[cargo-dist](https://axodotdev.github.io/cargo-dist/). In the `git-id`
repository:

1. Bump the version in `Cargo.toml`, set the release date on the `Unreleased`
   section of `CHANGELOG.md`, commit and push.
2. Tag and push the tag:

   ```console
   $ git tag v0.2.0 && git push origin v0.2.0
   ```

GitHub Actions then builds the binaries (macOS/Linux, arm64 + x86_64),
creates the GitHub Release, and pushes the regenerated `Formula/git-id.rb`
to this tap automatically (requires the `HOMEBREW_TAP_TOKEN` secret on the
`git-id` repository). Users get the update with `brew upgrade git-id`.

> The formula is generated — do not edit it by hand, changes are overwritten
> at every release. `scripts/bump.sh` only remains as a manual fallback for
> the legacy source-based formula.

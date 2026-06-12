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

1. In the `git-id` repository: bump the version in `Cargo.toml`, update
   `CHANGELOG.md` (set the release date on the `Unreleased` section), commit,
   then tag and push:

   ```console
   $ git tag v0.2.0 && git push origin master --tags
   ```

2. In this repository, update the formula (downloads the tag tarball from
   GitHub and rewrites `url` + `sha256`):

   ```console
   $ scripts/bump.sh 0.2.0
   ```

3. Review, commit and push:

   ```console
   $ git commit -am "git-id 0.2.0" && git push
   ```

Users get the update with `brew upgrade git-id`.

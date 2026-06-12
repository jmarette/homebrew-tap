#!/usr/bin/env bash
# Point Formula/git-id.rb at a released version of git-id.
#
# Usage: scripts/bump.sh <version>     e.g. scripts/bump.sh 0.1.0
# The tag v<version> must already be pushed to github.com/jmarette/git-id.
set -euo pipefail

version="${1:?usage: scripts/bump.sh <version>  (e.g. 0.1.0)}"
url="https://github.com/jmarette/git-id/archive/refs/tags/v${version}.tar.gz"

echo "Fetching ${url}"
sha256=$(curl -fsSL "$url" | shasum -a 256 | awk '{print $1}')

formula="$(cd "$(dirname "$0")/.." && pwd)/Formula/git-id.rb"
sed -i '' \
  -e "s|^  url .*|  url \"${url}\"|" \
  -e "s|^  sha256 .*|  sha256 \"${sha256}\"|" \
  "$formula"
# Drop the placeholder comment once a real sha256 is in place.
sed -i '' -e '/Placeholder until the v0.1.0 tag is pushed/d' "$formula"

echo "Formula updated: git-id v${version}"
echo "  sha256: ${sha256}"
echo "Next: review the diff, then commit and push this tap."

#!/usr/bin/env bash
# Builds the ZIP that OpenAI's plugin portal takes for a plugin of this marketplace: the plugin's
# folder as a committed ref has it (not the working tree), with only what OpenAI reads — the Codex
# manifest, the MCP server, the skills, the assets, the README, the privacy policy and the license.
#
# Usage: scripts/build-openai-zip.sh [plugin] [ref]
#   plugin  folder under plugins/ (default: adsgpt)
#   ref     branch, tag or commit to build from (default: main)
#
# Writes <plugin>-<version>.zip in the current directory, with the version of the Codex manifest.
set -euo pipefail

plugin="${1:-adsgpt}"
ref="${2:-main}"
root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
folder="plugins/$plugin"
files=(.codex-plugin .mcp.json skills assets README.md PRIVACY.md LICENSE)

git -C "$root" rev-parse --verify --quiet "$ref^{commit}" > /dev/null || {
  echo "No such ref: $ref" >&2
  exit 1
}
git -C "$root" cat-file -e "$ref:$folder/.codex-plugin/plugin.json" 2> /dev/null || {
  echo "No Codex manifest at $folder/.codex-plugin/plugin.json in $ref" >&2
  exit 1
}

version="$(git -C "$root" show "$ref:$folder/.codex-plugin/plugin.json" |
  sed -n 's/^  "version": "\(.*\)",$/\1/p')"
out="$PWD/$plugin-$version.zip"

# A tree path makes the plugin's folder the root of the ZIP; each listed file must exist.
for file in "${files[@]}"; do
  git -C "$root" cat-file -e "$ref:$folder/$file" 2> /dev/null || {
    echo "Missing $folder/$file in $ref" >&2
    exit 1
  }
done
git -C "$root" archive --format=zip -o "$out" "$ref:$folder" "${files[@]}"

echo "Built $out from $ref ($(git -C "$root" rev-parse --short "$ref")), version $version:"
unzip -Z1 "$out" | grep -v '/$' | sed 's/^/  /'

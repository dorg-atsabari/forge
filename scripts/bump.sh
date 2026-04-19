#!/usr/bin/env bash
# Bump a plugin's version.
# Usage: ./scripts/bump.sh <plugin-dir> [patch|minor|major]
#   plugin-dir: path to plugin root (contains .claude-plugin/plugin.json)
#   level: patch (default), minor, or major
set -euo pipefail

PLUGIN_DIR="${1:-}"
LEVEL="${2:-patch}"

if [[ -z "$PLUGIN_DIR" ]]; then
  echo "ERROR: plugin dir required. Usage: $0 <plugin-dir> [patch|minor|major]" >&2
  exit 1
fi

FILE="$PLUGIN_DIR/.claude-plugin/plugin.json"
if [[ ! -f "$FILE" ]]; then
  echo "ERROR: $FILE not found" >&2
  exit 1
fi

NAME=$(jq -r ".name" "$FILE")
CUR=$(jq -r ".version" "$FILE")
if [[ -z "$CUR" || "$CUR" == "null" ]]; then
  echo "ERROR: no version field in $FILE" >&2
  exit 1
fi

NEW=$(echo "$CUR" | awk -F. -v l="$LEVEL" '{
  if (l=="major")      print ($1+1)".0.0";
  else if (l=="minor") print $1"."($2+1)".0";
  else                 print $1"."$2"."($3+1)
}')

jq ".version = \"$NEW\"" "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

echo "bumped $NAME: $CUR -> $NEW ($LEVEL)"

if [[ "${CI:-}" != "true" ]]; then
  git add "$FILE"
  git commit -m "chore($NAME): bump to v$NEW"
  git tag "$NAME-v$NEW"
  echo "committed + tagged $NAME-v$NEW. push with: git push && git push --tags"
fi

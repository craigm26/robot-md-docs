#!/usr/bin/env bash
# Refresh docs/stylesheets/tokens.css from apex source-of-truth.
# Run manually after apex tokens.css changes. CI gates drift with token-drift.yml.
set -euo pipefail

APEX_URL="https://robotmd.dev/css/tokens.css"
DEST="$(dirname "$0")/../docs/stylesheets/tokens.css"

echo "Fetching $APEX_URL → $DEST"
curl -fsS -H 'User-Agent: robot-md-docs/sync-tokens.sh' "$APEX_URL" -o "$DEST"
echo "Done. Diff (vs git HEAD):"
git --no-pager diff -- "$DEST" || true

#!/usr/bin/env bash
set -euo pipefail
echo "[msipn-ci] Starting GitHub install smoke test"
TMPDIR="$(mktemp -d)"
echo "[msipn-ci] Temp dir: $TMPDIR"
cd "$TMPDIR"
cat > package.json <<'JSON'
{
  "name": "msipn-ci-smoke",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "dependencies": {
    "@pasosdejesus/msipn": "github:pasosdeJesus/msip#msipn",
    "kysely": "^0.27.3",
    "pg": "^8.11.5"
  }
}
JSON
echo "[msipn-ci] Installing dependencies"
pnpm install --frozen-lockfile=false > install.log 2>&1 || { echo "Install failed"; cat install.log; exit 1; }
echo "[msipn-ci] Running npx msipn --help"
set +e
OUT=$(npx msipn --help 2>&1)
RC=$?
set -e
echo "$OUT" | head -50
if [[ $RC -ne 0 ]]; then
  echo "[msipn-ci] ERROR: msipn --help exited with $RC" >&2
  exit 1
fi
grep -q "db:migrate" <<< "$OUT" || { echo "[msipn-ci] ERROR: help output missing db:migrate"; exit 1; }
grep -q "db:rollback" <<< "$OUT" || { echo "[msipn-ci] ERROR: help output missing db:rollback"; exit 1; }
echo "[msipn-ci] Success: msipn help includes expected commands"
exit 0

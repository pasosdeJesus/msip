#!/bin/sh
# POSIX compatible ordered test runner (no bashisms)
set -eu
ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT_DIR"

# Executes tests in strict order stopping at first failure.

FILES="tests/ordered/01_i18n_env.test.ts
tests/ordered/02_db_super_createuser.test.ts
tests/ordered/03_db_create_drop_create.test.ts
tests/ordered/04_migrations_core.test.ts
tests/ordered/05_migrations_app_injection.test.ts"

COUNT=$(printf '%s\n' "$FILES" | sed '/^$/d' | wc -l | tr -d ' ')
echo "[ordered-tests] Starting sequential execution of $COUNT files" >&2

printf '%s\n' "$FILES" | sed '/^$/d' | while IFS= read -r f; do
  [ -n "$f" ] || continue
  if [ ! -f "$f" ]; then
    echo "[ordered-tests] File not found: $f" >&2
    exit 1
  fi
  echo "[ordered-tests] === Running $f ===" >&2
  npx vitest run "$f"
  echo "[ordered-tests] === OK $f ===" >&2
done

echo "[ordered-tests] Suite completed successfully" >&2

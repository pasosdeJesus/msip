#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

# Ejecuta pruebas en orden estricto deteniéndose ante el primer fallo.
# Usa vitest run por archivo para asegurar orden determinista incluso si Vitest cambia heurísticas internas.

FILES=(
  "tests/ordered/01_i18n_env.test.ts"
  "tests/ordered/02_db_super_createuser.test.ts"
  "tests/ordered/03_db_create_drop_create.test.ts"
  "tests/ordered/04_migrations_core.test.ts"
  "tests/ordered/05_migrations_app_injection.test.ts"
)

echo "[ordered-tests] Iniciando ejecución secuencial de ${#FILES[@]} archivos" >&2

for f in "${FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "[ordered-tests] Archivo no encontrado: $f" >&2
    exit 1
  fi
  echo "[ordered-tests] === Ejecutando $f ===" >&2
  npx vitest run "$f"
  echo "[ordered-tests] === OK $f ===" >&2
done

echo "[ordered-tests] Suite completada satisfactoriamente" >&2

import { describe, it, expect } from 'vitest';
import { execSync, spawnSync } from 'node:child_process';
import path from 'node:path';

// 02: Crea/actualiza rol superusuario requerido para pruebas posteriores.

function canRun(cmd: string, args: string[]): boolean {
  try {
    const r = spawnSync(cmd, args, { stdio: 'ignore' });
    return r.status === 0;
  } catch { return false; }
}

describe('db:super:createuser command', () => {
  const BIN = path.join(process.cwd(), 'bin', 'msipn');
  const targetRole = process.env.PGUSER || 'msipn';
  const hasSudo = canRun('sudo', ['-n', 'true']);
  const canPostgres = canRun('sudo', ['-n', '-u', 'postgres', 'id', '-u']);
  const skip = !hasSudo || !canPostgres;

  (skip ? describe.skip : describe)('when sudo -n -u postgres available', () => {
    it('creates or updates the role without error (idempotent)', () => {
      execSync(`${BIN} db:super:createuser`, { stdio: 'pipe', env: process.env });
      execSync(`${BIN} db:super:createuser`, { stdio: 'pipe', env: process.env });
      const info = execSync(`sudo -n -u postgres psql -t -A -c "SELECT rolname||','||rolsuper FROM pg_roles WHERE rolname='${targetRole}'"`, { stdio: 'pipe' }).toString().trim();
      expect(info).toMatch(new RegExp(`^${targetRole},(t|true)$`));
    });
  });
});

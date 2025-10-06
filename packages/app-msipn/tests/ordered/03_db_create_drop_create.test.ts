import { execSync, spawnSync } from 'node:child_process';
import path from 'node:path';
import { describe, it, expect } from 'vitest';
import { existsSync, readFileSync } from 'node:fs';

// 03: Asegura ciclo crear/eliminar y termina con base creada para migraciones.
// Precondiciones personalizadas: no dependemos de que la BD exista aún.
// En lugar de requireOrSkipPg verificamos:
// (1) which psql retorna ruta
// (2) existe ~/.pgpass y contiene entrada para PGHOST:PGPORT:PGDATABASE:PGUSER:PGPASSWORD (puede usar '*')
// (3) psql -U $PGUSER -h $PGHOST -lqt funciona (lista bases) aun si la base destino todavía no existe.

const BIN = path.join(process.cwd(), 'bin', 'msipn');

function dbExists(db: string): boolean {
  const host = process.env.PGHOST || 'localhost';
  const user = process.env.PGUSER || 'msipn';
  const args = ['-h', host, '-U', user, '-lqt'];
  const r = spawnSync('psql', args, { env: process.env, encoding: 'utf-8' });
  if (r.status !== 0) return false;
  return r.stdout.split(/\n/).some(line => line.split('|')[0].trim() === db);
}

describe('Secuencia db:create / db:drop / db:create', () => {
  it('preconditions: psql disponible y credenciales en ~/.pgpass', () => {
    const which = spawnSync('which', ['psql'], { encoding: 'utf-8' });
    expect(which.status).toBe(0);
    expect(which.stdout.trim()).toMatch(/psql$/);

    const home = process.env.HOME || process.env.USERPROFILE || '';
    const pgpassPath = path.join(home, '.pgpass');
    expect(existsSync(pgpassPath)).toBe(true);
    const pgpassContent = readFileSync(pgpassPath, 'utf-8').split(/\r?\n/);
    const host = process.env.PGHOST || 'localhost';
    const db = process.env.PGDATABASE || 'msipn_dev';
    const user = process.env.PGUSER || 'msipn';
    const pass = process.env.PGPASSWORD || '';
    function matches(line: string): boolean {
      if (!line || line.startsWith('#')) return false;
      const parts = line.split(':');
      if (parts.length < 5) return false;
      const [h, port, d, u, p] = parts;
      const hostOk = h === '*' || h === host;
      const portOk = !port || port === '*' || /^[0-9]+$/.test(port);
      const dbOk = d === '*' || d === db;
      const userOk = u === '*' || u === user;
      const passOk = !pass || p === pass || p === '*';
      return hostOk && portOk && dbOk && userOk && passOk;
    }
    const hasEntry = pgpassContent.some(matches);
    expect(hasEntry).toBe(true);

  const list = spawnSync('psql', ['-h', host, '-U', user, '-lqt'], { env: process.env, encoding: 'utf-8' });
    expect(list.status).toBe(0);
  });
  const baseDb = process.env.PGDATABASE || 'msipn_dev';
  const tempDb = baseDb + '_tmpcdc';

  it('crea base de datos temporal', () => {
    if (dbExists(tempDb)) {
      try { execSync(`${BIN} db:drop`, { env: { ...process.env, PGDATABASE: tempDb } }); } catch {}
    }
    execSync(`${BIN} db:create`, { env: { ...process.env, PGDATABASE: tempDb }, stdio: 'pipe' });
    expect(dbExists(tempDb)).toBe(true);
  });

  it('elimina base de datos temporal', () => {
    execSync(`${BIN} db:drop`, { env: { ...process.env, PGDATABASE: tempDb }, stdio: 'pipe' });
    expect(dbExists(tempDb)).toBe(false);
  });

  it('asegura que la base principal existe al final', () => {
    if (!dbExists(baseDb)) {
      execSync(`${BIN} db:create`, { env: { ...process.env, PGDATABASE: baseDb }, stdio: 'pipe' });
    }
    expect(dbExists(baseDb)).toBe(true);
  });
});

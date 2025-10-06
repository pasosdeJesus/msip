import { describe, it, expect } from 'vitest';
import { getT } from '@pasosdejesus/msipn-core';
import { spawnSync } from 'child_process';
import path from 'path';

// 01: Verifica traducciones y ayuda CLI según LANG

describe('i18n translations (integration)', () => {
  it('resolves English entity label', async () => {
    const t = await getT('en');
    expect(t('entity.tdocumento.singular')).toBe('Document Type');
  });

  it('resolves Spanish entity label', async () => {
    const t = await getT('es');
    expect(t('entity.tdocumento.singular')).toBe('Tipo de Documento');
  });

  it('resolves validation key English', async () => {
    const t = await getT('en');
    expect(t('validation.usuario.email_invalid')).toBe('invalid email');
  });

  it('resolves validation key Spanish', async () => {
    const t = await getT('es');
    expect(t('validation.usuario.email_invalid')).toBe('email inválido');
  });
});

describe('CLI i18n via spawned process', () => {
  it('shows Spanish help when LANG=es', () => {
    const bin = path.join(__dirname, '..', '..', 'bin', 'msipn');
    const res = spawnSync('node', [bin, '--help'], {
      env: { ...process.env, LANG: 'es_ES.UTF-8' },
      encoding: 'utf-8'
    });
    const out = res.stdout + res.stderr;
    // Debe contener descripciones en español exactas para create y drop
  const lines = out.split(/\r?\n/).map(l => l.replace(/^\s+/, '').trimEnd());
  // Usamos startsWith para tolerar variaciones mínimas de espacios entre comando y descripción
  expect(lines.find(l => l.startsWith('db:create') && /Crea la base de datos$/.test(l))).toBeTruthy();
  expect(lines.find(l => l.startsWith('db:drop') && /Elimina la base de datos$/.test(l))).toBeTruthy();
    // Chequeos parciales adicionales
    expect(out).toMatch(/Vuelca estructura actual/);
    // No debe contener la versión inglesa de una descripción principal
    expect(out).not.toMatch(/Create database/);
  });
  it('shows English help when LANG=en', () => {
    const bin = path.join(__dirname, '..', '..', 'bin', 'msipn');
    const res = spawnSync('node', [bin, '--help'], {
      env: { ...process.env, LANG: 'en_US.UTF-8' },
      encoding: 'utf-8'
    });
    const out = res.stdout + res.stderr;
    // Must contain English descriptions exact lines for create and drop
  const lines = out.split(/\r?\n/).map(l => l.replace(/^\s+/, '').trimEnd());
  expect(lines.find(l => l.startsWith('db:create') && /Create database$/.test(l))).toBeTruthy();
  expect(lines.find(l => l.startsWith('db:drop') && /Drop database$/.test(l))).toBeTruthy();
    // Partial check for another command
    expect(out).toMatch(/Dump current DB structure/);
    // Should not contain Spanish main description
    expect(out).not.toMatch(/Crea la base de datos/);
  });
});

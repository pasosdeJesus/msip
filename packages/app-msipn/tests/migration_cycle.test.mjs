// Archivo legado desactivado.
// Se mantiene sólo para referencia histórica pero sin ejecutar lógica fuera de Vitest.
// TODO: Eliminar definitivamente cuando se confirme suite estable.

import { describe, it, expect } from 'vitest';

describe.skip('legacy migration cycle (disabled)', () => {
  it('placeholder', () => {
    expect(true).toBe(true);
  });
});

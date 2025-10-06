import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'node',
    testTimeout: 60000,
    hookTimeout: 60000,
    setupFiles: ['tests/setup-env.ts'],
    include: [
      'tests/ordered/0*_*.test.ts'
    ],
    sequence: {
      concurrent: false,
      shuffle: false
    },
    coverage: {
      enabled: false
    }
  }
});

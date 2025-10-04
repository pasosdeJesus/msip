import * as path from 'path';
import * as fs from 'fs';
import dotenv from 'dotenv';

export function loadEnv() {
  const root = path.resolve(__dirname, '../../../../..');
  const envFile = path.join(root, '.env');
  if (fs.existsSync(envFile)) {
    dotenv.config({ path: envFile });
  }
}

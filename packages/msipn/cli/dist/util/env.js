import * as path from 'path';
import * as fs from 'fs';
import dotenv from 'dotenv';
export function loadEnv() {
    const fallbackEnv = path.join(process.cwd(), '.env');
    if (fs.existsSync(fallbackEnv)) {
        dotenv.config({ path: fallbackEnv });
    }
}

#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Carga .env del cwd (aplicación) incluso si se ejecuta con sudo.
// Si se usa sudo y se pierde alguna variable PG*, la volvemos a inyectar.
const cwdEnv = path.join(process.cwd(), '.env');
let loadedEnv = {};
if (fs.existsSync(cwdEnv)) {
	const parsed = dotenv.config({ path: cwdEnv });
	if (parsed.parsed) loadedEnv = parsed.parsed;
} else {
	const localTemplate = path.join(process.cwd(), '.env.template');
	if (fs.existsSync(localTemplate)) {
		console.error('No se encontró .env. Cree uno copiando .env.template');
	} else {
		console.error('No se encontró .env ni .env.template en este directorio.');
	}
}

// Reinyectar variables críticas si están ausentes tras sudo
const criticalKeys = ['PGUSER','PGPASSWORD','PGHOST','PGPORT','PGDATABASE','PGSYSTEMUSER'];
for (const k of criticalKeys) {
	if (!process.env[k] && loadedEnv[k]) {
		process.env[k] = loadedEnv[k];
	}
}

// Si se ejecuta con sudo y no se definió PG_ESCALATION y somos root, forzamos modo sudo para que runDbSuperCreateUser
// degrade a ejecución como postgres sin interacción (consistente con expectativa de comando `sudo ...`).
if (process.env.SUDO_USER && !process.env.PG_ESCALATION) {
	process.env.PG_ESCALATION = 'sudo';
}
import '../dist/index.js';

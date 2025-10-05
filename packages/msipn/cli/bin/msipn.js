#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Sólo buscar .env en el directorio actual (aplicación objetivo)
const cwdEnv = path.join(process.cwd(), '.env');
if (fs.existsSync(cwdEnv)) {
	dotenv.config({ path: cwdEnv });
} else {
	const localTemplate = path.join(process.cwd(), '.env.template');
	if (fs.existsSync(localTemplate)) {
		console.error('No se encontró .env. Cree uno copiando .env.template');
	} else {
		console.error('No se encontró .env ni .env.template en este directorio.');
	}
}
import '../dist/index.js';

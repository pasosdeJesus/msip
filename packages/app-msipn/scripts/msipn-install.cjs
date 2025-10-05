#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const targetDir = path.join(process.cwd(), 'bin');
const binFile = path.join(targetDir, 'msipn');
const cliRel = path.relative(targetDir, path.join(process.cwd(), '../msipn/cli/bin/msipn.js'));

if (!fs.existsSync(targetDir)) {
  fs.mkdirSync(targetDir, { recursive: true });
}

const force = process.env.FORCE === '1' || process.argv.includes('--force');
if (fs.existsSync(binFile) && !force) {
  console.log('bin/msipn ya existe. Use --force o FORCE=1 para sobrescribir.');
} else {
  const content = `#!/usr/bin/env node\nimport '${cliRel.replace(/\\/g,'/')}';\n`;
  fs.writeFileSync(binFile, content, { encoding: 'utf-8' });
  fs.chmodSync(binFile, 0o755);
  console.log((fs.existsSync(binFile) ? 'Actualizado' : 'Creado') + ' bin/msipn apuntando al CLI del motor (ruta relativa: ' + cliRel + ')');
}

// Crear .env.template si no existe
const envTemplate = path.join(process.cwd(), '.env.template');
if (!fs.existsSync(envTemplate)) {
  const tpl = `PGDATABASE=msipn_dev\nPGHOST=/var/run/postgresql\nPGPORT=\nPGUSER=msipn\nPGPASSWORD=xyz\n`;
  fs.writeFileSync(envTemplate, tpl, 'utf-8');
  console.log('Creado .env.template base');
}

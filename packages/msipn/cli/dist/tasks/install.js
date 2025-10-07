import fs from 'node:fs';
import path from 'node:path';
import { success, info, warn, problem } from '../util/colors.js';
// Name of the main msipn package (CLI is the entrypoint)
const CLI_PKG_NAME = '@pasosdejesus/msipn';
const PEERS = { kysely: '^0.27.3', pg: '^8.11.5' };
export async function runInstallCommand() {
    const cwd = process.cwd();
    const pkgPath = path.join(cwd, 'package.json');
    if (!fs.existsSync(pkgPath)) {
        problem('No package.json found in current directory; run inside a Node project.');
        process.exitCode = 1;
        return;
    }
    const raw = fs.readFileSync(pkgPath, 'utf-8');
    let pkg;
    try {
        pkg = JSON.parse(raw);
    }
    catch (e) {
        problem('package.json is not valid JSON');
        process.exitCode = 1;
        return;
    }
    // Ensure dependency present; use GitHub spec for direct installs
    const targetVersion = 'github:pasosdeJesus/msip#msipn';
    pkg.dependencies = pkg.dependencies || {};
    if (!pkg.dependencies[CLI_PKG_NAME]) {
        pkg.dependencies[CLI_PKG_NAME] = targetVersion;
        info(`Added dependency ${CLI_PKG_NAME}@${targetVersion}`);
    }
    else {
        info(`Dependency ${CLI_PKG_NAME} already present (${pkg.dependencies[CLI_PKG_NAME]})`);
    }
    // Add peer dependencies
    for (const [dep, ver] of Object.entries(PEERS)) {
        if (!pkg.dependencies[dep] && !(pkg.devDependencies && pkg.devDependencies[dep])) {
            pkg.dependencies[dep] = ver;
            info(`Added dependency ${dep}@${ver}`);
        }
    }
    // Create bin directory and wrapper (non-overwriting unless force flag)
    const binDir = path.join(cwd, 'bin');
    fs.mkdirSync(binDir, { recursive: true });
    const binFile = path.join(binDir, 'msipn');
    if (!fs.existsSync(binFile)) {
        const content = `#!/usr/bin/env node\nimport('${CLI_PKG_NAME}/bin/msipn.js')\n`;
        fs.writeFileSync(binFile, content, { mode: 0o755 });
        info('Created bin/msipn wrapper script');
    }
    else {
        warn('bin/msipn already exists (left unchanged)');
    }
    // Write back package.json
    fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n');
    success('Install command completed. Run your package manager to install new dependencies (e.g. pnpm install / npm install / yarn).');
}

import i18next from 'i18next';
import Backend from 'i18next-fs-backend';
import path from 'path';
import { fileURLToPath } from 'url';
import { detectLocale } from './util/locale.js';
// __dirname emulación para ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
let initPromise = null;
export async function getCliT(locale) {
    const desired = locale || detectLocale();
    if (!initPromise) {
        initPromise = i18next
            .use(Backend)
            .init({
            lng: desired,
            fallbackLng: 'en',
            supportedLngs: ['en', 'es'],
            ns: ['cli'],
            defaultNS: 'cli',
            backend: {
                loadPath: path.join(__dirname, '..', 'locales', '{{lng}}', '{{ns}}.json')
            },
            interpolation: { escapeValue: false }
        })
            .then(() => i18next.t.bind(i18next));
    }
    if (desired && i18next.language !== desired) {
        await i18next.changeLanguage(desired);
    }
    return initPromise;
}
export async function cliKey(key, vars) {
    const t = await getCliT();
    return t(key, vars);
}

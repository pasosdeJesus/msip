import i18next from 'i18next';
import Backend from 'i18next-fs-backend';
import path from 'path';
import { fileURLToPath } from 'url';
// __dirname emulación para ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
let initPromise = null;
export async function getCliT(locale) {
    if (!initPromise) {
        const lng = locale || detect();
        initPromise = i18next
            .use(Backend)
            .init({
            lng,
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
    if (locale && i18next.language !== locale) {
        await i18next.changeLanguage(locale);
    }
    return initPromise;
}
function detect() {
    const env = process.env.LANG || process.env.LC_ALL || process.env.LC_MESSAGES;
    if (!env)
        return 'en';
    const base = env.split('.')[0];
    const short = base.split('_')[0];
    return ['en', 'es'].includes(short) ? short : 'en';
}
export async function cliKey(key, vars) {
    const t = await getCliT();
    return t(key, vars);
}

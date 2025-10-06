import i18next, { TFunction } from 'i18next';
import Backend from 'i18next-fs-backend';
import path from 'path';
import { fileURLToPath } from 'url';
import { detectLocale } from './util/locale.js';

// __dirname emulación para ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let initPromise: Promise<TFunction> | null = null;

export async function getCliT(locale?: string): Promise<TFunction> {
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

export async function cliKey(key: string, vars?: Record<string, any>): Promise<string> {
  const t = await getCliT();
  return t(key, vars);
}

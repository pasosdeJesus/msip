import i18next, { TFunction } from 'i18next';
import Backend from 'i18next-fs-backend';
import path from 'path';

let initialized: Promise<TFunction> | null = null;

export async function getT(locale?: string): Promise<TFunction> {
  if (!initialized) {
    const lng = locale || detectLang();
    initialized = i18next
      .use(Backend)
      .init({
        lng,
        fallbackLng: 'en',
        supportedLngs: ['en', 'es'],
        ns: ['domain', 'cli'],
        defaultNS: 'domain',
        backend: {
          loadPath: path.join(__dirname, '..', '..', 'locales', '{{lng}}', '{{ns}}.json')
        },
        interpolation: { escapeValue: false }
      })
      .then(() => i18next.t.bind(i18next));
  }
  if (locale && i18next.language !== locale) {
    await i18next.changeLanguage(locale);
  }
  return initialized;
}

function detectLang(): string {
  const env = process.env.LANG || process.env.LC_ALL || process.env.LC_MESSAGES;
  if (!env) return 'en';
  const base = env.split('.')[0];
  const short = base.split('_')[0];
  if (['en', 'es'].includes(short)) return short;
  return 'en';
}

export async function tKey(key: string, locale?: string): Promise<string> {
  const t = await getT(locale);
  return t(key);
}

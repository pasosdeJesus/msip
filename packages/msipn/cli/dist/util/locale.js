// Unified locale detection logic for CLI
// Priority: explicit MSIPN_LOCALE > LANG > LC_ALL > LC_MESSAGES
// Returns 'es' only if starts with es (case-insensitive), otherwise 'en'.
export function detectLocale(env = process.env) {
    const candidates = [env.MSIPN_LOCALE, env.LANG, env.LC_ALL, env.LC_MESSAGES];
    for (const c of candidates) {
        if (!c)
            continue;
        const base = c.split('.')[0];
        const short = base.split('_')[0].toLowerCase();
        if (short === 'es')
            return 'es';
        if (short === 'en')
            return 'en';
    }
    return 'en';
}
export function isSpanish(env = process.env) {
    return detectLocale(env) === 'es';
}

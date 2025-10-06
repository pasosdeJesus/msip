import { TFunction } from 'i18next';
export declare function getCliT(locale?: string): Promise<TFunction>;
export declare function cliKey(key: string, vars?: Record<string, any>): Promise<string>;

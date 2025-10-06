import { TFunction } from 'i18next';
export declare function getT(locale?: string): Promise<TFunction>;
export declare function tKey(key: string, locale?: string): Promise<string>;

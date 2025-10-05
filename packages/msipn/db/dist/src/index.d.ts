import { Kysely } from 'kysely';
import 'dotenv/config';
export type DB = any;
export declare function getDb(): Kysely<DB>;
export declare function closeDb(): Promise<void>;

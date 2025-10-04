import { EntityDefinition } from './types';
export declare function registerEntity(e: EntityDefinition): EntityDefinition;
export declare function getEntity(name: string): EntityDefinition;
export declare function listEntities(): EntityDefinition[];
export declare function ensureRegistered(entities: EntityDefinition[]): void;

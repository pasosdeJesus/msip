import { EntityDefinition } from './types';

const registry: Record<string, EntityDefinition> = {};

export function registerEntity(e: EntityDefinition) {
  registry[e.name] = e;
  return e;
}

export function getEntity(name: string) {
  return registry[name];
}

export function listEntities() {
  return Object.values(registry);
}

// Utilidad para inicialización perezosa si se requiere
export function ensureRegistered(entities: EntityDefinition[]) {
  entities.forEach(registerEntity);
}

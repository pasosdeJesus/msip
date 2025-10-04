const registry = {};
export function registerEntity(e) {
    registry[e.name] = e;
    return e;
}
export function getEntity(name) {
    return registry[name];
}
export function listEntities() {
    return Object.values(registry);
}
// Utilidad para inicialización perezosa si se requiere
export function ensureRegistered(entities) {
    entities.forEach(registerEntity);
}

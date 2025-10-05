import '@pasosdejesus/msipn-domain-tdocumento';
import '@pasosdejesus/msipn-domain-etnia';
import '@pasosdejesus/msipn-domain-persona';
import '@pasosdejesus/msipn-domain-usuario';

import { listEntities, getEntity } from '@pasosdejesus/msipn-core';

console.log('Entidades registradas:');
for (const e of listEntities()) {
  const fieldNames = Object.keys(e.fields);
  console.log(`- ${e.name} (tabla: ${e.table}) campos: ${fieldNames.join(', ')}`);
}

// Pequeña verificación de permisos sobre persona como OPERADOR (rol 5)
const persona = getEntity('persona');
if (persona?.permissions) {
  const ctxOp = { user: { rol: 5 } } as any; // simplificado
  const puedeCrearPersona = persona.permissions.create(ctxOp);
  console.log(`OPERADOR puede crear persona? ${puedeCrearPersona}`);
}

// ADMIN (1)
if (persona?.permissions) {
  const ctxAdmin = { user: { rol: 1 } } as any;
  const puedeBorrarPersona = persona.permissions.delete(ctxAdmin);
  console.log(`ADMIN puede borrar persona? ${puedeBorrarPersona}`);
}

console.log('Dummy listo');
import { basicaMixin } from './basicaMixin';
import { EntityDefinition, FieldDefinition, ValidationRule, PermissionSet } from './types';
import { esAdminLike } from './roles';
import { registerEntity } from './registry';

export interface MakeBasicaOptions {
  name: string;                 // nombre lógico
  table: string;                // nombre tabla real
  labels: { singular: string; plural: string };
  extraFields?: Record<string, FieldDefinition>;
  extraValidations?: ValidationRule[];
  permissions?: Partial<PermissionSet>; // permitir override
  nombreUnique?: boolean;
  orderField?: string;
}

export function makeBasicaEntity(opts: MakeBasicaOptions): EntityDefinition {
  const bm = basicaMixin({ enforceNombreUnique: opts.nombreUnique !== false });
  const basePerms: PermissionSet = {
    read: () => true,
    create: ({ user }) => esAdminLike(user),
    update: ({ user }) => esAdminLike(user),
    delete: ({ user }) => esAdminLike(user)
  };
  const mergedPerms: PermissionSet = {
    ...basePerms,
    ...opts.permissions
  } as PermissionSet;

  const entity: EntityDefinition = {
    name: opts.name,
    table: opts.table,
    primaryKey: 'id',
    labels: opts.labels,
    fields: {
      id: { type: 'integer', required: true, sortable: true },
      ...bm.fields,
      ...(opts.extraFields || {})
    },
  filters: bm.filters,
    validations: [
      ...bm.validations,
      ...(opts.extraValidations || [])
    ],
    permissions: mergedPerms,
    presentation: {
      label: (r: any) => r.nombre
    }
  };
  registerEntity(entity);
  return entity;
}

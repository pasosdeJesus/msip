import { basicaMixin } from './basicaMixin';
import { esAdminLike } from './roles';
import { registerEntity } from './registry';
export function makeBasicaEntity(opts) {
    const bm = basicaMixin({ enforceNombreUnique: opts.nombreUnique !== false });
    const basePerms = {
        read: () => true,
        create: ({ user }) => esAdminLike(user),
        update: ({ user }) => esAdminLike(user),
        delete: ({ user }) => esAdminLike(user)
    };
    const mergedPerms = {
        ...basePerms,
        ...opts.permissions
    };
    const entity = {
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
            label: (r) => r.nombre
        }
    };
    registerEntity(entity);
    return entity;
}

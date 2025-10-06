import { esAdminLike, tieneRol, registerEntity } from '@pasosdejesus/msipn-core';
export const personaEntity = {
    name: 'persona',
    table: 'msip_persona',
    primaryKey: 'id',
    // Labels use keys entity.persona.* for external resolution
    labels: { singular: 'Person', plural: 'People' },
    fields: {
        id: { type: 'integer', required: true, sortable: true },
        nombres: { type: 'string', required: true, maxLength: 100, searchable: true },
        apellidos: { type: 'string', required: true, maxLength: 100, searchable: true },
        numerodocumento: { type: 'string', maxLength: 100, searchable: true },
        sexo: { type: 'enum', required: true, values: ['S', 'F', 'M'] },
        tdocumento_id: { type: 'integer', fk: { references: 'tdocumento.id', displayField: 'sigla' }, nullable: true },
        etnia_id: { type: 'integer', fk: { references: 'etnia.id', displayField: 'nombre' }, required: true },
        anionac: { type: 'integer', nullable: true },
        mesnac: { type: 'integer', nullable: true },
        dianac: { type: 'integer', nullable: true },
        created_at: { type: 'timestamp', hidden: true },
        updated_at: { type: 'timestamp', hidden: true }
    },
    relations: {
        tdocumento: { kind: 'belongsTo', target: 'tdocumento', fkField: 'tdocumento_id' },
        etnia: { kind: 'belongsTo', target: 'etnia', fkField: 'etnia_id' }
    },
    filters: [
        { name: 'nombres', operator: 'ilike', field: 'nombres' },
        { name: 'apellidos', operator: 'ilike', field: 'apellidos' },
        { name: 'sexo', operator: 'eq', field: 'sexo' },
        { name: 'tdocumento_id', operator: 'eq', field: 'tdocumento_id' },
        { name: 'etnia_id', operator: 'eq', field: 'etnia_id' }
    ],
    validations: [
        {
            name: 'fecha_coherente',
            run: r => {
                if (r.mesnac && (r.mesnac < 1 || r.mesnac > 12))
                    return 'validation.persona.month_out_of_range';
                if (r.dianac && (r.dianac < 1 || r.dianac > 31))
                    return 'validation.persona.day_out_of_range';
                return true;
            }
        }
    ],
    permissions: {
        read: ({ user }) => !!user,
        create: ({ user }) => esAdminLike(user) || tieneRol(user, 'OPERADOR'),
        update: ({ user }) => esAdminLike(user) || tieneRol(user, 'OPERADOR'),
        delete: ({ user }) => esAdminLike(user)
    },
    presentation: { label: (r) => `${r.nombres} ${r.apellidos}`.trim() }
};
registerEntity(personaEntity);
export default personaEntity;

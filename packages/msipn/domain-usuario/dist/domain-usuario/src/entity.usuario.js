import { esAdminLike, registerEntity } from '@pasosdejesus/msipn-core';
export const usuarioEntity = {
    name: 'usuario',
    table: 'usuario',
    primaryKey: 'id',
    // Labels resolved via keys entity.usuario.*
    labels: { singular: 'User', plural: 'Users' },
    fields: {
        id: { type: 'integer', required: true, sortable: true },
        nusuario: { type: 'string', required: true, maxLength: 100, searchable: true },
        email: { type: 'string', required: true, maxLength: 300, searchable: true },
        rol: { type: 'integer', required: true },
        persona_id: { type: 'integer', fk: { references: 'persona.id', displayField: 'apellidos' }, nullable: true },
        encrypted_password: { type: 'string', hidden: true, maxLength: 255 },
        fechacreacion: { type: 'timestamp', required: true },
        fechadeshabilitacion: { type: 'timestamp', nullable: true },
        created_at: { type: 'timestamp', hidden: true },
        updated_at: { type: 'timestamp', hidden: true }
    },
    relations: {
        persona: { kind: 'belongsTo', target: 'persona', fkField: 'persona_id' }
    },
    filters: [
        { name: 'nusuario', operator: 'ilike', field: 'nusuario' },
        { name: 'rol', operator: 'eq', field: 'rol' }
    ],
    validations: [
        { name: 'email_formato', run: r => /\S+@\S+\.\S+/.test(r.email) ? true : 'validation.usuario.email_invalid' }
    ],
    permissions: {
        read: ({ user }) => esAdminLike(user),
        create: ({ user }) => esAdminLike(user),
        update: ({ user, record }) => esAdminLike(user) || (user && user.id === record.id),
        delete: ({ user }) => esAdminLike(user)
    },
    presentation: { label: (r) => r.nusuario }
};
registerEntity(usuarioEntity);
export default usuarioEntity;

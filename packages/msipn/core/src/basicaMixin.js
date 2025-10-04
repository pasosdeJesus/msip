export const basicaMixin = (opts = {}) => {
    const { nombreMaxLength = 500, observacionesMaxLength = 5000, enforceNombreUnique = true } = opts;
    const fields = {
        nombre: {
            type: 'string', required: true, maxLength: nombreMaxLength,
            searchable: true, sortable: true
        },
        observaciones: {
            type: 'text', nullable: true, maxLength: observacionesMaxLength, searchable: true
        },
        fechacreacion: { type: 'timestamp', required: true },
        fechadeshabilitacion: { type: 'timestamp', nullable: true }
    };
    const validations = [
        {
            name: 'fechacreacion_reciente',
            run: r => {
                if (!r.fechacreacion)
                    return 'fechacreacion requerida';
                const year2000 = new Date(Date.UTC(2000, 0, 1));
                if (new Date(r.fechacreacion) < year2000) {
                    return 'fechacreacion debe ser posterior a 2000';
                }
                return true;
            }
        },
        {
            name: 'fechadeshabilitacion_posterior',
            run: r => {
                if (r.fechadeshabilitacion && r.fechacreacion &&
                    new Date(r.fechadeshabilitacion) < new Date(r.fechacreacion)) {
                    return 'fechadeshabilitacion debe ser posterior a fechacreacion';
                }
                return true;
            }
        },
        {
            name: 'nombre_no_vacio',
            run: r => (!r.nombre || r.nombre.trim() === '' ? 'nombre requerido' : true)
        },
        {
            name: 'nombre_unico_placeholder',
            run: () => true // TODO: validación uniqueness async
        }
    ];
    const filters = [
        { name: 'nombre', operator: 'ilike', field: 'nombre' },
        { name: 'observaciones', operator: 'ilike', field: 'observaciones' },
        { name: 'habilitado', operator: 'custom', customBuilderKey: 'habilitado' },
        { name: 'fechacreacionini', operator: 'custom', customBuilderKey: 'fechacreacionIni' },
        { name: 'fechacreacionfin', operator: 'custom', customBuilderKey: 'fechacreacionFin' }
    ];
    const hooks = {
        beforeValidate: (record) => {
            if (record.nombre) {
                record.nombre = record.nombre.toUpperCase().replace(/\s+/g, ' ').trim();
            }
        }
    };
    return { fields, validations, filters, hooks };
};

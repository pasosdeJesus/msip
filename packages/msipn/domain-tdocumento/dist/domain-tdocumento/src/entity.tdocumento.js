import { makeBasicaEntity } from '@pasosdejesus/msipn-core';
export const tdocumentoEntity = makeBasicaEntity({
    name: 'tdocumento',
    table: 'msip_tdocumento',
    labels: { singular: 'Tipo de Documento', plural: 'Tipos de Documento' },
    extraFields: {
        sigla: { type: 'string', required: true, maxLength: 100, searchable: true },
        formatoregex: { type: 'text', nullable: true, maxLength: 500 },
        ayuda: { type: 'text', nullable: true }
    },
    extraValidations: [
        { name: 'sigla_mayus', run: (r) => r.sigla && r.sigla !== r.sigla.toUpperCase() ? 'sigla debe estar en mayúsculas' : true }
    ]
});
export default tdocumentoEntity;

import { makeBasicaEntity } from '@pasosdejesus/msipn-core';
// tKey available if needed for runtime resolution, kept here as illustration for future dynamic label resolution
// import { tKey } from '@pasosdejesus/msipn-core';

export const tdocumentoEntity = makeBasicaEntity({
  name: 'tdocumento',
  table: 'msip_tdocumento',
  // Labels resolved via i18n at runtime (keys entity.tdocumento.*)
  labels: { 
    singular: 'Document Type', // fallback static (will be replaced by presentation layer using i18n key entity.tdocumento.singular)
    plural: 'Document Types'
  },
  extraFields: {
    sigla: { type: 'string', required: true, maxLength: 100, searchable: true },
    formatoregex: { type: 'text', nullable: true, maxLength: 500 },
    ayuda: { type: 'text', nullable: true } // help (legacy field name retained)
  },
  extraValidations: [
    { name: 'sigla_mayus', run: (r: any) => r.sigla && r.sigla !== r.sigla.toUpperCase() ? 'validation.tdocumento.sigla_upper' : true }
  ]
});

export default tdocumentoEntity;

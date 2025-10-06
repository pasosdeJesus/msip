import { makeBasicaEntity } from '@pasosdejesus/msipn-core';

export const etniaEntity = makeBasicaEntity({
  name: 'etnia',
  table: 'msip_etnia',
  // Internationalized labels resolved externally via keys entity.etnia.*
  labels: { singular: 'Ethnic Group', plural: 'Ethnic Groups' },
  extraFields: {
    descripcion: { type: 'text', nullable: true, maxLength: 1000 } // description (legacy field name kept)
  }
});

export default etniaEntity;

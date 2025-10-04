import { makeBasicaEntity } from '@pasosdejesus/msipn-core';

export const etniaEntity = makeBasicaEntity({
  name: 'etnia',
  table: 'msip_etnia',
  labels: { singular: 'Etnia', plural: 'Etnias' },
  extraFields: {
    descripcion: { type: 'text', nullable: true, maxLength: 1000 }
  }
});

export default etniaEntity;

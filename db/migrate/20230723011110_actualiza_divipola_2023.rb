# frozen_string_literal: true

class ActualizaDivipola2023 < ActiveRecord::Migration[7.0]
  def up
    res = execute("SELECT count(*) from msip_tclase")
    if res && res[0] && res[0]["count"] && res[0]["count"] == 0
      puts "Suponemos aplicando migraciones a base desactualiza"
      return
    end
    execute(<<-SQL)
      -- Municipios con nombre cambiado
      UPDATE msip_municipio SET nombre='TURBANA' WHERE id=1350;#{" "}
      UPDATE msip_municipio SET nombre='SANTIAGO DE CALI' WHERE id=28;

      -- 1 centro poblado cambia de nombre
      UPDATE msip_clase SET#{" "}
        nombre='Medellín, Distrito Especial de Ciencia, Tecnología e Innovación',
        observaciones='Se cambió el nombre en DIVIPOLA 2023-07, antes era Medellín'
        WHERE id=6479;

      -- 20 centros poblados que se deshabilitan
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='7554'; -- 5861010 VENTIADERO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='3093'; -- 20614003 EL SALOBRE
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5355'; -- 27491004 JUNTAS DE TAMANÁ
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='14561'; -- 27491017 QUEBRADA LARGA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5450'; -- 27745011 CHAMBACÚ
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5983'; -- 44378002 CERRO ALTO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5981'; -- 44378003 EL PARAÍSO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5976'; -- 44378006 GUAMACHITO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5980'; -- 44378008 LA GLORIA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='5975'; -- 44378009 LA LOMITA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='14619'; -- 44378010 LOMA MATO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='14620'; -- 44378011 MANANTIAL GRANDE
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='14621'; -- 44378012 YAGUARITO
      UPDATE msip_clase SET observaciones='No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='7875'; -- 50711019 BUENOS AIRES
      UPDATE msip_clase SET observaciones='  Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='8526'; -- 52520013 SAN PEDRO DEL VINO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='8787'; -- 52835015 LA CALETA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='9066'; -- 54001048 LOS NEGROS
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='14843'; -- 63594008 TROCADEROS
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='11417'; -- 73555005 RÍO CLARO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2023-07.',  fechadeshabilitacion='2023-07-21'   WHERE id='12258'; -- 76622001 CAJAMARCA

      -- 17 Centros poblados que ya existían vuelven a habilitarse
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=6609; --La Atoyosa / Arboletes / Antioquia
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=6607; --San José del Carmelo / Arboletes / Antioquia
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=6802; --Puerto Colombia / Caucasia / Antioquia
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=997; --El Moral / Chita / Boyacá
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=1329; --El Crucero / Sogamoso / Boyacá
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=1512; --Guayabal / Chinchiná / Caldas
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2023-07.' WHERE id=1622; --Santagueda / Palestina / Caldas
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Antes era CAS. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=3772; --Planetica / Planeta Rica / Córdoba
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=3796; --Pueblo Regao / Pueblo Nuevo / Córdoba
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12016; --Cajamarca / El Dovio / Valle del Cauca
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12887; --Piñuña Blanco / Puerto Asís / Putumayo
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12882; --Teteye / Puerto Asís / Putumayo
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12951; --La Esmeralda / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12948; --Loro Uno / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=12944; --San Andrés / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=13006; --Kilómetro 6 / Leticia / Amazonas
      UPDATE msip_clase SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IP. No está en DIVIPOLA 2022. Vuelve a habilitarse en DIVIPOLA 2023-07.' WHERE id=13165; --El Tuparro / Cumaribo / Vichada

      -- 54 centros poblados nuevos

      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45520, 'La Esmeralda', 766, 17, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Apartadó / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45521, 'Sal Si Puedes', 766, 18, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Apartadó / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45522, 'Nueva Esperanza', 196, 15, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Carepa / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45523, 'Puerto Astilla', 818, 6, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Nechí / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45524, 'Abreito', 1026, 48, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Rionegro / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45525, 'Calle Larga', 1069, 7, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- San Juan de Urabá / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45526, 'Montecristo', 1069, 8, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- San Juan de Urabá / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45527, 'El Cerrito', 1083, 14, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- San Pedro de Urabá / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45528, 'Carrizal', 1194, 8, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Segovia / Antioquia
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45529, 'Condominio Las Margaritas', 725, 25, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Anserma / Caldas
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45530, 'Las Palmas', 46, 41, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Popayán / Cauca
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45531, 'Territorio Nasa Kiwetk La María', 1152, 45, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Santander de Quilichao / Cauca
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45532, 'Territorio Nasa Kiwe Tekh Ksxaw', 1152, 46, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Santander de Quilichao / Cauca
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45533, 'Calle Barrida', 41, 59, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45534, 'Besito Volao', 41, 75, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45535, 'Corea', 41, 76, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45536, 'El Bicho', 41, 77, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45537, 'El Porvenir', 41, 78, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45538, 'Santa Fe', 41, 79, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Montería / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45539, 'El Líbano', 237, 34, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Cereté / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45540, 'Zapal', 237, 35, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Cereté / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45541, 'Pueblo Chiquito', 718, 43, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Lorica / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45542, 'Marimba', 930, 39, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Planeta Rica / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45543, 'Venecia', 944, 35, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Pueblo Nuevo / Córdoba
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45544, 'Chambacú', 769, 20, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Medio San Juan / Chocó
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45545, 'El Morro', 820, 14, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Nuquí / Chocó
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45546, 'Juntas De Tamaná', 1075, 16, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- San José del Palmar / Chocó
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45547, 'Monte Hermón', 49, 45, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Riohacha / La Guajira
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45548, 'El Centro', 986, 11, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45549, 'El Triunfo', 986, 12, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45550, 'La Esmeralda', 986, 13, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45551, 'La Fortuna', 986, 14, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45552, 'La Sardinata', 986, 15, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45553, 'Las Blancas', 986, 16, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45554, 'San Nicolás', 986, 17, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Acacías / Meta
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45555, 'San Martín', 886, 19, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Palmito / Sucre
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45556, 'La Primavera', 1056, 38, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Arauquita / Arauca
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45557, 'Santa Ana', 1056, 39, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Arauquita / Arauca
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45558, 'La Vega', 58, 14, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Yopal / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45559, 'Atalayas', 59, 16, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Aguazul / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45560, 'Caño Mochuelo', 141, 18, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Hato Corozal / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45561, 'Porvenir Sector La 40', 240, 9, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Monterrey / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45562, 'Aceite Alto', 713, 7, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Tauramena / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45563, 'Banquetas', 756, 5, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Villanueva / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45564, 'Loma Linda', 756, 6, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Villanueva / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45565, 'El Triunfo', 756, 7, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Villanueva / Casanare
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45566, 'La Reserva', 40, 21, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Mocoa / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45567, 'San José Del Pepino', 40, 22, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Mocoa / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45568, 'El Muelle', 940, 35, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Puerto Asís / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45569, 'Las Vegas', 942, 5, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Puerto Caicedo / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45570, 'La Ciudadela', 946, 15, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Puerto Guzmán / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45571, 'La Cabaña', 1222, 19, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- San Miguel / Putumayo
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45572, 'Sabanitas', 35, 15, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Inírida / Guainía
      INSERT INTO msip_clase (id, nombre, municipio_id, clalocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45573, 'Acaipi', 866, 1, 'Agregado en DIVIPOLA 2023-07.', '2023-07-22', '2023-07-22', '2023-07-22'); -- Pacoa / Vaupés

      -- Latitud y longitud para 130 centros poblados que no no tenían

      UPDATE msip_clase SET latitud='5.918737', longitud='-73.603889' WHERE id=1146; -- Los Cayenos / Moniquirá / Boyacá
      UPDATE msip_clase SET latitud='6.694226', longitud='-75.847818' WHERE id=6697; -- La Angelina / Buriticá / Antioquia
      UPDATE msip_clase SET latitud='6.910451', longitud='-75.916915' WHERE id=6699; -- Llanos de Urarco / Buriticá / Antioquia
      UPDATE msip_clase SET latitud='6.727579', longitud='-75.941921' WHERE id=6701; -- Guarco / Buriticá / Antioquia
      UPDATE msip_clase SET latitud='6.69307', longitud='-75.897525' WHERE id=6696; -- El Naranjo / Buriticá / Antioquia
      UPDATE msip_clase SET latitud='0.054936', longitud='-71.223208' WHERE id=13034; -- Pacoa / La Victoria / Amazonas
      UPDATE msip_clase SET latitud='1.052178', longitud='-75.034382' WHERE id=14265; -- Palmeras / La Montañita / Caquetá
      UPDATE msip_clase SET latitud='2.240078', longitud='-75.114375' WHERE id=1856; -- Santana Ramos / Puerto Rico / Caquetá
      UPDATE msip_clase SET latitud='2.507567', longitud='-77.064184' WHERE id=2247; -- Huisitó / El Tambo / Cauca
      UPDATE msip_clase SET latitud='1.018905', longitud='-76.144888' WHERE id=2541; -- Yapurá / Piamonte / Cauca
      UPDATE msip_clase SET latitud='1.02563', longitud='-76.207665' WHERE id=2540; -- El Remanso / Piamonte / Cauca
      UPDATE msip_clase SET latitud='3.210179', longitud='-70.12393' WHERE id=15306; -- Puerto Zancudo / Barrancominas / Guainía
      UPDATE msip_clase SET latitud='3.629', longitud='-69.06' WHERE id=13063; -- Arrecifal / Barrancominas / Guainía
      UPDATE msip_clase SET latitud='4.078902', longitud='-73.618561' WHERE id=7683; -- Condominio de Los Odontólogos / Villavicencio / Meta
      UPDATE msip_clase SET latitud='2.23513', longitud='-77.28065' WHERE id=2020; -- San Juan Guadua / Argelia / Cauca
      UPDATE msip_clase SET latitud='2.383201', longitud='-77.230959' WHERE id=2031; -- La Belleza / Argelia / Cauca
      UPDATE msip_clase SET latitud='2.678155', longitud='-75.753968' WHERE id=15409; -- San Miguel / Íquira / Huila
      UPDATE msip_clase SET latitud='10.639954', longitud='-73.085048' WHERE id=14630; -- Veracruz / San Juan del Cesar / La Guajira
      UPDATE msip_clase SET latitud='6.205708', longitud='-76.547062' WHERE id=7571; -- Vegaez / Vigía del Fuerte / Antioquia
      UPDATE msip_clase SET latitud='0.68446', longitud='-74.550011' WHERE id=1813; -- El Café / Cartagena del Chairá / Caquetá
      UPDATE msip_clase SET latitud='5.522034', longitud='-76.183342' WHERE id=5070; -- Pescadito / Bagadó / Chocó
      UPDATE msip_clase SET latitud='5.439951', longitud='-76.214975' WHERE id=5081; -- Vivícora / Bagadó / Chocó
      UPDATE msip_clase SET latitud='5.41825', longitud='-76.288421' WHERE id=5080; -- Piedra Honda / Bagadó / Chocó
      UPDATE msip_clase SET latitud='1.727', longitud='-69.869' WHERE id=13077; -- Venado Isana / Pana Pana / Guainía
      UPDATE msip_clase SET latitud='2.2186', longitud='-70.0318' WHERE id=13110; -- Morichal Viejo / El Retorno / Guaviare
      UPDATE msip_clase SET latitud='1.0966', longitud='-71.5821' WHERE id=13118; -- Puerto Santander / Miraflores / Guaviare
      UPDATE msip_clase SET latitud='1.266018', longitud='-77.48601' WHERE id=8649; -- San Francisco Alto / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.305017', longitud='-77.464831' WHERE id=8662; -- San Fernando / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.27989', longitud='-77.487599' WHERE id=8664; -- Chávez / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.29726', longitud='-77.469667' WHERE id=8658; -- Altamira Cruz de Arada / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.299464', longitud='-77.47352' WHERE id=8644; -- San Gabriel / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.314221', longitud='-77.459313' WHERE id=8667; -- Paraguay / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.279154', longitud='-77.49582' WHERE id=8666; -- Roma Chávez / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.309883', longitud='-77.480654' WHERE id=8668; -- San Bernardo / Sandoná / Nariño
      UPDATE msip_clase SET latitud='1.383903', longitud='-76.588031' WHERE id=12857; -- Yunguillo / Mocoa / Putumayo
      UPDATE msip_clase SET latitud='8.418294', longitud='-72.916899' WHERE id=9356; -- Luis Vero / Sardinata / Norte de Santander
      UPDATE msip_clase SET latitud='8.29947', longitud='-72.889031' WHERE id=9374; -- Las Mercedes / Sardinata / Norte de Santander
      UPDATE msip_clase SET latitud='0.974168', longitud='-75.976174' WHERE id=15418; -- Los Guaduales / Puerto Guzmán / Putumayo
      UPDATE msip_clase SET latitud='4.315705', longitud='-72.333418' WHERE id=15410; -- Pueblo Nuevo - Getsemaní / Puerto López / Meta
      UPDATE msip_clase SET latitud='3.161813', longitud='-76.511453' WHERE id=12083; -- La Ventura / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud='3.178697', longitud='-76.723739' WHERE id=12079; -- La Meseta / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud='3.141336', longitud='-76.689201' WHERE id=12087; -- La Liberia / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud='5.42899', longitud='-76.945102' WHERE id=5046; -- Puerto Córdoba Urudo / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.599495', longitud='-77.052225' WHERE id=5023; -- Puerto Alegre / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.878825', longitud='-77.095703' WHERE id=5043; -- Miacora / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.652091', longitud='-76.988731' WHERE id=5038; -- Amparraida (Santa Rita) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.785162', longitud='-77.1266' WHERE id=5051; -- Puesto Indio / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.721657', longitud='-77.037637' WHERE id=14515; -- Pavarandó (Pureza) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.383666', longitud='-77.075327' WHERE id=5047; -- La Loma / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.818694', longitud='-77.049821' WHERE id=5039; -- La Felicia / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.599853', longitud='-77.063985' WHERE id=5035; -- La Divisa / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.410801', longitud='-77.010089' WHERE id=5049; -- Geando / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.479228', longitud='-77.041142' WHERE id=5017; -- Dominico / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.49878', longitud='-77.066788' WHERE id=5036; -- El Salto (Bella Luz) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='5.635216', longitud='-77.001659' WHERE id=5048; -- Chigorodó / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud='6.365318', longitud='-75.698148' WHERE id=6475; -- Urquita / Medellín / Antioquia
      UPDATE msip_clase SET latitud='8.167951', longitud='-74.661115' WHERE id=601; -- San Agustín / Montecristo / Bolívar
      UPDATE msip_clase SET latitud='8.139486', longitud='-74.316975' WHERE id=604; -- Paraíso / Montecristo / Bolívar
      UPDATE msip_clase SET latitud='8.203563', longitud='-74.053136' WHERE id=653; -- El Corcovado / Morales / Bolívar
      UPDATE msip_clase SET latitud='8.46251', longitud='-74.16706' WHERE id=662; -- Mina Brisa / Norosí / Bolívar
      UPDATE msip_clase SET latitud='8.411709', longitud='-74.22451' WHERE id=663; -- Las Nieves / Norosí / Bolívar
      UPDATE msip_clase SET latitud='8.416266', longitud='-74.227572' WHERE id=659; -- Casa de Barro / Norosí / Bolívar
      UPDATE msip_clase SET latitud='8.545038', longitud='-74.097756' WHERE id=660; -- Buena Seña / Norosí / Bolívar
      UPDATE msip_clase SET latitud='9.120431', longitud='-74.36772' WHERE id=716; -- Las Cuevas / San Fernando / Bolívar
      UPDATE msip_clase SET latitud='9.026541', longitud='-74.381447' WHERE id=721; -- La Guadua / San Fernando / Bolívar
      UPDATE msip_clase SET latitud='9.045546', longitud='-74.296414' WHERE id=719; -- El Contadero / San Fernando / Bolívar
      UPDATE msip_clase SET latitud='2.584937', longitud='-76.005601' WHERE id=14326; -- Santa Rosa / Páez / Cauca
      UPDATE msip_clase SET latitud='10.560476', longitud='-73.586615' WHERE id=3082; -- Nabusimake / Pueblo Bello / Cesar
      UPDATE msip_clase SET latitud='10.459142', longitud='-73.577131' WHERE id=3081; -- La Caja / Pueblo Bello / Cesar
      UPDATE msip_clase SET latitud='5.905444', longitud='-76.536152' WHERE id=4983; -- El Fuerte / Quibdó / Chocó
      UPDATE msip_clase SET latitud='5.710516', longitud='-76.860696' WHERE id=4971; -- Campobonito / Quibdó / Chocó
      UPDATE msip_clase SET latitud='5.622499', longitud='-76.650406' WHERE id=4976; -- Boca de Tanandó / Quibdó / Chocó
      UPDATE msip_clase SET latitud='1.470909', longitud='-70.167881' WHERE id=15421; -- Tapurucuara / Mitú / Vaupés
      UPDATE msip_clase SET latitud='1.232055', longitud='-70.235454' WHERE id=15420; -- 12 de Octubre / Mitú / Vaupés
      UPDATE msip_clase SET latitud='1.264901', longitud='-70.235497' WHERE id=15419; -- Margen Izquierdo / Mitú / Vaupés
      UPDATE msip_clase SET latitud='0.615', longitud='-70.35' WHERE id=15203; -- Yapú / Mitú / Vaupés
      UPDATE msip_clase SET latitud='0.681', longitud='-70.251' WHERE id=13125; -- Acaricuara / Mitú / Vaupés
      UPDATE msip_clase SET latitud='9.026868', longitud='-74.19293' WHERE id=553; -- La Montaña / Margarita / Bolívar
      UPDATE msip_clase SET latitud='8.991176', longitud='-74.248562' WHERE id=538; -- Caño Mono / Margarita / Bolívar
      UPDATE msip_clase SET latitud='8.537058', longitud='-74.468236' WHERE id=312; -- Santa Lucía / Achí / Bolívar
      UPDATE msip_clase SET latitud='3.669258', longitud='-76.611373' WHERE id=12104; -- Jiguales / La Cumbre / Valle del Cauca
      UPDATE msip_clase SET latitud='3.713267', longitud='-76.629484' WHERE id=12105; -- La María / La Cumbre / Valle del Cauca
      UPDATE msip_clase SET latitud='4.300552', longitud='-76.365064' WHERE id=12351; -- Dos Quebradas / Trujillo / Valle del Cauca
      UPDATE msip_clase SET latitud='4.047', longitud='-67.716' WHERE id=13172; -- Amanavén / Cumaribo / Vichada
      UPDATE msip_clase SET latitud='6.725', longitud='-71.526' WHERE id=15100; -- Sitio Nuevo / Fortul / Arauca
      UPDATE msip_clase SET latitud='5.393609', longitud='-77.142062' WHERE id=15407; -- Tocasina - Dubasa / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='4.641095', longitud='-77.316971' WHERE id=5115; -- Puerto Abadía / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='5.156586', longitud='-77.368707' WHERE id=5109; -- Punta Purricha / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='5.307073', longitud='-77.076236' WHERE id=5116; -- Playita / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='4.685423', longitud='-77.311413' WHERE id=5093; -- Hijuá / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='4.6889', longitud='-77.211758' WHERE id=5092; -- Belén de Docampodo / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud='5.992606', longitud='-76.880484' WHERE id=5298; -- San Roque / Medio Atrato / Chocó
      UPDATE msip_clase SET latitud='1.496316', longitud='-75.899274' WHERE id=1800; -- San Antonio de Padua / Belén de Los Andaquíes / Caquetá
      UPDATE msip_clase SET latitud='1.566108', longitud='-75.866476' WHERE id=1802; -- Pueblo Nuevo Los Ángeles / Belén de Los Andaquíes / Caquetá
      UPDATE msip_clase SET latitud='9.084045', longitud='-73.535113' WHERE id=2974; -- Piedras Blancas / Chimichagua / Cesar
      UPDATE msip_clase SET latitud='7.149901', longitud='-76.630974' WHERE id=5147; -- Puerto Lleras / Carmen del Darién / Chocó
      UPDATE msip_clase SET latitud='6.705775', longitud='-77.489446' WHERE id=15408; -- Cupica / Juradó / Chocó
      UPDATE msip_clase SET latitud='4.193328', longitud='-77.332062' WHERE id=5211; -- Burujón / El Litoral del San Juan / Chocó
      UPDATE msip_clase SET latitud='9.258938', longitud='-75.556524' WHERE id=14453; -- San Martin / Tuchín / Córdoba
      UPDATE msip_clase SET latitud='9.261228', longitud='-75.561712' WHERE id=14452; -- La Granja / Tuchín / Córdoba
      UPDATE msip_clase SET latitud='9.263821', longitud='-75.574683' WHERE id=14451; -- El Barzal / Tuchín / Córdoba
      UPDATE msip_clase SET latitud='4.390694', longitud='-74.765842' WHERE id=4462; -- Berlín / Girardot / Cundinamarca
      UPDATE msip_clase SET latitud='4.522992', longitud='-73.255621' WHERE id=4590; -- Mesa de Los Reyes / Medina / Cundinamarca
      UPDATE msip_clase SET latitud='0.889603', longitud='-77.723737' WHERE id=8117; -- Macas / Cuaspud Carlosama / Nariño
      UPDATE msip_clase SET latitud='2.24645', longitud='-78.451425' WHERE id=8493; -- Pueblo Nuevo / Mosquera / Nariño
      UPDATE msip_clase SET latitud='7.32254', longitud='-73.88327' WHERE id=15417; -- Invasión La Independencia / Puerto Wilches / Santander
      UPDATE msip_clase SET latitud='1.676326', longitud='-78.594759' WHERE id=8930; -- Barro Colorado / San Andrés de Tumaco / Nariño
      UPDATE msip_clase SET latitud='8.72877', longitud='-76.57286' WHERE id=15404; -- Balsilla / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud='1.841861', longitud='-74.393236' WHERE id=15406; -- Villa Carmona / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud='1.793014', longitud='-74.159702' WHERE id=1877; -- La Tunia / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud='2.124033', longitud='-74.556862' WHERE id=1872; -- Los Pozos / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud='8.405119', longitud='-74.38826' WHERE id=828; -- Quebrada del Medio / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud='8.357305', longitud='-74.338781' WHERE id=825; -- Dos Bocas / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud='8.562066', longitud='-74.345289' WHERE id=829; -- Bocas de Solis / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud='6.500334', longitud='-73.238026' WHERE id=10523; -- Berlín / Socorro / Santander
      UPDATE msip_clase SET latitud='-0.539366', longitud='-72.977717' WHERE id=1905; -- Cuemani / Solano / Caquetá
      UPDATE msip_clase SET latitud='6.254', longitud='-71.109' WHERE id=12740; -- Puerto Colombia / Hato Corozal / Casanare
      UPDATE msip_clase SET latitud='2.038537', longitud='-77.27709' WHERE id=2037; -- Pureto / Balboa / Cauca
      UPDATE msip_clase SET latitud='9.328479', longitud='-75.781387' WHERE id=3949; -- El Naranjo / San Antero / Córdoba
      UPDATE msip_clase SET latitud='4.641432', longitud='-74.30648' WHERE id=4241; -- Santa Bárbara / Bojacá / Cundinamarca
      UPDATE msip_clase SET latitud='0.752602', longitud='-77.615547' WHERE id=8546; -- Cárdenas / Potosí / Nariño
      UPDATE msip_clase SET latitud='6.739537', longitud='-73.87807' WHERE id=10514; -- La Rochela / Simacota / Santander
      UPDATE msip_clase SET latitud='2.282212', longitud='-77.040755' WHERE id=2534; -- Don Alonso / Patía / Cauca
      UPDATE msip_clase SET latitud='4.530038', longitud='-74.47415' WHERE id=4215; -- La Paz / Anapoima / Cundinamarca
      UPDATE msip_clase SET latitud='1.895108', longitud='-78.588433' WHERE id=15416; -- Soledad Curay Ii / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud='1.897404', longitud='-78.584797' WHERE id=15415; -- Soledad Curay I / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud='1.89893', longitud='-78.580744' WHERE id=15414; -- Sander Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud='1.901432', longitud='-78.571308' WHERE id=15413; -- Olivo Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud='1.900386', longitud='-78.55429' WHERE id=8518; -- Bocas de Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud='3.412223', longitud='-75.784688' WHERE id=11468; -- Maracaibo / Rioblanco / Tolima

     -- Latitud y longitud a nuevos

      UPDATE msip_clase SET latitud='8.588888', longitud='-76.393931' WHERE id=6607; -- San José del Carmelo / Arboletes / Antioquia
      UPDATE msip_clase SET latitud='8.673426', longitud='-76.423435' WHERE id=6609; -- La Atoyosa / Arboletes / Antioquia
      UPDATE msip_clase SET latitud='11.241774', longitud='-72.901614' WHERE id=45547; -- Monte Hermón / Riohacha / La Guajira
      UPDATE msip_clase SET latitud='-4.162832', longitud='-69.937594' WHERE id=13006; -- Kilómetro 6 / Leticia / Amazonas
      UPDATE msip_clase SET latitud='6.886878', longitud='-71.431553' WHERE id=45557; -- Santa Ana / Arauquita / Arauca
      UPDATE msip_clase SET latitud='6.875505', longitud='-71.667443' WHERE id=45556; -- La Primavera / Arauquita / Arauca
      UPDATE msip_clase SET latitud='3.880049', longitud='-67.881211' WHERE id=45572; -- Sabanitas / Inírida / Guainía
      UPDATE msip_clase SET latitud='1.097047', longitud='-76.63169' WHERE id=45567; -- San José Del Pepino / Mocoa / Putumayo
      UPDATE msip_clase SET latitud='1.178446', longitud='-76.648615' WHERE id=45566; -- La Reserva / Mocoa / Putumayo
      UPDATE msip_clase SET latitud='0.473506', longitud='-76.4767' WHERE id=45568; -- El Muelle / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud='0.254017', longitud='-76.552345' WHERE id=12882; -- Teteye / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud='0.446681', longitud='-76.185309' WHERE id=12887; -- Piñuña Blanco / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud='0.727528', longitud='-76.698316' WHERE id=45569; -- Las Vegas / Puerto Caicedo / Putumayo
      UPDATE msip_clase SET latitud='0.953938', longitud='-76.416584' WHERE id=45570; -- La Ciudadela / Puerto Guzmán / Putumayo
      UPDATE msip_clase SET latitud='0.319554', longitud='-76.999467' WHERE id=45571; -- La Cabaña / San Miguel / Putumayo
      UPDATE msip_clase SET latitud='0.378194', longitud='-76.973771' WHERE id=12944; -- San Andrés / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud='0.380565', longitud='-76.899799' WHERE id=12948; -- Loro Uno / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud='0.440221', longitud='-76.993295' WHERE id=12951; -- La Esmeralda / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud='7.845022', longitud='-76.756001' WHERE id=45522; -- Nueva Esperanza / Carepa / Antioquia
      UPDATE msip_clase SET latitud='7.578983', longitud='-75.013827' WHERE id=6802; -- Puerto Colombia / Caucasia / Antioquia
      UPDATE msip_clase SET latitud='3.965155', longitud='-73.740632' WHERE id=45554; -- San Nicolás / Acacías / Meta
      UPDATE msip_clase SET latitud='4.005367', longitud='-73.784629' WHERE id=45553; -- Las Blancas / Acacías / Meta
      UPDATE msip_clase SET latitud='4.004533', longitud='-73.744568' WHERE id=45552; -- La Sardinata / Acacías / Meta
      UPDATE msip_clase SET latitud='3.958732', longitud='-73.764743' WHERE id=45551; -- La Fortuna / Acacías / Meta
      UPDATE msip_clase SET latitud='3.969119', longitud='-73.747517' WHERE id=45550; -- La Esmeralda / Acacías / Meta
      UPDATE msip_clase SET latitud='3.964769', longitud='-73.739298' WHERE id=45549; -- El Triunfo / Acacías / Meta
      UPDATE msip_clase SET latitud='3.963701', longitud='-73.765052' WHERE id=45548; -- El Centro / Acacías / Meta
      UPDATE msip_clase SET latitud='6.164571', longitud='-75.411036' WHERE id=45524; -- Abreito / Rionegro / Antioquia
      UPDATE msip_clase SET latitud='8.454489', longitud='-76.387752' WHERE id=45527; -- El Cerrito / San Pedro de Urabá / Antioquia
      UPDATE msip_clase SET latitud='7.244515', longitud='-74.46654' WHERE id=45528; -- Carrizal / Segovia / Antioquia
      UPDATE msip_clase SET latitud='7.864513', longitud='-76.601415' WHERE id=45521; -- Sal Si Puedes / Apartadó / Antioquia
      UPDATE msip_clase SET latitud='7.79286', longitud='-76.653995' WHERE id=45520; -- La Esmeralda / Apartadó / Antioquia
      UPDATE msip_clase SET latitud='5.607049', longitud='-77.291003' WHERE id=45545; -- El Morro / Nuquí / Chocó
      UPDATE msip_clase SET latitud='8.929239', longitud='-75.765409' WHERE id=45540; -- Zapal / Cereté / Córdoba
      UPDATE msip_clase SET latitud='8.912681', longitud='-75.78557' WHERE id=45539; -- El Líbano / Cereté / Córdoba
      UPDATE msip_clase SET latitud='-0.001818', longitud='-70.510656' WHERE id=45573; -- Acaipi / Pacoa / Vaupés
      UPDATE msip_clase SET latitud='4.480127', longitud='-76.214614' WHERE id=12016; -- Cajamarca / El Dovio / Valle del Cauca
      UPDATE msip_clase SET latitud='4.887093', longitud='-69.062984' WHERE id=13165; -- El Tuparro / Cumaribo / Vichada
      UPDATE msip_clase SET latitud='3.012973', longitud='-76.503218' WHERE id=45532; -- Territorio Nasa Kiwe Tekh Ksxaw / Santander de Quilichao / Cauca
      UPDATE msip_clase SET latitud='3.006821', longitud='-76.466309' WHERE id=45531; -- Territorio Nasa Kiwetk La María / Santander de Quilichao / Cauca
      UPDATE msip_clase SET latitud='4.95935', longitud='-75.611465' WHERE id=1512; -- Guayabal / Chinchiná / Caldas
      UPDATE msip_clase SET latitud='2.419563', longitud='-76.61802' WHERE id=45530; -- Las Palmas / Popayán / Cauca
      UPDATE msip_clase SET latitud='9.30459', longitud='-75.897104' WHERE id=45541; -- Pueblo Chiquito / Lorica / Córdoba
      UPDATE msip_clase SET latitud='7.942376', longitud='-74.829123' WHERE id=45523; -- Puerto Astilla / Nechí / Antioquia
      UPDATE msip_clase SET latitud='8.747636', longitud='-76.513188' WHERE id=45526; -- Montecristo / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud='8.699013', longitud='-76.49122' WHERE id=45525; -- Calle Larga / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud='5.08507', longitud='-75.683731' WHERE id=1622; -- Santagueda / Palestina / Caldas
      UPDATE msip_clase SET latitud='6.114949', longitud='-72.519092' WHERE id=997; -- El Moral / Chita / Boyacá
      UPDATE msip_clase SET latitud='5.121933', longitud='-75.715614' WHERE id=45529; -- Condominio Las Margaritas / Anserma / Caldas
      UPDATE msip_clase SET latitud='9.286273', longitud='-75.547244' WHERE id=45555; -- San Martín / Palmito / Sucre
      UPDATE msip_clase SET latitud='5.122724', longitud='-72.578513' WHERE id=45559; -- Atalayas / Aguazul / Casanare
      UPDATE msip_clase SET latitud='6.154958', longitud='-70.058097' WHERE id=45560; -- Caño Mochuelo / Hato Corozal / Casanare
      UPDATE msip_clase SET latitud='5.005487', longitud='-72.732455' WHERE id=45562; -- Aceite Alto / Tauramena / Casanare
      UPDATE msip_clase SET latitud='4.631985', longitud='-72.944267' WHERE id=45565; -- El Triunfo / Villanueva / Casanare
      UPDATE msip_clase SET latitud='4.62861', longitud='-72.955092' WHERE id=45564; -- Loma Linda / Villanueva / Casanare
      UPDATE msip_clase SET latitud='4.658549', longitud='-72.940344' WHERE id=45563; -- Banquetas / Villanueva / Casanare
      UPDATE msip_clase SET latitud='5.389568', longitud='-72.425721' WHERE id=45558; -- La Vega / Yopal / Casanare
      UPDATE msip_clase SET latitud='5.618599', longitud='-72.906684' WHERE id=1329; -- El Crucero / Sogamoso / Boyacá
      UPDATE msip_clase SET latitud='4.926908', longitud='-72.931283' WHERE id=45561; -- Porvenir Sector La 40 / Monterrey / Casanare
      UPDATE msip_clase SET latitud='8.533062', longitud='-75.901218' WHERE id=45538; -- Santa Fe / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.424457', longitud='-75.781459' WHERE id=45537; -- El Porvenir / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.389077', longitud='-75.949701' WHERE id=45536; -- El Bicho / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.481295', longitud='-75.90716' WHERE id=45535; -- Corea / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.7554', longitud='-75.817659' WHERE id=45534; -- Besito Volao / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.541578', longitud='-75.799629' WHERE id=45533; -- Calle Barrida / Montería / Córdoba
      UPDATE msip_clase SET latitud='8.139956', longitud='-75.62128' WHERE id=45542; -- Marimba / Planeta Rica / Córdoba
      UPDATE msip_clase SET latitud='8.399406', longitud='-75.604362' WHERE id=3772; -- Planetica / Planeta Rica / Córdoba
      UPDATE msip_clase SET latitud='8.506252', longitud='-75.530147' WHERE id=45543; -- Venecia / Pueblo Nuevo / Córdoba
      UPDATE msip_clase SET latitud='8.569078', longitud='-75.634582' WHERE id=3796; -- Pueblo Regao / Pueblo Nuevo / Córdoba
    SQL
  end

  def down
    execute(<<-SQL)
     -- 2 municipios cambian de nombre
      UPDATE msip_municipio SET nombre='TURBANÁ' WHERE id=1350;
      UPDATE msip_municipio SET nombre='CALI' WHERE id=28;

      -- 1 centro poblado cambia de nombre
      UPDATE msip_clase SET#{" "}
        nombre='Medellín',
        observaciones=''
        WHERE id=6479;

      -- 20 centros poblados deshabilitados
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='7554'; -- 5861010 VENTIADERO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C',  fechadeshabilitacion=NULL   WHERE id='3093'; -- 20614003 EL SALOBRE
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C',  fechadeshabilitacion=NULL   WHERE id='5355'; -- 27491004 JUNTAS DE TAMANÁ
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='14561'; -- 27491017 QUEBRADA LARGA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='5450'; -- 27745011 CHAMBACÚ
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='5983'; -- 44378002 CERRO ALTO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='5981'; -- 44378003 EL PARAÍSO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='5976'; -- 44378006 GUAMACHITO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS',  fechadeshabilitacion=NULL   WHERE id='5980'; -- 44378008 LA GLORIA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='5975'; -- 44378009 LA LOMITA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14619'; -- 44378010 LOMA MATO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14620'; -- 44378011 MANANTIAL GRANDE
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14621'; -- 44378012 YAGUARITO
      UPDATE msip_clase SET observaciones='No está en DIVIPOLA 2023-07.',  fechadeshabilitacion=NULL   WHERE id='7875'; -- 50711019 BUENOS AIRES
      UPDATE msip_clase SET observaciones='  Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='8526'; -- 52520013 SAN PEDRO DEL VINO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='8787'; -- 52835015 LA CALETA
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='9066'; -- 54001048 LOS NEGROS
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14843'; -- 63594008 TROCADEROS
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='11417'; -- 73555005 RÍO CLARO
      UPDATE msip_clase SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='12258'; -- 76622001 CAJAMARCA


      -- 17 Centros poblados que ya existían vuelven a habilitarse
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.' WHERE id=6609; --La Atoyosa / Arboletes / Antioquia 5051017
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.' WHERE id=6607; --San José del Carmelo / Arboletes / Antioquia 5051019
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=6802; --Puerto Colombia / Caucasia / Antioquia 5154007
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.' WHERE id=997; --El Moral / Chita / Boyacá 15183002
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=1329; --El Crucero / Sogamoso / Boyacá 15759005
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=1512; --Guayabal / Chinchiná / Caldas 17174013
      UPDATE msip_clase SET fechadeshabilitacion='2013-01-04', observaciones='' WHERE id=1622; --Santagueda / Palestina / Caldas 17524006
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=3772; --Planetica / Planeta Rica / Córdoba 23555022
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=3796; --Pueblo Regao / Pueblo Nuevo / Córdoba 23570021
      UPDATE msip_clase SET fechadeshabilitacion='2013-01-04', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=12016; --Cajamarca / El Dovio / Valle del Cauca 76250016
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=12887; --Piñuña Blanco / Puerto Asís / Putumayo 86568006
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=12882; --Teteye / Puerto Asís / Putumayo 86568021
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=12951; --La Esmeralda / Valle del Guamuez / Putumayo 86865015
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=12948; --Loro Uno / Valle del Guamuez / Putumayo 86865016
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=12944; --San Andrés / Valle del Guamuez / Putumayo 86865019
      UPDATE msip_clase SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.' WHERE id=13006; --Kilómetro 6 / Leticia / Amazonas 91001014
      UPDATE msip_clase SET fechadeshabilitacion='2022-07-21', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IP. No está en DIVIPOLA 2022.' WHERE id=13165; --El Tuparro / Cumaribo / Vichada 99773021

      -- 54 centros poblados nuevos
      DELETE FROM msip_clase WHERE id>='45520' and id<='45573';

      -- latitud y longitud de 130 centros poblados
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1146; -- Los Cayenos / Moniquirá / Boyacá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6697; -- La Angelina / Buriticá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6699; -- Llanos de Urarco / Buriticá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6701; -- Guarco / Buriticá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6696; -- El Naranjo / Buriticá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13034; -- Pacoa / La Victoria / Amazonas
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14265; -- Palmeras / La Montañita / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1856; -- Santana Ramos / Puerto Rico / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2247; -- Huisitó / El Tambo / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2541; -- Yapurá / Piamonte / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2540; -- El Remanso / Piamonte / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15306; -- Puerto Zancudo / Barrancominas / Guainía
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13063; -- Arrecifal / Barrancominas / Guainía
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=7683; -- Condominio de Los Odontólogos / Villavicencio / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2020; -- San Juan Guadua / Argelia / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2031; -- La Belleza / Argelia / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15409; -- San Miguel / Íquira / Huila
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14630; -- Veracruz / San Juan del Cesar / La Guajira
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=7571; -- Vegaez / Vigía del Fuerte / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1813; -- El Café / Cartagena del Chairá / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5070; -- Pescadito / Bagadó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5081; -- Vivícora / Bagadó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5080; -- Piedra Honda / Bagadó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13077; -- Venado Isana / Pana Pana / Guainía
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13110; -- Morichal Viejo / El Retorno / Guaviare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13118; -- Puerto Santander / Miraflores / Guaviare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8649; -- San Francisco Alto / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8662; -- San Fernando / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8664; -- Chávez / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8658; -- Altamira Cruz de Arada / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8644; -- San Gabriel / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8667; -- Paraguay / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8666; -- Roma Chávez / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8668; -- San Bernardo / Sandoná / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12857; -- Yunguillo / Mocoa / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=9356; -- Luis Vero / Sardinata / Norte de Santander
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=9374; -- Las Mercedes / Sardinata / Norte de Santander
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15418; -- Los Guaduales / Puerto Guzmán / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15410; -- Pueblo Nuevo - Getsemaní / Puerto López / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12083; -- La Ventura / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12079; -- La Meseta / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12087; -- La Liberia / Jamundí / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5046; -- Puerto Córdoba Urudo / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5023; -- Puerto Alegre / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5043; -- Miacora / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5038; -- Amparraida (Santa Rita) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5051; -- Puesto Indio / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14515; -- Pavarandó (Pureza) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5047; -- La Loma / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5039; -- La Felicia / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5035; -- La Divisa / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5049; -- Geando / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5017; -- Dominico / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5036; -- El Salto (Bella Luz) / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5048; -- Chigorodó / Alto Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6475; -- Urquita / Medellín / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=601; -- San Agustín / Montecristo / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=604; -- Paraíso / Montecristo / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=653; -- El Corcovado / Morales / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=662; -- Mina Brisa / Norosí / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=663; -- Las Nieves / Norosí / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=659; -- Casa de Barro / Norosí / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=660; -- Buena Seña / Norosí / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=716; -- Las Cuevas / San Fernando / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=721; -- La Guadua / San Fernando / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=719; -- El Contadero / San Fernando / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14326; -- Santa Rosa / Páez / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=3082; -- Nabusimake / Pueblo Bello / Cesar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=3081; -- La Caja / Pueblo Bello / Cesar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4983; -- El Fuerte / Quibdó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4971; -- Campobonito / Quibdó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4976; -- Boca de Tanandó / Quibdó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15421; -- Tapurucuara / Mitú / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15420; -- 12 de Octubre / Mitú / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15419; -- Margen Izquierdo / Mitú / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15203; -- Yapú / Mitú / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13125; -- Acaricuara / Mitú / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=553; -- La Montaña / Margarita / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=538; -- Caño Mono / Margarita / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=312; -- Santa Lucía / Achí / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12104; -- Jiguales / La Cumbre / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12105; -- La María / La Cumbre / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12351; -- Dos Quebradas / Trujillo / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13172; -- Amanavén / Cumaribo / Vichada
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15100; -- Sitio Nuevo / Fortul / Arauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15407; -- Tocasina - Dubasa / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5115; -- Puerto Abadía / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5109; -- Punta Purricha / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5116; -- Playita / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5093; -- Hijuá / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5092; -- Belén de Docampodo / Bajo Baudó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5298; -- San Roque / Medio Atrato / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1800; -- San Antonio de Padua / Belén de Los Andaquíes / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1802; -- Pueblo Nuevo Los Ángeles / Belén de Los Andaquíes / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2974; -- Piedras Blancas / Chimichagua / Cesar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5147; -- Puerto Lleras / Carmen del Darién / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15408; -- Cupica / Juradó / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=5211; -- Burujón / El Litoral del San Juan / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14453; -- San Martin / Tuchín / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14452; -- La Granja / Tuchín / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=14451; -- El Barzal / Tuchín / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4462; -- Berlín / Girardot / Cundinamarca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4590; -- Mesa de Los Reyes / Medina / Cundinamarca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8117; -- Macas / Cuaspud Carlosama / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8493; -- Pueblo Nuevo / Mosquera / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15417; -- Invasión La Independencia / Puerto Wilches / Santander
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8930; -- Barro Colorado / San Andrés de Tumaco / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15404; -- Balsilla / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15406; -- Villa Carmona / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1877; -- La Tunia / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1872; -- Los Pozos / San Vicente del Caguán / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=828; -- Quebrada del Medio / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=825; -- Dos Bocas / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=829; -- Bocas de Solis / Tiquisio / Bolívar
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=10523; -- Berlín / Socorro / Santander
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1905; -- Cuemani / Solano / Caquetá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12740; -- Puerto Colombia / Hato Corozal / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2037; -- Pureto / Balboa / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=3949; -- El Naranjo / San Antero / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4241; -- Santa Bárbara / Bojacá / Cundinamarca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8546; -- Cárdenas / Potosí / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=10514; -- La Rochela / Simacota / Santander
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=2534; -- Don Alonso / Patía / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=4215; -- La Paz / Anapoima / Cundinamarca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15416; -- Soledad Curay Ii / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15415; -- Soledad Curay I / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15414; -- Sander Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=15413; -- Olivo Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=8518; -- Bocas de Curay / Francisco Pizarro / Nariño
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=11468; -- Maracaibo / Rioblanco / Tolima

      -- Latitud y longitud a nuevos

      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6607; -- San José del Carmelo / Arboletes / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6609; -- La Atoyosa / Arboletes / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45547; -- Monte Hermón / Riohacha / La Guajira
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13006; -- Kilómetro 6 / Leticia / Amazonas
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45557; -- Santa Ana / Arauquita / Arauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45556; -- La Primavera / Arauquita / Arauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45572; -- Sabanitas / Inírida / Guainía
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45567; -- San José Del Pepino / Mocoa / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45566; -- La Reserva / Mocoa / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45568; -- El Muelle / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12882; -- Teteye / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12887; -- Piñuña Blanco / Puerto Asís / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45569; -- Las Vegas / Puerto Caicedo / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45570; -- La Ciudadela / Puerto Guzmán / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45571; -- La Cabaña / San Miguel / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12944; -- San Andrés / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12948; -- Loro Uno / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12951; -- La Esmeralda / Valle del Guamuez / Putumayo
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45522; -- Nueva Esperanza / Carepa / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=6802; -- Puerto Colombia / Caucasia / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45554; -- San Nicolás / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45553; -- Las Blancas / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45552; -- La Sardinata / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45551; -- La Fortuna / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45550; -- La Esmeralda / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45549; -- El Triunfo / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45548; -- El Centro / Acacías / Meta
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45524; -- Abreito / Rionegro / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45527; -- El Cerrito / San Pedro de Urabá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45528; -- Carrizal / Segovia / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45521; -- Sal Si Puedes / Apartadó / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45520; -- La Esmeralda / Apartadó / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45545; -- El Morro / Nuquí / Chocó
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45540; -- Zapal / Cereté / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45539; -- El Líbano / Cereté / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45573; -- Acaipi / Pacoa / Vaupés
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=12016; -- Cajamarca / El Dovio / Valle del Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=13165; -- El Tuparro / Cumaribo / Vichada
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45532; -- Territorio Nasa Kiwe Tekh Ksxaw / Santander de Quilichao / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45531; -- Territorio Nasa Kiwetk La María / Santander de Quilichao / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1512; -- Guayabal / Chinchiná / Caldas
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45530; -- Las Palmas / Popayán / Cauca
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45541; -- Pueblo Chiquito / Lorica / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45523; -- Puerto Astilla / Nechí / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45526; -- Montecristo / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45525; -- Calle Larga / San Juan de Urabá / Antioquia
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1622; -- Santagueda / Palestina / Caldas
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=997; -- El Moral / Chita / Boyacá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45529; -- Condominio Las Margaritas / Anserma / Caldas
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45555; -- San Martín / Palmito / Sucre
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45559; -- Atalayas / Aguazul / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45560; -- Caño Mochuelo / Hato Corozal / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45562; -- Aceite Alto / Tauramena / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45565; -- El Triunfo / Villanueva / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45564; -- Loma Linda / Villanueva / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45563; -- Banquetas / Villanueva / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45558; -- La Vega / Yopal / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=1329; -- El Crucero / Sogamoso / Boyacá
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45561; -- Porvenir Sector La 40 / Monterrey / Casanare
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45538; -- Santa Fe / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45537; -- El Porvenir / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45536; -- El Bicho / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45535; -- Corea / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45534; -- Besito Volao / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45533; -- Calle Barrida / Montería / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45542; -- Marimba / Planeta Rica / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=3772; -- Planetica / Planeta Rica / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=45543; -- Venecia / Pueblo Nuevo / Córdoba
      UPDATE msip_clase SET latitud=NULL, longitud=NULL WHERE id=3796; -- Pueblo Regao / Pueblo Nuevo / Córdoba
    SQL
  end
end

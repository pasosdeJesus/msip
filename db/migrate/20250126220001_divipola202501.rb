class Divipola202501 < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      -- Municipios nuevos: 1
      INSERT INTO public.msip_municipio (id, nombre, departamento_id,
        munlocal_cod, latitud, longitud, fechacreacion, fechadeshabilitacion,
        created_at, updated_at, observaciones) VALUES 
          (1799, 'Nuevo Belén de Bajirá', 29,
          493, 7.3719, -76.71727,  '2025-01-26', NULL,
          '2025-01-26', '2025-01-26', '');

      -- Municipios con nombre cambiado: 2
      UPDATE public.msip_municipio SET nombre='Turbaná' WHERE id=1350;
      UPDATE public.msip_municipio SET nombre='Sotará - Paispamba' WHERE id=1230;
      -- Muncipios con latitud, longitud cambiada: 3
      UPDATE public.msip_municipio SET latitud=5.879827, longitud=-71.890348 WHERE id=443; --CASANARE/PAZ DE ARIPORO
      UPDATE public.msip_municipio SET latitud=3.701899, longitud=-73.695812 WHERE id=1139; --META / SAN MARTÍN
      UPDATE public.msip_municipio SET latitud=0.699077, longitud=-75.253702 WHERE id=1220; -- CAQUETÁ / SOLANO

      -- Centros poblados que se deshabilitan: 17
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='6732'; -- 5134001 LA CHIQUITA
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2018. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14092'; -- 5585010 EL PRODIGIO
      UPDATE msip_centropoblado SET observaciones=' No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='1346'; -- 15790002 LA CHAPA
      UPDATE msip_centropoblado SET observaciones='  Nombre cambiado por DIVIPOLA 2018. Antes era KILÓMETRO 28. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='1907'; -- 18785001 KILÓMETRO 28 (LA ARGELIA)
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='4886'; -- 25873001 SOATAMA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='5405'; -- 27615023 BELÉN DE BAJIRÁ
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14571'; -- 27615033 BLANQUISET
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2019. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='15302'; -- 27615037 MACONDO
      UPDATE msip_centropoblado SET observaciones=' No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='5418'; -- 27615038 NUEVO ORIENTE
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='5419'; -- 27615039 PLAYA ROJA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14572'; -- 27615045 7 DE AGOSTO
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14573'; -- 27615046 LA PUNTA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14574'; -- 27615047 SANTA MARIA
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2018. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14575'; -- 27615048 BRISAS
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14709'; -- 50683010 CAMPO ALEGRE
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='8904'; -- 52835101 LA BARCA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2025-01.',  fechadeshabilitacion='2025-01-26'   WHERE id='14938'; -- 70124019 PUEBLO NUEVO

      -- Centros poblados que se vuelven a habilitar con mismo nombre: 
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2021. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=7310; --El Prodigio / San Luis / Antioquia
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2144; --Andalucía / Caldono / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2181; --El Credo / Caloto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones=' Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2219; --Los Andes / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2228; --El Pedregal / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2226; --La Laguna / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2336; --Santa Teresa / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2337; --Guanacas / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2326; --San Miguel / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2328; --Segovia / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2437; --Caraqueño / Miranda / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2436; --Monterredondo / Miranda / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2445; --San Roque / Morales / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2497; --Chinas / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2477; --Lame / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2493; --Mosoco / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2471; --El Cabuyo / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2488; --La Ceja / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2503; --Taravira / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2487; --Chachucue / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2546; --Santa Helena / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2553; --El Carmen / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2545; --Loma Corta / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2547; --San Miguel / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2600; --Marmato / San Sebastián / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2657; --Puente Real / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2753; --La Cruz / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2756; --La Despensa / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2755; --Natala / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2754; --Santo Domingo / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=2751; --El Tablazo / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5074; --Aguasal / Bagadó / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2022. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5195; --Papayo / El Litoral del San Juan / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5293; --Guaitadó / Lloró / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5474; --Bochoromá / Tadó / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5983; --Cerro Alto / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5976; --Guamachito / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=5980; --La Gloria / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era IPD. No está en DIVIPOLA 2021. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=7862; --Campo Alegre / Vistahermosa / Meta
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=10154; --Barbosa / Girón / Santander
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=12860; --San Juan Vides / Orito / Putumayo
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Aparece en DIVIPOLA 2018. Nombre de DIVIPOLA 2019, el anterior era MINITAS. No está en DIVIPOLA 2022. Vuelve a aparecer en DIVIPOLA 2025-01.' WHERE id=15176; --Minitas / Barrancominas / Guainía

      -- Se vuelven a habilitar con nombre diferente

      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Barro Blanco".', nombre='Barroblanco' WHERE id=6749; --Barroblanco / Caramanta / Antioquia
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Humos".', nombre='Hato Humus' WHERE id=2002; --Hato Humus / Almaguer / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones=' Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Cimarrones".', nombre='Cimarronas' WHERE id=2068; --Cimarronas / Bolívar / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Tierrero".', nombre='El Tierrero' WHERE id=2204; --El Tierrero / Caloto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "La María".', nombre='La Maria' WHERE id=2222; --La Maria / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones=' Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Corrales San Pedro".', nombre='Corrales' WHERE id=2550; --Corrales / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Pueblecito".', nombre='Pueblito' WHERE id=2670; --Pueblito / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "La Campana".', nombre='Campana' WHERE id=2668; --Campana / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Méndez".', nombre='Mendez' WHERE id=2665; --Mendez / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Sachacoco".', nombre='Asentamiento Indigena Sachacoco' WHERE id=2680; --Asentamiento Indigena Sachacoco / Sotará - Paispamba / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Polindara".', nombre='Polindará' WHERE id=2763; --Polindará / Totoró / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Jevala".', nombre='Jebalá' WHERE id=2767; --Jebalá / Totoró / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "Mayoría".', nombre='Mayoria' WHERE id=3556; --Mayoria / Ciénaga de Oro / Córdoba
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones='  No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "San Cristóbal".', nombre='San Cristobal' WHERE id=5254; --San Cristobal / Istmina / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion=NULL, observaciones=' Vuelve a aparecer en DIVIPOLA 2025-01 y cambia nombre "La Ribera".', nombre='La Rivera' WHERE id=12052; --La Rivera / Florida / Valle del Cauca

      -- Nuevos códigos de centros poblados

      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45574, 'Canime', 863, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Arboletes / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45575, 'Aguadita Grande', 194, 5, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Caramanta / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45576, 'San Antonio', 194, 6, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Caramanta / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45577, 'Nusidó', 488, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Frontino / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45578, 'Comunidad Isla 0013', 796, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Murindó / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45579, 'La Mirla', 1269, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Támesis / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45580, 'El Salado', 1392, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Vigía del Fuerte / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45581, 'Guaguandó', 1392, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Vigía del Fuerte / Antioquia
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45582, 'Cabildo Indígena Zenu', 31, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cartagena de Indias / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45583, 'La Pepita', 1347, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45584, 'Conjunto La Victoria', 1347, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45585, 'Casas Marsella', 1347, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45586, 'Arroyo Grande', 1347, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45587, 'Oasis De Campaña', 1347, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45588, 'Urbanización Los Naranjos', 1347, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45589, 'Praga', 1347, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45590, 'Condominio El Roble', 1347, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45591, 'Brisas Del Oriente', 1347, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45592, 'Villa Del Palmar', 1347, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Turbaco / Bolívar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45593, 'Bermejal', 1024, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Caldas
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45594, 'Pueblo Kokonuco', 46, 42, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Popayán / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45595, 'Potrero', 372, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Almaguer / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45596, 'Dominguillo', 372, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Almaguer / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45597, 'Las Margaritas', 164, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cajibío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45598, 'El Tablón', 174, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Caldono / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45599, 'La Capilla', 360, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45600, 'La Cima', 360, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45601, 'La Esther', 360, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45602, 'El Boquerón', 360, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45603, 'Chicharronal', 360, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45604, 'El Paraíso', 360, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45605, 'Las Cruces', 360, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45606, 'Comunidad Quebraditas', 360, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45607, 'Altamira', 360, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45608, 'Yarumales', 360, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45609, 'El Crucero', 360, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45610, 'San Pedro', 360, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45611, 'El Palmar', 360, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Corinto / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45612, 'La Venta', 449, 63, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- El Tambo / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45613, 'Zarzalito', 449, 64, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- El Tambo / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45614, 'San Roque Cañaveral', 449, 65, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- El Tambo / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45615, 'El Cabuyo', 610, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45616, 'Yarumal', 610, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45617, 'Lomitas', 610, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45618, 'El Rincón', 610, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45619, 'La Palma', 610, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45620, 'El Guayabal', 610, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45621, 'El Mesón', 610, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45622, 'El Llanito', 610, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45623, 'El Hato', 610, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45624, 'San Francisco', 610, 27, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45625, 'Brisas Del Rio Ullucos', 610, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45626, 'El Picacho', 610, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45627, 'Potrerito', 610, 30, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45628, 'Cedralia', 610, 31, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45629, 'Capicisgo', 610, 32, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45630, 'Quiguanas', 610, 33, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inzá / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45631, 'Frontino Alto', 657, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Sierra / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45632, 'El Guayabo', 661, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Vega / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45633, 'Las Palmas', 773, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Miranda / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45634, 'La Unión', 773, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Miranda / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45635, 'El Crucero', 773, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Miranda / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45636, 'Las Cañas', 773, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Miranda / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45637, 'El Cabildo', 773, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Miranda / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45638, 'San José', 792, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morales / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45639, 'El Oso', 792, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morales / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45640, 'El Playón', 792, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morales / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45641, 'Crucero De Pan De Azúcar', 792, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morales / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45642, 'Territorio Zaanann', 792, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morales / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45643, 'El Cuartel', 873, 47, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45644, 'Montecruz', 873, 48, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45645, 'Huila Viejo', 873, 49, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45646, 'La Muralla', 873, 50, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45647, 'Sector Sinai', 873, 51, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45648, 'La Cruz De Togoima', 873, 52, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45649, 'Togoima Centro', 873, 53, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45650, 'Chumal', 873, 54, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45651, 'Chicaquiu', 873, 55, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45652, 'Tres Esquinas', 873, 56, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45653, 'Alto Avirama', 873, 57, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45654, 'Mesa De Cohetando', 873, 58, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45655, 'Caloto Cohetando', 873, 59, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45656, 'Las Delicias Cohetando', 873, 60, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45657, 'La Florida', 873, 61, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45658, 'Gualcan', 873, 62, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45659, 'El Carmen Del Salado', 873, 63, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45660, 'Potrero Del Barro', 873, 64, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45661, 'El Carmen', 873, 65, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45662, 'Ukwe Kiwe', 873, 66, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45663, 'Mesa De Togoima Uno', 873, 67, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Páez / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45664, 'Alto Piendamo', 916, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Piendamó - Tunía / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45665, 'Villa Mercedes', 916, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Piendamó - Tunía / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45666, 'San Bartolo', 970, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puracé / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45667, 'San Pedrillo', 970, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puracé / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45668, 'Belén', 970, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puracé / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45669, 'San José Pisanrabo', 970, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puracé / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45670, 'Santander', 1146, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Sebastián / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45671, 'Florida', 1146, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Sebastián / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45672, 'Tengo', 1203, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45673, 'Los Bujios', 1203, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45674, 'Las Tapias', 1203, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45675, 'Delicias', 1203, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45676, 'Buenavista', 1203, 27, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45677, 'Buenavista Pitayó', 1203, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45678, 'Ovejeras', 1203, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45679, 'La Ovejera 1', 1203, 30, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45680, 'Mariposas', 1203, 31, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45681, 'Peña Del Corazón', 1203, 32, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45682, 'La Esperanza', 1203, 33, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45683, 'Santa Lucia', 1203, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Silvia / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45684, 'La Catana', 1230, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Sotará - Paispamba / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45685, 'San Pedrito', 1315, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Timbío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45686, 'Calle Santa Rosa', 1317, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Timbiquí / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45687, 'La Esperanza', 1334, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45688, 'Naranjo Centro', 1334, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45689, 'La Pila', 1334, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45690, 'La Primicia', 1334, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45691, 'El Flayo', 1334, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45692, 'Sector Piedra Mula', 1334, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45693, 'San Julian', 1334, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45694, 'Damian', 1334, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45695, 'La Maria Tacueyo', 1334, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45696, 'El Trapiche', 1334, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45697, 'Loma Linda', 1334, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45698, 'Vichiqui', 1334, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45699, 'La Bodega', 1334, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45700, 'Belén', 1334, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45701, 'Buenavista', 1334, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45702, 'La Susana', 1334, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45703, 'El Congo', 1334, 27, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45704, 'El Sesteadero', 1334, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45705, 'San Diego', 1334, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45706, 'La Capilla', 1334, 30, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45707, 'La Albania', 1334, 31, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45708, 'Chimicueto', 1334, 32, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45709, 'Gallinazas', 1334, 33, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45710, 'Soto', 1334, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45711, 'Gargantillas', 1334, 35, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45712, 'Triunfo', 1334, 36, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45713, 'Asomadero', 1334, 37, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45714, 'Puente Quemado', 1334, 38, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45715, 'La Playa', 1334, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45716, 'La Tolda', 1334, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45717, 'La Calera', 1334, 41, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Toribío / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45718, 'Bajo Palacé', 1339, 9, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45719, 'El Porvenir', 1339, 10, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45720, 'Alto Buenavista', 1339, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45721, 'Buenavista Tatawala', 1339, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45722, 'Hatoviejo', 1339, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45723, 'Betania', 1339, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45724, 'Pedragal', 1339, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45725, 'Gallinazo', 1339, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45726, 'San Pedro Del Bosque', 1339, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Totoró / Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45727, 'Arhuaco De La Sierra Nevada', 55, 52, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Valledupar / Cesar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45728, 'Isrwa', 55, 53, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Valledupar / Cesar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45729, 'Irukua', 55, 54, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Valledupar / Cesar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45730, 'Simonurwa', 943, 6, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Pueblo Bello / Cesar
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45731, 'Bajo Palmital', 278, 54, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Chinú / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45732, 'El Llano', 284, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ciénaga de Oro / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45733, 'Guayabo Sur', 1093, 33, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45734, 'Peine', 1093, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45735, 'Santa Fe', 1093, 35, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45736, 'Arroyo Del Medio', 1093, 36, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45737, 'Nueva Unión', 1093, 37, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45738, 'El Mamon', 1093, 38, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45739, 'Vida Nueva', 1093, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45740, 'Comunidad California', 1093, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45741, 'Costa Rica', 1093, 41, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45742, 'Alta Rivera Roma', 1093, 42, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45743, 'Los Andes', 1093, 43, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Sotavento / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45744, 'Nejondo', 1313, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tierralta / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45745, 'Koredo', 1313, 47, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tierralta / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45746, 'Sitio Nuevo', 1326, 36, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45747, 'Centro Alegre', 1326, 37, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45748, 'Majagual', 1326, 38, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45749, 'Pisa Bonito', 1326, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45750, 'Vidalito', 1326, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45751, 'Comunidad Mata De Caña', 1326, 41, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuchín / Córdoba
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45752, 'Resguardo Indigena Muisca De Cota', 363, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cota / Cundinamarca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45753, 'Los Manzanos', 363, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cota / Cundinamarca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45754, 'Chidima Tolo', 987, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Acandí / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45755, 'Agua Clara', 432, 42, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Alto Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45756, 'El Morro', 432, 43, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Alto Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45757, 'Vacal', 432, 44, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Alto Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45758, 'Punta Peña', 432, 45, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Alto Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45759, 'Londoño', 432, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Alto Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45760, 'Irakal', 1192, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45761, 'Mazura', 1192, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45762, 'Palma', 1192, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45763, 'Uripa', 1192, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45764, 'Conondó', 1192, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45765, 'Curripipi', 1192, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45766, 'Cevede', 1192, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45767, 'Boca De Enterra', 1192, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bagadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45768, 'Comunidad Indigena Puerto Samaria', 1237, 37, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bajo Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45769, 'Playa Linda', 1237, 38, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bajo Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45770, 'Buena Vista', 1237, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bajo Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45771, 'Comunidad Puerto Embera', 1237, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bajo Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45772, 'Unión Pitalito', 1237, 41, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bajo Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45773, 'Charco Gallo', 1465, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45774, 'Unión Baquiaza', 1465, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45775, 'Nuevo Olivo', 1465, 36, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45776, 'Chano', 1465, 37, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45777, 'Playa Blanca', 1465, 38, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45778, 'Mojaudó', 1465, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45779, 'Apartado', 1465, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Bojayá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45780, 'Mamey De Dipurdú', 213, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Carmen del Darién / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45781, 'Pared Y Parecito', 234, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cértegui / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45782, 'La Puria', 423, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- El Carmen de Atrato / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45783, 'Puerto Olave', 618, 50, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Istmina / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45784, 'Jumara Karra', 633, 10, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Juradó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45785, 'Dichardi Wounan', 633, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Juradó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45786, 'Dos Bocas', 633, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Juradó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45787, 'Cedral', 633, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Juradó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45788, 'Tegavera', 717, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45789, 'Kipara', 717, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45790, 'Cruces Parte Alta', 717, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45791, 'Río Capa', 717, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45792, 'Río Mumbú', 717, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45793, 'Aguacate', 717, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Lloró / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45794, 'Río Bebarama', 733, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Medio Atrato / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45795, 'Río Chimani', 742, 33, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Medio Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45796, 'Guadualito', 742, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Medio Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45797, 'Puerto Nuncidó', 742, 35, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Medio Baudó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45798, 'Unión Wounnaan', 769, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Medio San Juan / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45799, 'Barrancocito', 816, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nóvita / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45800, 'Belén De Bajirá', 1799, 0, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45801, 'Blanquiset', 1799, 1, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45802, 'Brisas', 1799, 2, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45803, 'La Punta', 1799, 3, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45804, 'Macondo', 1799, 4, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45805, 'Nuevo Oriente', 1799, 5, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45806, 'Playa Roja', 1799, 6, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45807, 'Santa Maria', 1799, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45808, '7 De Agosto', 1799, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuevo Belén de Bajirá / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45809, 'La Loma', 820, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Nuquí / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45810, 'Gengadó', 1012, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Río Quito / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45811, 'Quijaradó', 1012, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Río Quito / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45812, 'San José De Amia', 1012, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Río Quito / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45813, 'Pueblo Antioquia', 1028, 50, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45814, 'Peñas Blancas - Río Truandó', 1028, 51, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45815, 'La Teresita - Río Truandó', 1028, 52, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45816, 'Unión Embera Katio', 1028, 53, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45817, 'Quirapadó La Loma', 1028, 54, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45818, 'Unión Chami', 1028, 55, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riosucio / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45819, 'Sanandocito', 1207, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Sipí / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45820, 'Mondó - Mondocito', 1266, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45821, 'Tarena', 1266, 35, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tadó / Chocó
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45822, 'Huila', 612, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Íquira / Huila
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45823, 'Estación Talaga', 659, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Plata / Huila
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45824, 'Potrerito', 659, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Plata / Huila
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45825, 'Fiw Paez', 659, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Plata / Huila
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45826, 'Los Cerritos', 49, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riohacha / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45827, 'Las Delicias', 49, 47, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Riohacha / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45828, 'Barrancón', 1257, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancas / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45829, 'Cardonalito', 1257, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancas / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45830, 'Provincial', 1257, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancas / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45831, 'Cerro De Hatonuevo', 640, 13, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Hatonuevo / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45832, 'Zenuy', 741, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45833, 'Ushuru', 741, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45834, 'Maicaito', 741, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45835, 'Pulikumana', 741, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45836, 'Ichichon', 741, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45837, 'Aipian', 741, 26, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45838, 'Carrizal', 741, 27, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45839, 'Majayutpana', 741, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45840, 'Uyatpana', 741, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Maicao / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45841, 'Kaasumana', 933, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Manaure / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45842, 'Hurraychichon', 933, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Manaure / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45843, 'Santa Rosa 1', 933, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Manaure / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45844, 'Santa Rosa 2', 933, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Manaure / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45845, 'Ipain', 1361, 39, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45846, 'Amasirraru', 1361, 40, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45847, 'Juyanaspa', 1361, 41, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45848, 'Piruulia', 1361, 42, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45849, 'Aranaipa', 1361, 43, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45850, 'Kaiwa Atauchon', 1361, 44, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45851, 'Jalalaru', 1361, 45, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45852, 'Kasutarain', 1361, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45853, 'Jepen', 1361, 47, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Uribia / La Guajira
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45854, 'Taminaka', 52, 46, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Santa Marta / Magdalena
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45855, 'Setay', 285, 27, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ciénaga / Magdalena
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45856, 'Mankuaja', 285, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ciénaga / Magdalena
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45857, 'Issa Oristuna', 1070, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Sabanas de San Ángel / Magdalena
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45858, 'Los Marcos', 611, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ipiales / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45859, 'Brisas Del Rumiyaco', 611, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ipiales / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45860, 'El Empalme', 611, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ipiales / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45861, 'La Libertad', 611, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ipiales / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45862, 'San Jose Roble', 813, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Olaya Herrera / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45863, 'Chapil', 813, 22, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Olaya Herrera / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45864, 'Cuaiquer', 1023, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ricaurte / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45865, 'Eden Cartagena', 1023, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ricaurte / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45866, 'Guayabal', 1149, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Santa Bárbara / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45867, 'Kilómetro 88', 1345, 236, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San Andrés de Tumaco / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45868, 'La Jardinera', 1351, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Túquerres / Nariño
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45869, 'La Florida', 1405, 12, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Belén de Umbría / Risaralda
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45870, 'Llanadas', 548, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Girón / Santander
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45871, 'Vientos De Llanada', 548, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Girón / Santander
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45872, 'Calle Fría (Sincelejo)', 53, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Sincelejo / Sucre
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45873, 'Santa Ana', 886, 21, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Palmito / Sucre
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45874, 'Calle Fría (Sampues)', 1092, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Sampués / Sucre
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45875, 'Martinica Parte Alta', 34, 67, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Ibagué / Tolima
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45876, 'Chenche Zaragoza', 368, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Coyaima / Tolima
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45877, 'Parcelación Montearroyo', 112, 31, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Guadalajara de Buga / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45878, 'Conjunto Campestre Kycun', 112, 32, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Guadalajara de Buga / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45879, 'Mirador Del Frayle', 166, 45, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Candelaria / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45880, 'San Juan Páez', 478, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Florida / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45881, 'El Cairo', 1344, 34, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tuluá / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45882, 'Wasiruma', 1385, 11, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Vijes / Valle del Cauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45883, 'Mate Candela', 18, 23, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Arauca / Arauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45884, 'Barrancón', 18, 24, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Arauca / Arauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45885, 'La Colmena', 18, 25, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Arauca / Arauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45886, 'Macarieros', 1279, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Tame / Arauca
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45887, 'Peñarol', 575, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Orito / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45888, 'Portugal', 575, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Orito / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45889, 'San Andrés', 575, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Orito / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45890, 'San Andrés', 942, 6, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puerto Caicedo / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45891, 'Damasco', 942, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puerto Caicedo / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45892, 'Alparrumiyaco', 1409, 15, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Villagarzón / Putumayo
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45893, 'Santa María', 703, 2, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- La Chorrera / Amazonas
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45894, 'Matraca', 35, 16, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inírida / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45895, 'Danta', 35, 17, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inírida / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45896, 'Chorro Bocón', 35, 18, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inírida / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45897, 'Remanso', 35, 19, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inírida / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45898, 'Loma Baja', 35, 20, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Inírida / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45899, 'Pueblo Nuevo', 594, 6, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancominas / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45900, 'Laguna Colorada', 594, 7, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancominas / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45901, 'Carpintero', 594, 8, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Barrancominas / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45902, 'Berrocal', 1407, 2, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puerto Colombia / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45903, 'San José', 1407, 3, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Puerto Colombia / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45904, 'Puerto Valencia', 1417, 1, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morichal / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45905, 'Zancudo', 1417, 2, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Morichal / Guainía
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45906, 'Corocoro', 51, 47, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San José del Guaviare / Guaviare
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45907, 'Condominio Los Laureles', 51, 48, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- San José del Guaviare / Guaviare
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45908, 'Mituseño_Urania', 39, 14, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Mitú / Vaupés
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45909, 'Guaco Bajo', 1246, 28, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cumaribo / Vichada
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45910, 'Guaco Alto', 1246, 29, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cumaribo / Vichada
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45911, 'Caño Bocón', 1246, 30, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cumaribo / Vichada
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45912, 'Camunianae', 1246, 31, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cumaribo / Vichada
      INSERT INTO msip_centropoblado (id, nombre, municipio_id, cplocal_cod, observaciones, fechacreacion, created_at, updated_at)  VALUES (45913, 'Guerima', 1246, 32, 'Agregado en DIVIPOLA 2025-01.', '2025-01-26', '2025-01-26', '2025-01-26'); -- Cumaribo / Vichada

      -- Centros poblados con nombres cambiados


      UPDATE msip_centropoblado SET nombre='El Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso".' WHERE id=14010; -- ANTIOQUIA/BARBOSA
      UPDATE msip_centropoblado SET nombre='Travesías', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Travesias".' WHERE id=14017; -- ANTIOQUIA/BRICEÑO
      UPDATE msip_centropoblado SET nombre='Fátima', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Fatima".' WHERE id=14045; -- ANTIOQUIA/EBÉJICO
      UPDATE msip_centropoblado SET nombre='El Chingui 2', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Chingui  2".' WHERE id=14051; -- ANTIOQUIA/ENVIGADO
      UPDATE msip_centropoblado SET nombre='Parcelación Álamos Del Escobero', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelación Alamos Del Escobero".' WHERE id=14054; -- ANTIOQUIA/ENVIGADO
      UPDATE msip_centropoblado SET nombre='El Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso".' WHERE id=14071; -- ANTIOQUIA/GIRARDOTA
      UPDATE msip_centropoblado SET nombre='Jamaica Parcelación Campestre', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Jamaica Parcelacion Campestre".' WHERE id=14107; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Parcelación Andalucia', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion Andalucia".' WHERE id=14109; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Parcelación Camelot', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion Camelot".' WHERE id=14110; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Parcelación Santa María Del Llano', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion Santa Maria Del Llano".' WHERE id=14118; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Pitalito', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Pital Del Carlín (Pitalito)".' WHERE id=12521; -- ATLÁNTICO/POLONUEVO
      UPDATE msip_centropoblado SET nombre='Corcovado', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "El Corcovado".' WHERE id=653; -- BOLÍVAR/MORALES
      UPDATE msip_centropoblado SET nombre='La Unión', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "La Union".' WHERE id=672; -- BOLÍVAR/PINILLOS
      UPDATE msip_centropoblado SET nombre='La Unión Cabecera', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "La Union Cabecera".' WHERE id=14205; -- BOLÍVAR/PINILLOS
      UPDATE msip_centropoblado SET nombre='Ánimas Altas', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Animas Altas".' WHERE id=799; -- BOLÍVAR/SIMITÍ
      UPDATE msip_centropoblado SET nombre='Puerto Gaitán', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Puerto Gaitan".' WHERE id=14219; -- BOLÍVAR/TIQUISIO
      UPDATE msip_centropoblado SET nombre='Urbanización Villa De Calatrava', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Villa De Calatrava".' WHERE id=14221; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanización Campestre', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Campestre".' WHERE id=14222; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanización Catalina', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Catalina".' WHERE id=14223; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanización Zapote', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Zapote".' WHERE id=14224; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Turbana', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Turbaná".' WHERE id=839; -- BOLÍVAR/TURBANÁ
      UPDATE msip_centropoblado SET nombre='Chámeza Mayor', observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Chameza Mayor".' WHERE id=1162; -- BOYACÁ/NOBSA
      UPDATE msip_centropoblado SET nombre='Guáquira', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Guaquira".' WHERE id=1161; -- BOYACÁ/NOBSA
      UPDATE msip_centropoblado SET nombre='La Fábrica', observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "La Fabrica".' WHERE id=1263; -- BOYACÁ/SAMACÁ
      UPDATE msip_centropoblado SET nombre='Kilómetro 41 - Colombia', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Kilometro 41 - Colombia".' WHERE id=1459; -- CALDAS/MANIZALES
      UPDATE msip_centropoblado SET nombre='Condominio Reserva De Los Álamos', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Condominio Reserva De Los Alamos".' WHERE id=14240; -- CALDAS/MANIZALES
      UPDATE msip_centropoblado SET nombre='Jiménez Alto', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Jimenez Alto".' WHERE id=1581; -- CALDAS/MARMATO
      UPDATE msip_centropoblado SET nombre='Jiménez Bajo', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Jimenez Bajo".' WHERE id=1576; -- CALDAS/MARMATO
      UPDATE msip_centropoblado SET nombre='Santágueda', observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2023-07. Nombre cambiado en DIVIPOLA 2025-01 de "Santagueda".' WHERE id=1622; -- CALDAS/PALESTINA
      UPDATE msip_centropoblado SET nombre='Vereda La Unión', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Vereda La Union".' WHERE id=1677; -- CALDAS/SALAMINA
      UPDATE msip_centropoblado SET nombre='La Esperanza (Jardínes De Paz)', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "La Esperanza (Jardines De Paz)".' WHERE id=1963; -- CAUCA/POPAYÁN
      UPDATE msip_centropoblado SET nombre='Isla Del Pontón', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Isla Del Ponton".' WHERE id=14278; -- CAUCA/CAJIBÍO
      UPDATE msip_centropoblado SET nombre='Puente Del Río Timbío', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Puente Del Río Timbio".' WHERE id=14287; -- CAUCA/EL TAMBO
      UPDATE msip_centropoblado SET nombre='Ciénaga Honda', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Cienaga Honda".' WHERE id=14292; -- CAUCA/GUACHENÉ
      UPDATE msip_centropoblado SET nombre='San José De Guare', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "San Jose De Guare".' WHERE id=2295; -- CAUCA/GUAPI
      UPDATE msip_centropoblado SET nombre='Tulipán', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Tulipan".' WHERE id=2433; -- CAUCA/MIRANDA
      UPDATE msip_centropoblado SET nombre='La Mesa De Belalcázar', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "La Mesa De Belalcazar".' WHERE id=14325; -- CAUCA/PÁEZ
      UPDATE msip_centropoblado SET nombre='Valencia De Jesús', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Valencia De Jesus".' WHERE id=2864; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Los Haticos I', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Los Haticos  I".' WHERE id=2868; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Raíces', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Raices".' WHERE id=2900; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='La Vega Arriba', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "La Vega  Arriba".' WHERE id=2857; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Zapatí', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Zapati".' WHERE id=2960; -- CESAR/CHIMICHAGUA
      UPDATE msip_centropoblado SET nombre='La Unión', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "La Union".' WHERE id=14357; -- CESAR/CHIMICHAGUA
      UPDATE msip_centropoblado SET nombre='Terraplén', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Terraplen".' WHERE id=3128; -- CESAR/SAN MARTÍN
      UPDATE msip_centropoblado SET nombre='Medellín - Sapo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Medellin - Sapo".' WHERE id=14379; -- CÓRDOBA/MONTERÍA
      UPDATE msip_centropoblado SET nombre='Los Ángeles', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Los Angeles".' WHERE id=3513; -- CÓRDOBA/CHINÚ
      UPDATE msip_centropoblado SET nombre='Villa Concepción', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Villa Concepcion".' WHERE id=3659; -- CÓRDOBA/LORICA
      UPDATE msip_centropoblado SET nombre='La Unión', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "La Union".' WHERE id=3745; -- CÓRDOBA/MOÑITOS
      UPDATE msip_centropoblado SET nombre='La Música', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "La Musica".' WHERE id=14407; -- CÓRDOBA/SAHAGÚN
      UPDATE msip_centropoblado SET nombre='Punta Bolívar', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Punta Bolivar".' WHERE id=3941; -- CÓRDOBA/SAN ANTERO
      UPDATE msip_centropoblado SET nombre='El Darién', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "El Darien".' WHERE id=14418; -- CÓRDOBA/SAN BERNARDO DEL VIENTO
      UPDATE msip_centropoblado SET nombre='Urbanización Tierra De Ensueño', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Tierra De Ensueño".' WHERE id=14455; -- CUNDINAMARCA/CACHIPAY
      UPDATE msip_centropoblado SET nombre='Rincón De Fagua', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Rincon De Fagua".' WHERE id=4313; -- CUNDINAMARCA/CHÍA
      UPDATE msip_centropoblado SET nombre='Santa Bárbara', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Santa Barbara".' WHERE id=4307; -- CUNDINAMARCA/CHÍA
      UPDATE msip_centropoblado SET nombre='San Rafael Bajo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "San Rafael  Bajo".' WHERE id=4385; -- CUNDINAMARCA/FACATATIVÁ
      UPDATE msip_centropoblado SET nombre='El Triunfo Boquerón', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era EL TRIUNFO. Nombre cambiado en DIVIPOLA 2025-01 de "El Triunfo Boqueron".' WHERE id=4420; -- CUNDINAMARCA/FUSAGASUGÁ
      UPDATE msip_centropoblado SET nombre='Río Blanco - Los Puentes', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era RIO BLANCO -LOS PUENTES. Nombre cambiado en DIVIPOLA 2025-01 de "Rio Blanco - Los Puentes".' WHERE id=4423; -- CUNDINAMARCA/FUSAGASUGÁ
      UPDATE msip_centropoblado SET nombre='Villa Shyn (Casas Móviles)', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era VILLA SHYN(CASA MOVILES). Nombre cambiado en DIVIPOLA 2025-01 de "Villa Shyn (Casas Moviles)".' WHERE id=4679; -- CUNDINAMARCA/SAN ANTONIO DEL TEQUENDAMA
      UPDATE msip_centropoblado SET nombre='Santa Inés', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM. Nombre cambiado en DIVIPOLA 2025-01 de "Santa Ines".' WHERE id=4716; -- CUNDINAMARCA/SASAIMA
      UPDATE msip_centropoblado SET nombre='El Péncil', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era EL PENCIL (SANTA BARBARA). Nombre cambiado en DIVIPOLA 2025-01 de "El Pencil".' WHERE id=4791; -- CUNDINAMARCA/TABIO
      UPDATE msip_centropoblado SET nombre='Chicó Norte', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Chico Norte".' WHERE id=14499; -- CUNDINAMARCA/TOCANCIPÁ
      UPDATE msip_centropoblado SET nombre='Malagón', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Malagon".' WHERE id=14512; -- CUNDINAMARCA/ZIPAQUIRÁ
      UPDATE msip_centropoblado SET nombre='San Francisco De Quibdó', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "San Francisco De Quibdo".' WHERE id=4960; -- CHOCÓ/QUIBDÓ
      UPDATE msip_centropoblado SET nombre='Campo Bonito', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Campobonito".' WHERE id=4971; -- CHOCÓ/QUIBDÓ
      UPDATE msip_centropoblado SET nombre='Santa Catalina De Catrú', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Santa Catalina De Catru".' WHERE id=5029; -- CHOCÓ/ALTO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Unión Guaimia', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Union Guaimia".' WHERE id=14538; -- CHOCÓ/EL LITORAL DEL SAN JUAN
      UPDATE msip_centropoblado SET nombre='Canchidó', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Canchido".' WHERE id=14543; -- CHOCÓ/LLORÓ
      UPDATE msip_centropoblado SET nombre='Baudó Grande', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Baudo Grande".' WHERE id=14549; -- CHOCÓ/MEDIO ATRATO
      UPDATE msip_centropoblado SET nombre='Boca De Curundó', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Boca De Curundo".' WHERE id=14555; -- CHOCÓ/MEDIO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Curundó La Loma', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Curundo La Loma".' WHERE id=14556; -- CHOCÓ/MEDIO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Joví', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Jovi".' WHERE id=5369; -- CHOCÓ/NUQUÍ
      UPDATE msip_centropoblado SET nombre=' La Teresita - Río Truandó', observaciones='Agregado en DIVIPOLA 2025-01. Nombre cambiado en DIVIPOLA 2025-01 de "La Teresita - Río Truandó".' WHERE id=45815; -- CHOCÓ/RIOSUCIO
      UPDATE msip_centropoblado SET nombre='Bajo Junín', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Bajo Junin".' WHERE id=14595; -- HUILA/ISNOS
      UPDATE msip_centropoblado SET nombre='Río Jerez', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Rio Jerez".' WHERE id=14614; -- LA GUAJIRA/DIBULLA
      UPDATE msip_centropoblado SET nombre='Arroyo Limón', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Arroyo Limon".' WHERE id=14626; -- LA GUAJIRA/MANAURE
      UPDATE msip_centropoblado SET nombre='Paraíso', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Paraiso".' WHERE id=14634; -- LA GUAJIRA/URIBIA
      UPDATE msip_centropoblado SET nombre='Villa Fátima', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Villa Fatima".' WHERE id=14639; -- LA GUAJIRA/URIBIA
      UPDATE msip_centropoblado SET nombre='Nuevo Méjico', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Nuevo Mejico".' WHERE id=14644; -- MAGDALENA/SANTA MARTA
      UPDATE msip_centropoblado SET nombre='Río De Piedra Ii', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Rio De Piedra Ii".' WHERE id=14655; -- MAGDALENA/ARACATACA
      UPDATE msip_centropoblado SET nombre='Montería', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Monteria".' WHERE id=14677; -- MAGDALENA/ZONA BANANERA
      UPDATE msip_centropoblado SET nombre='Rincón De Pompeya', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Rincon De Pompeya".' WHERE id=7691; -- META/VILLAVICENCIO
      UPDATE msip_centropoblado SET nombre='Rincón Del Indio', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM. Nombre cambiado en DIVIPOLA 2025-01 de "Rincon Del Indio".' WHERE id=14694; -- META/MAPIRIPÁN
      UPDATE msip_centropoblado SET nombre='El Paraíso Mejor Vivir', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso Mejor Vivir".' WHERE id=14711; -- META/SAN MARTÍN
      UPDATE msip_centropoblado SET nombre='Santa Bárbara', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Santa Barbara".' WHERE id=7882; -- NARIÑO/PASTO
      UPDATE msip_centropoblado SET nombre='Bolívar', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Bolivar".' WHERE id=14733; -- NARIÑO/LA LLANADA
      UPDATE msip_centropoblado SET nombre='Urbanización Villa Cafelina', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Urbanizacion Villa Cafelina".' WHERE id=14764; -- NARIÑO/SANDONÁ
      UPDATE msip_centropoblado SET nombre='San José Del Guayabo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "San Jose Del Guayabo".' WHERE id=8855; -- NARIÑO/SAN ANDRÉS DE TUMACO
      UPDATE msip_centropoblado SET nombre='Piñuela Río Mira', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Piñuela Rio Mira".' WHERE id=8949; -- NARIÑO/SAN ANDRÉS DE TUMACO
      UPDATE msip_centropoblado SET nombre='Recta Los Álamos', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Recta Los Alamos".' WHERE id=14786; -- NORTE DE SANTANDER/CHINÁCOTA
      UPDATE msip_centropoblado SET nombre='Condominio El Paraíso', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Condominio El Paraiso".' WHERE id=14849; -- RISARALDA/PEREIRA
      UPDATE msip_centropoblado SET nombre='Ciénaga De Opón', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Cienaga De Opon".' WHERE id=14876; -- SANTANDER/BARRANCABERMEJA
      UPDATE msip_centropoblado SET nombre='Río De Oro', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Rio De Oro".' WHERE id=14899; -- SANTANDER/GIRÓN
      UPDATE msip_centropoblado SET nombre='Edén', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Eden".' WHERE id=14909; -- SANTANDER/PIEDECUESTA
      UPDATE msip_centropoblado SET nombre='Peña Blanca', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Pena Blanca".' WHERE id=14931; -- SANTANDER/VÉLEZ
      UPDATE msip_centropoblado SET nombre='El Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso".' WHERE id=14944; -- SUCRE/COLOSÓ
      UPDATE msip_centropoblado SET nombre='Milán', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Milan".' WHERE id=14949; -- SUCRE/COROZAL
      UPDATE msip_centropoblado SET nombre='La Concepción', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "La Concepcion".' WHERE id=14961; -- SUCRE/LA UNIÓN
      UPDATE msip_centropoblado SET nombre='Charcón', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Charcon".' WHERE id=14963; -- SUCRE/LOS PALMITOS
      UPDATE msip_centropoblado SET nombre='Guamí', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "Guami".' WHERE id=10842; -- SUCRE/PALMITO
      UPDATE msip_centropoblado SET nombre='Invasión Bella Isla De Llanitos', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Invasion Bella Isla De Llanitos".' WHERE id=15012; -- TOLIMA/IBAGUÉ
      UPDATE msip_centropoblado SET nombre='Cascajal Iii', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "Amstercol Ii".' WHERE id=11576; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Parcelación Cantaclaro 1', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion Cantaclaro 1".' WHERE id=15034; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Parcelación Cantaclaro 2', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion Cantaclaro 2".' WHERE id=15035; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Parcelación La Trinidad', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Parcelacion La Trinidad".' WHERE id=15036; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Joaquincito Resguardo Indígena', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM. Nombre cambiado en DIVIPOLA 2025-01 de "Joaquincito Resguardo Indigena".' WHERE id=11701; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='San Antoñito (Yurumanguí)', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era SAN ANTOÑITO(YURUMANGUI). Nombre cambiado en DIVIPOLA 2025-01 de "San Antoñito (Yurumangui)".' WHERE id=11704; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='Zaragoza Puente San Martín 1', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Zaragoza Puente San Martin 1".' WHERE id=15062; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='Zaragoza Puente San Martín 2', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Zaragoza Puente San Martin 2".' WHERE id=15063; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='El Vínculo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Nombre cambiado en DIVIPOLA 2025-01 de "El Vinculo".' WHERE id=11793; -- VALLE DEL CAUCA/GUADALAJARA DE BUGA
      UPDATE msip_centropoblado SET nombre='El Eden', observaciones='Agregado en DIVIPOLA 2022. Nombre cambiado en DIVIPOLA 2025-01 de "El Edén".' WHERE id=15440; -- VALLE DEL CAUCA/DAGUA
      UPDATE msip_centropoblado SET nombre='La Unión', observaciones='Nombre cambiado en DIVIPOLA 2025-01 de "La Union".' WHERE id=12157; -- VALLE DEL CAUCA/PALMIRA
      UPDATE msip_centropoblado SET nombre='Dosquebradas', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Rehabilitado por DIVIPOLA 2019 el 2020-07-23, nombre anterior: DOS QUEBRADAS. Rehabilitado por DIVIPOLA 2019 el 2020-07-23, nombre anterior: DOS QUEBRADAS. Nombre cambiando en DIVIPOLA 2021, antes era DOSQUEBRADAS. Nombre cambiando en DIVIPOLA 2021, antes era DOSQUEBRADAS Nombre cambiado en DIVIPOLA 2025-01 de "Dos Quebradas".' WHERE id=12351; -- VALLE DEL CAUCA/TRUJILLO
      UPDATE msip_centropoblado SET nombre='Triunfo', observaciones='Agregado en DIVIPOLA 2023-07. Nombre cambiado en DIVIPOLA 2025-01 de "El Triunfo".' WHERE id=45565; -- CASANARE/VILLANUEVA
      UPDATE msip_centropoblado SET nombre='El Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso".' WHERE id=15132; -- PUTUMAYO/ORITO
      UPDATE msip_centropoblado SET nombre='El Bombón', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "El Bombon".' WHERE id=15139; -- PUTUMAYO/PUERTO GUZMÁN
      UPDATE msip_centropoblado SET nombre='Sagrado Corazón De Jesús', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Sagrado Corazon De Jesus".' WHERE id=15142; -- PUTUMAYO/SIBUNDOY
      UPDATE msip_centropoblado SET nombre='Jordán Ortiz', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. Nombre cambiado en DIVIPOLA 2025-01 de "Jordán Ortíz".' WHERE id=15150; -- PUTUMAYO/SAN MIGUEL
      UPDATE msip_centropoblado SET nombre='El Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "El Paraiso".' WHERE id=15155; -- PUTUMAYO/SAN MIGUEL
      UPDATE msip_centropoblado SET nombre='Río Blanco', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Rio Blanco".' WHERE id=15160; -- PUTUMAYO/VILLAGARZÓN
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Patio De Ciencia Dulce Km 11', observaciones='Cambio basado en DIVIPOLA 2018. Antes era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11. Nombre cambiado en DIVIPOLA 2025-01 de "Comunidad Indígena Patio De Ciencia Dulce  Km 11".' WHERE id=13016; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Asentamiento Humano Takana Km 11', observaciones='Cambio basado en DIVIPOLA 2018. Antes era ASENTAMIENTO HUMANO TAKANA KM 11. Nombre de DIVIPOLA 2019, el anterior era ASENTAMIENTO HUMANO TAKANA KM 11 (MULTIÉTNICA). Nombre de DIVIPOLA 2019, el anterior era ASENTAMIENTO HUMANO TAKANA KM 11 (MULTIÉTNICA). Nombre cambiado en DIVIPOLA 2025-01 de "Asentamiento Humano Takana  Km 11".' WHERE id=13019; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Nuevo Jardín', observaciones='Cambio basado en DIVIPOLA 2018. Antes era COMUNIDAD INDIGENA NUEVO JARDIN. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDÍGENA NUEVO JARDIN 91001025. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDÍGENA NUEVO JARDIN 91001025. Nombre cambiado en DIVIPOLA 2025-01 de "Comunidad Indígena Nuevo Jardin".' WHERE id=13005; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Canaán', observaciones='Aparece en DIVIPOLA 2018. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA CANAAN. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA CANAAN. Nombre cambiado en DIVIPOLA 2025-01 de "Comunidad Indígena Canaan".' WHERE id=15164; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Nuevo Paraíso', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "Nuevo Paraiso".' WHERE id=15169; -- AMAZONAS/PUERTO NARIÑO
      UPDATE msip_centropoblado SET nombre='San José De Villa Andrea', observaciones='Aparece en DIVIPOLA 2018. Nombre cambiado en DIVIPOLA 2025-01 de "San Jose De Villa Andrea".' WHERE id=15171; -- AMAZONAS/PUERTO NARIÑO
      -- Agrega latitud, longitud a centros poblados que no tenían

      UPDATE msip_centropoblado SET latitud='3.104551', longitud='-73.843961' WHERE id=14712; -- Tres Esquinas / Vistahermosa / Meta
      UPDATE msip_centropoblado SET latitud='3.21757', longitud='-73.794673' WHERE id=7862; -- Campo Alegre / Vistahermosa / Meta
      UPDATE msip_centropoblado SET latitud='2.204159', longitud='-77.91141' WHERE id=45866; -- Guayabal / Santa Bárbara / Nariño
      UPDATE msip_centropoblado SET latitud='5.832136', longitud='-77.209431' WHERE id=45809; -- La Loma / Nuquí / Chocó
      UPDATE msip_centropoblado SET latitud='8.791352', longitud='-76.405863' WHERE id=45574; -- Canime / Arboletes / Antioquia
      UPDATE msip_centropoblado SET latitud='3.061562', longitud='-70.261553' WHERE id=45901; -- Carpintero / Barrancominas / Guainía
      UPDATE msip_centropoblado SET latitud='3.401972', longitud='-69.914101' WHERE id=45900; -- Laguna Colorada / Barrancominas / Guainía
      UPDATE msip_centropoblado SET latitud='3.421646', longitud='-69.893856' WHERE id=45899; -- Pueblo Nuevo / Barrancominas / Guainía
      UPDATE msip_centropoblado SET latitud='3.483971', longitud='-69.809727' WHERE id=15176; -- Minitas / Barrancominas / Guainía
      UPDATE msip_centropoblado SET latitud='12.085241', longitud='-72.043655' WHERE id=45853; -- Jepen / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='12.014242', longitud='-72.07369' WHERE id=45852; -- Kasutarain / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.91816', longitud='-72.184159' WHERE id=45851; -- Jalalaru / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.911861', longitud='-72.185414' WHERE id=45850; -- Kaiwa Atauchon / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.874353', longitud='-72.195322' WHERE id=45849; -- Aranaipa / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.817109', longitud='-72.24762' WHERE id=45848; -- Piruulia / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.816295', longitud='-72.241709' WHERE id=45847; -- Juyanaspa / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.728234', longitud='-72.28396' WHERE id=45846; -- Amasirraru / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='11.736907', longitud='-72.289092' WHERE id=45845; -- Ipain / Uribia / La Guajira
      UPDATE msip_centropoblado SET latitud='10.456025', longitud='-73.57522' WHERE id=45730; -- Simonurwa / Pueblo Bello / Cesar
      UPDATE msip_centropoblado SET latitud='11.529404', longitud='-72.944121' WHERE id=45827; -- Las Delicias / Riohacha / La Guajira
      UPDATE msip_centropoblado SET latitud='11.507242', longitud='-72.928908' WHERE id=45826; -- Los Cerritos / Riohacha / La Guajira
      UPDATE msip_centropoblado SET latitud='8.366923', longitud='-72.599401' WHERE id=9429; -- La Llana / Tibú / Norte de Santander
      UPDATE msip_centropoblado SET latitud='1.05615', longitud='-77.619781' WHERE id=45868; -- La Jardinera / Túquerres / Nariño
      UPDATE msip_centropoblado SET latitud='-1.436607', longitud='-72.791416' WHERE id=45893; -- Santa María / La Chorrera / Amazonas
      UPDATE msip_centropoblado SET latitud='6.064278', longitud='-74.80647' WHERE id=7310; -- El Prodigio / San Luis / Antioquia
      UPDATE msip_centropoblado SET latitud='5.498964', longitud='-76.232502' WHERE id=45767; -- Boca De Enterra / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.438552', longitud='-76.133895' WHERE id=45766; -- Cevede / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.431825', longitud='-76.132092' WHERE id=45765; -- Curripipi / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.47607', longitud='-76.144131' WHERE id=45764; -- Conondó / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.47948', longitud='-76.174902' WHERE id=45763; -- Uripa / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.492587', longitud='-76.181802' WHERE id=45762; -- Palma / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.470323', longitud='-76.179221' WHERE id=45761; -- Mazura / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.548967', longitud='-76.206287' WHERE id=45760; -- Irakal / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.465303', longitud='-76.139064' WHERE id=5074; -- Aguasal / Bagadó / Chocó
      UPDATE msip_centropoblado SET latitud='1.50123', longitud='-77.452188' WHERE id=8190; -- Las Cochas / El Peñol / Nariño
      UPDATE msip_centropoblado SET latitud='6.791721', longitud='-76.209131' WHERE id=45577; -- Nusidó / Frontino / Antioquia
      UPDATE msip_centropoblado SET latitud='1.270916', longitud='-70.198149' WHERE id=45908; -- Mituseño_Urania / Mitú / Vaupés
      UPDATE msip_centropoblado SET latitud='3.690522', longitud='-68.323204' WHERE id=45898; -- Loma Baja / Inírida / Guainía
      UPDATE msip_centropoblado SET latitud='3.47404', longitud='-67.962636' WHERE id=45897; -- Remanso / Inírida / Guainía
      UPDATE msip_centropoblado SET latitud='3.20966', longitud='-68.220715' WHERE id=45896; -- Chorro Bocón / Inírida / Guainía
      UPDATE msip_centropoblado SET latitud='2.965619', longitud='-68.779889' WHERE id=45895; -- Danta / Inírida / Guainía
      UPDATE msip_centropoblado SET latitud='2.869611', longitud='-69.089063' WHERE id=45894; -- Matraca / Inírida / Guainía
      UPDATE msip_centropoblado SET latitud='2.769907', longitud='-69.360335' WHERE id=45905; -- Zancudo / Morichal / Guainía
      UPDATE msip_centropoblado SET latitud='2.567818', longitud='-69.65735' WHERE id=45904; -- Puerto Valencia / Morichal / Guainía
      UPDATE msip_centropoblado SET latitud='2.696689', longitud='-68.024414' WHERE id=45903; -- San José / Puerto Colombia / Guainía
      UPDATE msip_centropoblado SET latitud='2.299461', longitud='-68.283406' WHERE id=45902; -- Berrocal / Puerto Colombia / Guainía
      UPDATE msip_centropoblado SET latitud='0.660079', longitud='-76.779415' WHERE id=45889; -- San Andrés / Orito / Putumayo
      UPDATE msip_centropoblado SET latitud='0.789836', longitud='-76.768296' WHERE id=45888; -- Portugal / Orito / Putumayo
      UPDATE msip_centropoblado SET latitud='0.7511', longitud='-76.717161' WHERE id=45887; -- Peñarol / Orito / Putumayo
      UPDATE msip_centropoblado SET latitud='0.743243', longitud='-76.699433' WHERE id=12860; -- San Juan Vides / Orito / Putumayo
      UPDATE msip_centropoblado SET latitud='8.60931', longitud='-73.18015' WHERE id=9392; -- La Cecilia / Teorama / Norte de Santander
      UPDATE msip_centropoblado SET latitud='0.773294', longitud='-76.70508' WHERE id=45891; -- Damasco / Puerto Caicedo / Putumayo
      UPDATE msip_centropoblado SET latitud='0.76552', longitud='-76.708568' WHERE id=45890; -- San Andrés / Puerto Caicedo / Putumayo
      UPDATE msip_centropoblado SET latitud='10.344517', longitud='-75.470438' WHERE id=45582; -- Cabildo Indígena Zenu / Cartagena de Indias / Bolívar
      UPDATE msip_centropoblado SET latitud='6.389532', longitud='-76.890134' WHERE id=45779; -- Apartado / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.22946', longitud='-77.085674' WHERE id=45778; -- Mojaudó / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.221296', longitud='-77.105102' WHERE id=45777; -- Playa Blanca / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.144156', longitud='-77.108325' WHERE id=45776; -- Chano / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.372436', longitud='-77.188621' WHERE id=45775; -- Nuevo Olivo / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.717706', longitud='-77.11635' WHERE id=45774; -- Unión Baquiaza / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='6.324305', longitud='-77.071055' WHERE id=45773; -- Charco Gallo / Bojayá / Chocó
      UPDATE msip_centropoblado SET latitud='0.802272', longitud='-76.795865' WHERE id=45892; -- Alparrumiyaco / Villagarzón / Putumayo
      UPDATE msip_centropoblado SET latitud='2.424742', longitud='-77.215875' WHERE id=2017; -- Puerto Rico / Argelia / Cauca
      UPDATE msip_centropoblado SET latitud='2.309075', longitud='-77.257873' WHERE id=2025; -- El Diviso / Argelia / Cauca
      UPDATE msip_centropoblado SET latitud='3.020609', longitud='-76.291391' WHERE id=2204; -- El Tierrero / Caloto / Cauca
      UPDATE msip_centropoblado SET latitud='3.03365', longitud='-76.299197' WHERE id=2181; -- El Credo / Caloto / Cauca
      UPDATE msip_centropoblado SET latitud='2.686112', longitud='-75.751118' WHERE id=45822; -- Huila / Íquira / Huila
      UPDATE msip_centropoblado SET latitud='10.526181', longitud='-73.31163' WHERE id=45729; -- Irukua / Valledupar / Cesar
      UPDATE msip_centropoblado SET latitud='10.568333', longitud='-73.44374' WHERE id=45728; -- Isrwa / Valledupar / Cesar
      UPDATE msip_centropoblado SET latitud='10.679677', longitud='-73.488971' WHERE id=45727; -- Arhuaco De La Sierra Nevada / Valledupar / Cesar
      UPDATE msip_centropoblado SET latitud='8.341217', longitud='-77.212453' WHERE id=45754; -- Chidima Tolo / Acandí / Chocó
      UPDATE msip_centropoblado SET latitud='11.023158', longitud='-72.737269' WHERE id=45830; -- Provincial / Barrancas / La Guajira
      UPDATE msip_centropoblado SET latitud='11.020262', longitud='-72.748626' WHERE id=45829; -- Cardonalito / Barrancas / La Guajira
      UPDATE msip_centropoblado SET latitud='10.921353', longitud='-72.772854' WHERE id=45828; -- Barrancón / Barrancas / La Guajira
      UPDATE msip_centropoblado SET latitud='11.055163', longitud='-72.75747' WHERE id=45831; -- Cerro De Hatonuevo / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET latitud='2.592407', longitud='-75.997448' WHERE id=45663; -- Mesa De Togoima Uno / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.680091', longitud='-75.810758' WHERE id=45662; -- Ukwe Kiwe / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.65014', longitud='-75.960042' WHERE id=45661; -- El Carmen / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.654734', longitud='-75.959276' WHERE id=45660; -- Potrero Del Barro / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.654403', longitud='-75.953629' WHERE id=45659; -- El Carmen Del Salado / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.62883', longitud='-75.976464' WHERE id=45658; -- Gualcan / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.609868', longitud='-75.966497' WHERE id=45657; -- La Florida / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.573894', longitud='-75.961594' WHERE id=45656; -- Las Delicias Cohetando / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.581999', longitud='-75.958932' WHERE id=45655; -- Caloto Cohetando / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.565889', longitud='-75.964416' WHERE id=45654; -- Mesa De Cohetando / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.655586', longitud='-75.981206' WHERE id=45653; -- Alto Avirama / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.659165', longitud='-75.981698' WHERE id=45652; -- Tres Esquinas / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.657356', longitud='-75.993319' WHERE id=45651; -- Chicaquiu / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.628804', longitud='-75.996325' WHERE id=45650; -- Chumal / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.617405', longitud='-76.001266' WHERE id=45649; -- Togoima Centro / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.600109', longitud='-75.995399' WHERE id=45648; -- La Cruz De Togoima / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.653622', longitud='-76.014334' WHERE id=45647; -- Sector Sinai / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.651058', longitud='-76.011875' WHERE id=45646; -- La Muralla / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.772866', longitud='-76.057504' WHERE id=45645; -- Huila Viejo / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.723927', longitud='-76.067842' WHERE id=45644; -- Montecruz / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.710801', longitud='-76.112432' WHERE id=45643; -- El Cuartel / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.752325', longitud='-76.047136' WHERE id=2487; -- Chachucue / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.72733', longitud='-76.050509' WHERE id=2503; -- Taravira / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.578999', longitud='-75.872183' WHERE id=2488; -- La Ceja / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.722219', longitud='-76.112581' WHERE id=2471; -- El Cabuyo / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.71993', longitud='-76.148001' WHERE id=2493; -- Mosoco / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.696547', longitud='-76.085938' WHERE id=2477; -- Lame / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.693527', longitud='-76.043495' WHERE id=2497; -- Chinas / Páez / Cauca
      UPDATE msip_centropoblado SET latitud='2.363351', longitud='-76.717327' WHERE id=45685; -- San Pedrito / Timbío / Cauca
      UPDATE msip_centropoblado SET latitud='11.805024', longitud='-72.35592' WHERE id=45844; -- Santa Rosa 2 / Manaure / La Guajira
      UPDATE msip_centropoblado SET latitud='11.81125', longitud='-72.351475' WHERE id=45843; -- Santa Rosa 1 / Manaure / La Guajira
      UPDATE msip_centropoblado SET latitud='11.776068', longitud='-72.370452' WHERE id=45842; -- Hurraychichon / Manaure / La Guajira
      UPDATE msip_centropoblado SET latitud='11.538526', longitud='-72.531051' WHERE id=45841; -- Kaasumana / Manaure / La Guajira
      UPDATE msip_centropoblado SET latitud='11.383152', longitud='-72.199092' WHERE id=45840; -- Uyatpana / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.408348', longitud='-72.218029' WHERE id=45839; -- Majayutpana / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.434224', longitud='-72.273703' WHERE id=45838; -- Carrizal / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.425785', longitud='-72.262572' WHERE id=45837; -- Aipian / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.42661', longitud='-72.255249' WHERE id=45836; -- Ichichon / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.363432', longitud='-72.274813' WHERE id=45835; -- Pulikumana / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.394103', longitud='-72.297991' WHERE id=45834; -- Maicaito / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.443159', longitud='-72.542771' WHERE id=45833; -- Ushuru / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='11.4381', longitud='-72.530088' WHERE id=45832; -- Zenuy / Maicao / La Guajira
      UPDATE msip_centropoblado SET latitud='7.078067', longitud='-70.696223' WHERE id=45885; -- La Colmena / Arauca / Arauca
      UPDATE msip_centropoblado SET latitud='7.080397', longitud='-70.788469' WHERE id=45884; -- Barrancón / Arauca / Arauca
      UPDATE msip_centropoblado SET latitud='7.078102', longitud='-70.795592' WHERE id=45883; -- Mate Candela / Arauca / Arauca
      UPDATE msip_centropoblado SET latitud='2.673701', longitud='-76.563522' WHERE id=45665; -- Villa Mercedes / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.649098', longitud='-76.552997' WHERE id=45664; -- Alto Piendamo / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.720061', longitud='-76.637876' WHERE id=2547; -- San Miguel / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.706032', longitud='-76.619654' WHERE id=2545; -- Loma Corta / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.682541', longitud='-76.606794' WHERE id=2553; -- El Carmen / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.697031', longitud='-76.58725' WHERE id=2550; -- Corrales / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='2.714849', longitud='-76.618831' WHERE id=2546; -- Santa Helena / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET latitud='9.240948', longitud='-75.478458' WHERE id=45743; -- Los Andes / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.228223', longitud='-75.465306' WHERE id=45742; -- Alta Rivera Roma / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.220915', longitud='-75.470821' WHERE id=45741; -- Costa Rica / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.158941', longitud='-75.483442' WHERE id=45740; -- Comunidad California / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.163694', longitud='-75.476326' WHERE id=45739; -- Vida Nueva / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.20638', longitud='-75.498459' WHERE id=45738; -- El Mamon / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.203823', longitud='-75.503235' WHERE id=45737; -- Nueva Unión / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.069753', longitud='-75.524612' WHERE id=45736; -- Arroyo Del Medio / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.068369', longitud='-75.531532' WHERE id=45735; -- Santa Fe / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.073111', longitud='-75.508873' WHERE id=45734; -- Peine / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='9.100369', longitud='-75.537797' WHERE id=45733; -- Guayabo Sur / San Andrés de Sotavento / Córdoba
      UPDATE msip_centropoblado SET latitud='-3.800776', longitud='-70.623228' WHERE id=13049; -- Boyahuazú / Puerto Nariño / Amazonas
      UPDATE msip_centropoblado SET latitud='0.474108', longitud='-75.174296' WHERE id=12918; -- El Mecaya / Puerto Leguízamo / Putumayo
      UPDATE msip_centropoblado SET latitud='0.330687', longitud='-75.02538' WHERE id=12916; -- Sensella / Puerto Leguízamo / Putumayo
      UPDATE msip_centropoblado SET latitud='6.534324', longitud='-71.698791' WHERE id=45886; -- Macarieros / Tame / Arauca
      UPDATE msip_centropoblado SET latitud='5.571628', longitud='-75.607524' WHERE id=45576; -- San Antonio / Caramanta / Antioquia
      UPDATE msip_centropoblado SET latitud='5.537762', longitud='-75.591925' WHERE id=45575; -- Aguadita Grande / Caramanta / Antioquia
      UPDATE msip_centropoblado SET latitud='5.581504', longitud='-75.672444' WHERE id=6749; -- Barroblanco / Caramanta / Antioquia
      UPDATE msip_centropoblado SET latitud='10.017412', longitud='-74.308719' WHERE id=45857; -- Issa Oristuna / Sabanas de San Ángel / Magdalena
      UPDATE msip_centropoblado SET latitud='11.035694', longitud='-73.647313' WHERE id=45854; -- Taminaka / Santa Marta / Magdalena
      UPDATE msip_centropoblado SET latitud='3.561613', longitud='-71.754215' WHERE id=7810; -- Alto Tillavá / Puerto Gaitán / Meta
      UPDATE msip_centropoblado SET latitud='2.439043', longitud='-73.045292' WHERE id=7831; -- La Tigra / Puerto Rico / Meta
      UPDATE msip_centropoblado SET latitud='6.962584', longitud='-76.644537' WHERE id=45578; -- Comunidad Isla 0013 / Murindó / Antioquia
      UPDATE msip_centropoblado SET latitud='9.235021', longitud='-75.404729' WHERE id=45872; -- Calle Fría (Sincelejo) / Sincelejo / Sucre
      UPDATE msip_centropoblado SET latitud='9.235263', longitud='-75.40846' WHERE id=45874; -- Calle Fría (Sampues) / Sampués / Sucre
      UPDATE msip_centropoblado SET latitud='10.738133', longitud='-73.938812' WHERE id=45856; -- Mankuaja / Ciénaga / Magdalena
      UPDATE msip_centropoblado SET latitud='10.781605', longitud='-73.920059' WHERE id=45855; -- Setay / Ciénaga / Magdalena
      UPDATE msip_centropoblado SET latitud='3.315408', longitud='-76.166485' WHERE id=45880; -- San Juan Páez / Florida / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='3.30161', longitud='-76.156551' WHERE id=12052; -- La Rivera / Florida / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='3.890059', longitud='-76.21968' WHERE id=45878; -- Conjunto Campestre Kycun / Guadalajara de Buga / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='3.886829', longitud='-76.221102' WHERE id=45877; -- Parcelación Montearroyo / Guadalajara de Buga / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='4.104238', longitud='-76.214171' WHERE id=45881; -- El Cairo / Tuluá / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='2.985713', longitud='-74.191374' WHERE id=7775; -- San Isidro / Mesetas / Meta
      UPDATE msip_centropoblado SET latitud='2.994367', longitud='-74.207546' WHERE id=7781; -- Puerto Nariño / Mesetas / Meta
      UPDATE msip_centropoblado SET latitud='3.26674', longitud='-73.992389' WHERE id=7782; -- La Argentina / Mesetas / Meta
      UPDATE msip_centropoblado SET latitud='4.035493', longitud='-68.179036' WHERE id=45913; -- Guerima / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='4.366269', longitud='-69.059251' WHERE id=45912; -- Camunianae / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='3.965914', longitud='-68.657583' WHERE id=45911; -- Caño Bocón / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='3.401846', longitud='-70.131371' WHERE id=45910; -- Guaco Alto / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='3.364312', longitud='-70.16446' WHERE id=45909; -- Guaco Bajo / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='4.363464', longitud='-70.995216' WHERE id=13158; -- Guanape / Cumaribo / Vichada
      UPDATE msip_centropoblado SET latitud='6.85952', longitud='-77.098873' WHERE id=45780; -- Mamey De Dipurdú / Carmen del Darién / Chocó
      UPDATE msip_centropoblado SET latitud='6.964012', longitud='-77.042579' WHERE id=5153; -- La Madre / Carmen del Darién / Chocó
      UPDATE msip_centropoblado SET latitud='6.927147', longitud='-77.177725' WHERE id=5145; -- Chicao / Carmen del Darién / Chocó
      UPDATE msip_centropoblado SET latitud='7.252391', longitud='-77.78483' WHERE id=45787; -- Cedral / Juradó / Chocó
      UPDATE msip_centropoblado SET latitud='7.226061', longitud='-77.787707' WHERE id=45786; -- Dos Bocas / Juradó / Chocó
      UPDATE msip_centropoblado SET latitud='7.215964', longitud='-77.785206' WHERE id=45785; -- Dichardi Wounan / Juradó / Chocó
      UPDATE msip_centropoblado SET latitud='7.290066', longitud='-77.834466' WHERE id=45784; -- Jumara Karra / Juradó / Chocó
      UPDATE msip_centropoblado SET latitud='7.350485', longitud='-77.441054' WHERE id=45818; -- Unión Chami / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.18154', longitud='-77.312007' WHERE id=45817; -- Quirapadó La Loma / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.396343', longitud='-77.442347' WHERE id=45816; -- Unión Embera Katio / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.091212', longitud='-77.398118' WHERE id=45815; --  LA TERESITA - RÍO TRUANDÓ / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.024937', longitud='-77.493624' WHERE id=45814; -- Peñas Blancas - Río Truandó / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.293493', longitud='-77.595496' WHERE id=45813; -- Pueblo Antioquia / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='7.718721', longitud='-77.377048' WHERE id=5404; -- Peranchito / Riosucio / Chocó
      UPDATE msip_centropoblado SET latitud='4.231378', longitud='-77.270774' WHERE id=14536; -- Cabecera / El Litoral del San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.360865', longitud='-76.903055' WHERE id=5230; -- Puerto Murillo / El Litoral del San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.169521', longitud='-77.304493' WHERE id=5195; -- Papayo / El Litoral del San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='5.571813', longitud='-76.913322' WHERE id=45812; -- San José De Amia / Río Quito / Chocó
      UPDATE msip_centropoblado SET latitud='5.590742', longitud='-76.844791' WHERE id=45811; -- Quijaradó / Río Quito / Chocó
      UPDATE msip_centropoblado SET latitud='5.60152', longitud='-76.859558' WHERE id=45810; -- Gengadó / Río Quito / Chocó
      UPDATE msip_centropoblado SET latitud='4.981387', longitud='-76.41115' WHERE id=45546; -- Juntas De Tamaná / San José del Palmar / Chocó
      UPDATE msip_centropoblado SET latitud='5.250538', longitud='-76.289787' WHERE id=45821; -- Tarena / Tadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.287437', longitud='-76.326142' WHERE id=45820; -- Mondó - Mondocito / Tadó / Chocó
      UPDATE msip_centropoblado SET latitud='5.262988', longitud='-76.301578' WHERE id=5474; -- Bochoromá / Tadó / Chocó
      UPDATE msip_centropoblado SET latitud='9.081342', longitud='-75.490131' WHERE id=45731; -- Bajo Palmital / Chinú / Córdoba
      UPDATE msip_centropoblado SET latitud='2.062177', longitud='-76.826051' WHERE id=45632; -- El Guayabo / La Vega / Cauca
      UPDATE msip_centropoblado SET latitud='3.195963', longitud='-76.202382' WHERE id=45637; -- El Cabildo / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.224832', longitud='-76.212182' WHERE id=45636; -- Las Cañas / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.211965', longitud='-76.211427' WHERE id=45635; -- El Crucero / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.201524', longitud='-76.215856' WHERE id=45634; -- La Unión / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.237419', longitud='-76.229638' WHERE id=45633; -- Las Palmas / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.216686', longitud='-76.203178' WHERE id=2436; -- Monterredondo / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='3.207143', longitud='-76.20938' WHERE id=2437; -- Caraqueño / Miranda / Cauca
      UPDATE msip_centropoblado SET latitud='2.719591', longitud='-76.600701' WHERE id=45642; -- Territorio Zaanann / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.759951', longitud='-76.67723' WHERE id=45641; -- Crucero De Pan De Azúcar / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.737039', longitud='-76.721756' WHERE id=45640; -- El Playón / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.755692', longitud='-76.723723' WHERE id=45639; -- El Oso / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.784146', longitud='-76.728949' WHERE id=45638; -- San José / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.76714', longitud='-76.684949' WHERE id=2445; -- San Roque / Morales / Cauca
      UPDATE msip_centropoblado SET latitud='2.436119', longitud='-76.580774' WHERE id=45594; -- Pueblo Kokonuco / Popayán / Cauca
      UPDATE msip_centropoblado SET latitud='4.767013', longitud='-76.811357' WHERE id=45799; -- Barrancocito / Nóvita / Chocó
      UPDATE msip_centropoblado SET latitud='4.978708', longitud='-76.677367' WHERE id=14560; -- Pindaza / Nóvita / Chocó
      UPDATE msip_centropoblado SET latitud='4.961428', longitud='-76.50545' WHERE id=14559; -- La Puente / Nóvita / Chocó
      UPDATE msip_centropoblado SET latitud='8.794541', longitud='-75.589646' WHERE id=45732; -- El Llano / Ciénaga de Oro / Córdoba
      UPDATE msip_centropoblado SET latitud='8.838272', longitud='-75.566812' WHERE id=3556; -- Mayoria / Ciénaga de Oro / Córdoba
      UPDATE msip_centropoblado SET latitud='4.511207', longitud='-76.628804' WHERE id=45819; -- Sanandocito / Sipí / Chocó
      UPDATE msip_centropoblado SET latitud='7.708784', longitud='-76.169208' WHERE id=45745; -- Koredo / Tierralta / Córdoba
      UPDATE msip_centropoblado SET latitud='7.717134', longitud='-76.175963' WHERE id=45744; -- Nejondo / Tierralta / Córdoba
      UPDATE msip_centropoblado SET latitud='9.217989', longitud='-75.534919' WHERE id=45751; -- Comunidad Mata De Caña / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='9.225947', longitud='-75.526588' WHERE id=45750; -- Vidalito / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='9.198984', longitud='-75.546559' WHERE id=45749; -- Pisa Bonito / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='9.240585', longitud='-75.549439' WHERE id=45748; -- Majagual / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='9.245209', longitud='-75.556203' WHERE id=45747; -- Centro Alegre / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='9.245905', longitud='-75.548846' WHERE id=45746; -- Sitio Nuevo / Tuchín / Córdoba
      UPDATE msip_centropoblado SET latitud='2.049894', longitud='-75.978046' WHERE id=14599; -- Paraguay / Oporapa / Huila
      UPDATE msip_centropoblado SET latitud='5.140558', longitud='-75.881284' WHERE id=45869; -- La Florida / Belén de Umbría / Risaralda
      UPDATE msip_centropoblado SET latitud='5.637033', longitud='-75.687779' WHERE id=45579; -- La Mirla / Támesis / Antioquia
      UPDATE msip_centropoblado SET latitud='3.77331', longitud='-75.161358' WHERE id=45876; -- Chenche Zaragoza / Coyaima / Tolima
      UPDATE msip_centropoblado SET latitud='9.275637', longitud='-75.553321' WHERE id=45873; -- Santa Ana / Palmito / Sucre
      UPDATE msip_centropoblado SET latitud='1.881573', longitud='-76.775706' WHERE id=2002; -- Hato Humus / Almaguer / Cauca
      UPDATE msip_centropoblado SET latitud='1.919492', longitud='-76.790031' WHERE id=45596; -- Dominguillo / Almaguer / Cauca
      UPDATE msip_centropoblado SET latitud='1.884846', longitud='-76.786918' WHERE id=45595; -- Potrero / Almaguer / Cauca
      UPDATE msip_centropoblado SET latitud='5.722794', longitud='-76.226199' WHERE id=45782; -- La Puria / El Carmen de Atrato / Chocó
      UPDATE msip_centropoblado SET latitud='5.486718', longitud='-77.019842' WHERE id=45759; -- Londoño / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.409426', longitud='-77.016939' WHERE id=45758; -- Punta Peña / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.40674', longitud='-77.019646' WHERE id=45757; -- Vacal / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.599022', longitud='-77.037369' WHERE id=45756; -- El Morro / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.518733', longitud='-77.067592' WHERE id=45755; -- Agua Clara / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.547492', longitud='-77.025483' WHERE id=5032; -- Puerto Libia / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.710726', longitud='-77.050755' WHERE id=5021; -- Mojaudó / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.754968', longitud='-77.06838' WHERE id=5024; -- San Francisco de Cugucho / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.693369', longitud='-77.005951' WHERE id=5030; -- Chachajó / Alto Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.773085', longitud='-77.004961' WHERE id=45772; -- Unión Pitalito / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.40607', longitud='-77.303996' WHERE id=45771; -- Comunidad Puerto Embera / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.833938', longitud='-77.258149' WHERE id=45770; -- Buena Vista / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.539023', longitud='-77.267995' WHERE id=45769; -- Playa Linda / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.385279', longitud='-77.319412' WHERE id=45768; -- Comunidad Indigena Puerto Samaria / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.862036', longitud='-77.333318' WHERE id=5099; -- Dotenedó / Bajo Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.406673', longitud='-75.224829' WHERE id=45875; -- Martinica Parte Alta / Ibagué / Tolima
      UPDATE msip_centropoblado SET latitud='3.382362', longitud='-76.351741' WHERE id=45879; -- Mirador Del Frayle / Candelaria / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='2.352265', longitud='-75.836978' WHERE id=45825; -- Fiw Paez / La Plata / Huila
      UPDATE msip_centropoblado SET latitud='2.340221', longitud='-75.847577' WHERE id=45824; -- Potrerito / La Plata / Huila
      UPDATE msip_centropoblado SET latitud='2.19776', longitud='-76.097834' WHERE id=45823; -- Estación Talaga / La Plata / Huila
      UPDATE msip_centropoblado SET latitud='0.468853', longitud='-77.144149' WHERE id=45861; -- La Libertad / Ipiales / Nariño
      UPDATE msip_centropoblado SET latitud='0.480088', longitud='-77.16503' WHERE id=45860; -- El Empalme / Ipiales / Nariño
      UPDATE msip_centropoblado SET latitud='0.414374', longitud='-77.159949' WHERE id=45859; -- Brisas Del Rumiyaco / Ipiales / Nariño
      UPDATE msip_centropoblado SET latitud='0.841758', longitud='-77.664063' WHERE id=45858; -- Los Marcos / Ipiales / Nariño
      UPDATE msip_centropoblado SET latitud='4.826551', longitud='-74.104372' WHERE id=45753; -- Los Manzanos / Cota / Cundinamarca
      UPDATE msip_centropoblado SET latitud='4.807593', longitud='-74.118388' WHERE id=45752; -- Resguardo Indigena Muisca De Cota / Cota / Cundinamarca
      UPDATE msip_centropoblado SET latitud='5.064931', longitud='-70.362662' WHERE id=13153; -- San Teodoro (La Pascua) / La Primavera / Vichada
      UPDATE msip_centropoblado SET latitud='5.963817', longitud='-67.481531' WHERE id=13145; -- Guaripa / Puerto Carreño / Vichada
      UPDATE msip_centropoblado SET latitud='1.741478', longitud='-76.825337' WHERE id=2068; -- Cimarronas / Bolívar / Cauca
      UPDATE msip_centropoblado SET latitud='2.568199', longitud='-76.563994' WHERE id=45597; -- Las Margaritas / Cajibío / Cauca
      UPDATE msip_centropoblado SET latitud='2.873759', longitud='-76.55472' WHERE id=45598; -- El Tablón / Caldono / Cauca
      UPDATE msip_centropoblado SET latitud='2.78432', longitud='-76.445058' WHERE id=2144; -- Andalucía / Caldono / Cauca
      UPDATE msip_centropoblado SET latitud='3.170445', longitud='-76.16096' WHERE id=45611; -- El Palmar / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.179362', longitud='-76.197521' WHERE id=45610; -- San Pedro / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.182667', longitud='-76.204551' WHERE id=45609; -- El Crucero / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.157556', longitud='-76.182299' WHERE id=45608; -- Yarumales / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.161536', longitud='-76.204224' WHERE id=45607; -- Altamira / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.171617', longitud='-76.20386' WHERE id=45606; -- Comunidad Quebraditas / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.158651', longitud='-76.197383' WHERE id=45605; -- Las Cruces / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.188049', longitud='-76.217383' WHERE id=45604; -- El Paraíso / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.163598', longitud='-76.224157' WHERE id=45603; -- Chicharronal / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.069613', longitud='-76.224298' WHERE id=45602; -- El Boquerón / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.102873', longitud='-76.231389' WHERE id=45601; -- La Esther / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.139406', longitud='-76.242243' WHERE id=45600; -- La Cima / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.117588', longitud='-76.246555' WHERE id=45599; -- La Capilla / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.147892', longitud='-76.287198' WHERE id=2222; -- La Maria / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.172366', longitud='-76.210358' WHERE id=2226; -- La Laguna / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.193694', longitud='-76.214595' WHERE id=2228; -- El Pedregal / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='3.112148', longitud='-76.225881' WHERE id=2219; -- Los Andes / Corinto / Cauca
      UPDATE msip_centropoblado SET latitud='2.555179', longitud='-76.002842' WHERE id=45630; -- Quiguanas / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.562157', longitud='-76.019357' WHERE id=45629; -- Capicisgo / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.563812', longitud='-76.026786' WHERE id=45628; -- Cedralia / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.584023', longitud='-76.02951' WHERE id=45627; -- Potrerito / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.583726', longitud='-76.03997' WHERE id=45626; -- El Picacho / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.554534', longitud='-76.046578' WHERE id=45625; -- Brisas Del Rio Ullucos / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.553309', longitud='-76.052393' WHERE id=45624; -- San Francisco / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.555649', longitud='-76.0395' WHERE id=45623; -- El Hato / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.557915', longitud='-76.031354' WHERE id=45622; -- El Llanito / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.59874', longitud='-76.046699' WHERE id=45621; -- El Mesón / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.553097', longitud='-76.063055' WHERE id=45620; -- El Guayabal / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.521631', longitud='-76.058397' WHERE id=45619; -- La Palma / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.479491', longitud='-76.057645' WHERE id=45618; -- El Rincón / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.577866', longitud='-76.064342' WHERE id=45617; -- Lomitas / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.45351', longitud='-76.064155' WHERE id=45616; -- Yarumal / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.524769', longitud='-76.095524' WHERE id=45615; -- El Cabuyo / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.553963', longitud='-76.013923' WHERE id=2328; -- Segovia / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.470051', longitud='-76.039051' WHERE id=2326; -- San Miguel / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.528631', longitud='-76.080075' WHERE id=2337; -- Guanacas / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.460779', longitud='-76.053932' WHERE id=2336; -- Santa Teresa / Inzá / Cauca
      UPDATE msip_centropoblado SET latitud='2.206481', longitud='-76.753126' WHERE id=45631; -- Frontino Alto / La Sierra / Cauca
      UPDATE msip_centropoblado SET latitud='2.320448', longitud='-76.486443' WHERE id=45669; -- San José Pisanrabo / Puracé / Cauca
      UPDATE msip_centropoblado SET latitud='2.342403', longitud='-76.499145' WHERE id=45668; -- Belén / Puracé / Cauca
      UPDATE msip_centropoblado SET latitud='2.333706', longitud='-76.499688' WHERE id=45667; -- San Pedrillo / Puracé / Cauca
      UPDATE msip_centropoblado SET latitud='2.323129', longitud='-76.501849' WHERE id=45666; -- San Bartolo / Puracé / Cauca
      UPDATE msip_centropoblado SET latitud='1.930321', longitud='-76.742098' WHERE id=45671; -- Florida / San Sebastián / Cauca
      UPDATE msip_centropoblado SET latitud='1.880907', longitud='-76.751534' WHERE id=45670; -- Santander / San Sebastián / Cauca
      UPDATE msip_centropoblado SET latitud='1.894633', longitud='-76.743586' WHERE id=2600; -- Marmato / San Sebastián / Cauca
      UPDATE msip_centropoblado SET latitud='2.551778', longitud='-76.295417' WHERE id=45683; -- Santa Lucia / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.708173', longitud='-76.314363' WHERE id=45682; -- La Esperanza / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.631671', longitud='-76.313177' WHERE id=45681; -- Peña Del Corazón / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.765671', longitud='-76.329373' WHERE id=45680; -- Mariposas / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.735081', longitud='-76.331399' WHERE id=45679; -- La Ovejera 1 / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.738775', longitud='-76.340596' WHERE id=45678; -- Ovejeras / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.693446', longitud='-76.332973' WHERE id=45677; -- Buenavista Pitayó / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.700097', longitud='-76.341979' WHERE id=45676; -- Buenavista / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.627361', longitud='-76.345645' WHERE id=45675; -- Delicias / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.624492', longitud='-76.354661' WHERE id=45674; -- Las Tapias / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.637091', longitud='-76.357413' WHERE id=45673; -- Los Bujios / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.626162', longitud='-76.376554' WHERE id=45672; -- Tengo / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.685534', longitud='-76.305988' WHERE id=2665; -- Mendez / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.631561', longitud='-76.326934' WHERE id=2657; -- Puente Real / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.626241', longitud='-76.291834' WHERE id=2668; -- Campana / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.628519', longitud='-76.303542' WHERE id=2670; -- Pueblito / Silvia / Cauca
      UPDATE msip_centropoblado SET latitud='2.828593', longitud='-77.591525' WHERE id=45686; -- Calle Santa Rosa / Timbiquí / Cauca
      UPDATE msip_centropoblado SET latitud='2.519929', longitud='-76.318102' WHERE id=45726; -- San Pedro Del Bosque / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.526002', longitud='-76.361074' WHERE id=45725; -- Gallinazo / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.521172', longitud='-76.366601' WHERE id=45724; -- Pedragal / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.511053', longitud='-76.374457' WHERE id=45723; -- Betania / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.562159', longitud='-76.466077' WHERE id=45722; -- Hatoviejo / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.562346', longitud='-76.5035' WHERE id=45721; -- Buenavista Tatawala / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.581482', longitud='-76.528028' WHERE id=45720; -- Alto Buenavista / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.513149', longitud='-76.515216' WHERE id=45719; -- El Porvenir / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.515477', longitud='-76.527998' WHERE id=45718; -- Bajo Palacé / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.582948', longitud='-76.470447' WHERE id=2767; -- Jebalá / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='2.488297', longitud='-76.404395' WHERE id=2763; -- Polindará / Totoró / Cauca
      UPDATE msip_centropoblado SET latitud='5.370303', longitud='-76.517072' WHERE id=45781; -- Pared Y Parecito / Cértegui / Chocó
      UPDATE msip_centropoblado SET latitud='5.021721', longitud='-76.516852' WHERE id=5172; -- Consuelo Andrapeda / Condoto / Chocó
      UPDATE msip_centropoblado SET latitud='5.042956', longitud='-76.493772' WHERE id=5167; -- La Planta / Condoto / Chocó
      UPDATE msip_centropoblado SET latitud='4.579563', longitud='-76.99208' WHERE id=45783; -- Puerto Olave / Istmina / Chocó
      UPDATE msip_centropoblado SET latitud='4.555457', longitud='-77.053517' WHERE id=5254; -- San Cristobal / Istmina / Chocó
      UPDATE msip_centropoblado SET latitud='5.633892', longitud='-76.336998' WHERE id=45793; -- Aguacate / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.635049', longitud='-76.351242' WHERE id=45792; -- Río Mumbú / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.614668', longitud='-76.403125' WHERE id=45791; -- Río Capa / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.608253', longitud='-76.401057' WHERE id=45790; -- Cruces Parte Alta / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.469637', longitud='-76.405858' WHERE id=45789; -- Kipara / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.620592', longitud='-76.440071' WHERE id=45788; -- Tegavera / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='5.6015', longitud='-76.399713' WHERE id=5293; -- Guaitadó / Lloró / Chocó
      UPDATE msip_centropoblado SET latitud='6.033154', longitud='-76.714259' WHERE id=45794; -- Río Bebarama / Medio Atrato / Chocó
      UPDATE msip_centropoblado SET latitud='6.108101', longitud='-76.915261' WHERE id=5303; -- San Antonio del Buey (Campo Santo) / Medio Atrato / Chocó
      UPDATE msip_centropoblado SET latitud='6.00634', longitud='-76.674972' WHERE id=5306; -- El Llano de Bebaramá / Medio Atrato / Chocó
      UPDATE msip_centropoblado SET latitud='5.150071', longitud='-77.078387' WHERE id=45797; -- Puerto Nuncidó / Medio Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.163761', longitud='-77.08202' WHERE id=45796; -- Guadualito / Medio Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.155614', longitud='-77.087749' WHERE id=45795; -- Río Chimani / Medio Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.954462', longitud='-77.124866' WHERE id=5315; -- Unión Misara / Medio Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='5.206475', longitud='-76.868445' WHERE id=5319; -- San Miguel Baudocito / Medio Baudó / Chocó
      UPDATE msip_centropoblado SET latitud='4.659057', longitud='-76.936715' WHERE id=45798; -- Unión Wounnaan / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.708847', longitud='-76.864258' WHERE id=45544; -- Chambacú / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.69561', longitud='-76.92205' WHERE id=5344; -- Puerto Murillo / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.902268', longitud='-76.845362' WHERE id=5339; -- La Unión / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.606527', longitud='-76.918938' WHERE id=5331; -- Fujiadó / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.688287', longitud='-76.9336' WHERE id=5336; -- Noanamá / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='4.979648', longitud='-76.790552' WHERE id=5345; -- La Rancha / Medio San Juan / Chocó
      UPDATE msip_centropoblado SET latitud='3.759905', longitud='-76.463741' WHERE id=45882; -- Wasiruma / Vijes / Valle del Cauca
      UPDATE msip_centropoblado SET latitud='2.255012', longitud='-78.256172' WHERE id=45863; -- Chapil / Olaya Herrera / Nariño
      UPDATE msip_centropoblado SET latitud='2.201352', longitud='-78.214722' WHERE id=45862; -- San Jose Roble / Olaya Herrera / Nariño
      UPDATE msip_centropoblado SET latitud='1.828634', longitud='-77.547819' WHERE id=8532; -- Santa Cruz / Policarpa / Nariño
      UPDATE msip_centropoblado SET latitud='1.794927', longitud='-77.600329' WHERE id=8531; -- Sánchez / Policarpa / Nariño
      UPDATE msip_centropoblado SET latitud='1.776347', longitud='-77.56329' WHERE id=8534; -- San Roque (Buenavista) / Policarpa / Nariño
      UPDATE msip_centropoblado SET latitud='1.219703', longitud='-77.997754' WHERE id=45865; -- Eden Cartagena / Ricaurte / Nariño
      UPDATE msip_centropoblado SET latitud='1.21724', longitud='-78.041189' WHERE id=45864; -- Cuaiquer / Ricaurte / Nariño
      UPDATE msip_centropoblado SET latitud='1.430555', longitud='-78.331464' WHERE id=45867; -- Kilómetro 88 / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.759405', longitud='-78.444011' WHERE id=8775; -- Guabal / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.62318', longitud='-78.611673' WHERE id=8903; -- El Coco / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.642662', longitud='-78.456914' WHERE id=8878; -- Palay / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.734061', longitud='-78.482977' WHERE id=8884; -- La Sirena / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.659873', longitud='-78.453488' WHERE id=8939; -- Salisví / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='1.683094', longitud='-78.831078' WHERE id=8860; -- Descolgadero / San Andrés de Tumaco / Nariño
      UPDATE msip_centropoblado SET latitud='3.00803', longitud='-76.205542' WHERE id=45717; -- La Calera / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.013761', longitud='-76.210486' WHERE id=45716; -- La Tolda / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.046489', longitud='-76.222955' WHERE id=45715; -- La Playa / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.91679', longitud='-76.219617' WHERE id=45714; -- Puente Quemado / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.019539', longitud='-76.223972' WHERE id=45713; -- Asomadero / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.048451', longitud='-76.232502' WHERE id=45712; -- Triunfo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.048218', longitud='-76.23845' WHERE id=45711; -- Gargantillas / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.038453', longitud='-76.233678' WHERE id=45710; -- Soto / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.027619', longitud='-76.23757' WHERE id=45709; -- Gallinazas / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.012502', longitud='-76.233631' WHERE id=45708; -- Chimicueto / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.000712', longitud='-76.238988' WHERE id=45707; -- La Albania / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.047538', longitud='-76.246638' WHERE id=45706; -- La Capilla / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.007073', longitud='-76.244903' WHERE id=45705; -- San Diego / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.944417', longitud='-76.242545' WHERE id=45704; -- El Sesteadero / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.990874', longitud='-76.252225' WHERE id=45703; -- El Congo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.037226', longitud='-76.256621' WHERE id=45702; -- La Susana / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.015778', longitud='-76.259108' WHERE id=45701; -- Buenavista / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.990183', longitud='-76.259896' WHERE id=45700; -- Belén / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.945356', longitud='-76.258136' WHERE id=45699; -- La Bodega / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.972627', longitud='-76.265581' WHERE id=45698; -- Vichiqui / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.964221', longitud='-76.266151' WHERE id=45697; -- Loma Linda / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.038852', longitud='-76.266132' WHERE id=45696; -- El Trapiche / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.043795', longitud='-76.277591' WHERE id=45695; -- La Maria Tacueyo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.034162', longitud='-76.282165' WHERE id=45694; -- Damian / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.986799', longitud='-76.269419' WHERE id=45693; -- San Julian / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.912103', longitud='-76.288782' WHERE id=45692; -- Sector Piedra Mula / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.917335', longitud='-76.28423' WHERE id=45691; -- El Flayo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.897317', longitud='-76.287826' WHERE id=45690; -- La Primicia / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.994739', longitud='-76.297866' WHERE id=45689; -- La Pila / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.949939', longitud='-76.300876' WHERE id=45688; -- Naranjo Centro / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.062293', longitud='-76.22521' WHERE id=45687; -- La Esperanza / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.937315', longitud='-76.234641' WHERE id=2751; -- El Tablazo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.011811', longitud='-76.159078' WHERE id=2754; -- Santo Domingo / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.006074', longitud='-76.287538' WHERE id=2755; -- Natala / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.014101', longitud='-76.279847' WHERE id=2756; -- La Despensa / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='3.004059', longitud='-76.24928' WHERE id=2753; -- La Cruz / Toribío / Cauca
      UPDATE msip_centropoblado SET latitud='2.436785', longitud='-76.845755' WHERE id=45614; -- San Roque Cañaveral / El Tambo / Cauca
      UPDATE msip_centropoblado SET latitud='2.43907', longitud='-76.834433' WHERE id=45613; -- Zarzalito / El Tambo / Cauca
      UPDATE msip_centropoblado SET latitud='2.434978', longitud='-76.842237' WHERE id=45612; -- La Venta / El Tambo / Cauca
      UPDATE msip_centropoblado SET latitud='2.594927', longitud='-77.016577' WHERE id=2255; -- Playa Rica / El Tambo / Cauca
      UPDATE msip_centropoblado SET latitud='2.436598', longitud='-77.071416' WHERE id=2248; -- Los Andes / El Tambo / Cauca
      UPDATE msip_centropoblado SET latitud='5.508096', longitud='-75.717791' WHERE id=45593; -- Bermejal / Riosucio / Caldas
      UPDATE msip_centropoblado SET latitud='6.289537', longitud='-76.600449' WHERE id=45581; -- Guaguandó / Vigía del Fuerte / Antioquia
      UPDATE msip_centropoblado SET latitud='6.458107', longitud='-76.676227' WHERE id=45580; -- El Salado / Vigía del Fuerte / Antioquia
      UPDATE msip_centropoblado SET latitud='10.30622', longitud='-75.383567' WHERE id=45592; -- Villa Del Palmar / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.298716', longitud='-75.401541' WHERE id=45591; -- Brisas Del Oriente / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.33335', longitud='-75.376582' WHERE id=45590; -- Condominio El Roble / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.361403', longitud='-75.362478' WHERE id=45589; -- Praga / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.35774', longitud='-75.385423' WHERE id=45588; -- Urbanización Los Naranjos / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.362423', longitud='-75.390339' WHERE id=45587; -- Oasis De Campaña / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.341582', longitud='-75.384831' WHERE id=45586; -- Arroyo Grande / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.352961', longitud='-75.40651' WHERE id=45585; -- Casas Marsella / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.351987', longitud='-75.412961' WHERE id=45584; -- Conjunto La Victoria / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='10.382242', longitud='-75.416037' WHERE id=45583; -- La Pepita / Turbaco / Bolívar
      UPDATE msip_centropoblado SET latitud='2.081577', longitud='-72.211473' WHERE id=15194; -- La Paz / El Retorno / Guaviare
      UPDATE msip_centropoblado SET latitud='2.545284', longitud='-72.650188' WHERE id=45907; -- Condominio Los Laureles / San José del Guaviare / Guaviare
      UPDATE msip_centropoblado SET latitud='2.812472', longitud='-70.545937' WHERE id=45906; -- Corocoro / San José del Guaviare / Guaviare
      UPDATE msip_centropoblado SET latitud='8.629993', longitud='-73.100385' WHERE id=14789; -- La Campana / El Tarra / Norte de Santander
      UPDATE msip_centropoblado SET latitud='8.611814', longitud='-73.150173' WHERE id=9224; -- El Paso / El Tarra / Norte de Santander
      UPDATE msip_centropoblado SET latitud='7.038372', longitud='-73.16502' WHERE id=45871; -- Vientos De Llanada / Girón / Santander
      UPDATE msip_centropoblado SET latitud='7.044284', longitud='-73.152709' WHERE id=45870; -- Llanadas / Girón / Santander
      UPDATE msip_centropoblado SET latitud='7.037938', longitud='-73.155972' WHERE id=10154; -- Barbosa / Girón / Santander
      UPDATE msip_centropoblado SET latitud='7.35916', longitud='-76.90289' WHERE id=45808; -- 7 De Agosto / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.327508', longitud='-76.817938' WHERE id=45807; -- Santa Maria / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.346028', longitud='-76.889049' WHERE id=45806; -- Playa Roja / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.458866', longitud='-76.689602' WHERE id=45805; -- Nuevo Oriente / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.509061', longitud='-76.826581' WHERE id=45804; -- Macondo / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.367724', longitud='-76.885112' WHERE id=45803; -- La Punta / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.315101', longitud='-76.766464' WHERE id=45802; -- Brisas / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.547212', longitud='-76.809534' WHERE id=45801; -- Blanquiset / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='7.3719', longitud='-76.71727' WHERE id=45800; -- Belén De Bajirá / Nuevo Belén de Bajirá / Chocó
      UPDATE msip_centropoblado SET latitud='2.285678', longitud='-76.602342' WHERE id=45684; -- La Catana / Sotará - Paispamba / Cauca
      UPDATE msip_centropoblado SET latitud='2.36234', longitud='-76.647195' WHERE id=2680; -- Asentamiento Indigena Sachacoco / Sotará - Paispamba / Cauca
    SQL
  end
  def down
    execute <<-SQL
      -- Centros poblados con nombres cambiados

      UPDATE msip_centropoblado SET nombre='San Jose De Villa Andrea', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15171; -- AMAZONAS/PUERTO NARIÑO
      UPDATE msip_centropoblado SET nombre='Nuevo Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15169; -- AMAZONAS/PUERTO NARIÑO
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Canaan', observaciones='Aparece en DIVIPOLA 2018. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA CANAAN. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA CANAAN.' WHERE id=15164; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Nuevo Jardin', observaciones='Cambio basado en DIVIPOLA 2018. Antes era COMUNIDAD INDIGENA NUEVO JARDIN. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDÍGENA NUEVO JARDIN 91001025. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDÍGENA NUEVO JARDIN 91001025.' WHERE id=13005; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Asentamiento Humano Takana  Km 11', observaciones='Cambio basado en DIVIPOLA 2018. Antes era ASENTAMIENTO HUMANO TAKANA KM 11. Nombre de DIVIPOLA 2019, el anterior era ASENTAMIENTO HUMANO TAKANA KM 11 (MULTIÉTNICA). Nombre de DIVIPOLA 2019, el anterior era ASENTAMIENTO HUMANO TAKANA KM 11 (MULTIÉTNICA).' WHERE id=13019; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Comunidad Indígena Patio De Ciencia Dulce  Km 11', observaciones='Cambio basado en DIVIPOLA 2018. Antes era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11. Nombre de DIVIPOLA 2019, el anterior era COMUNIDAD INDIGENA PATIO DE CIENCIA DULCE KM 11.' WHERE id=13016; -- AMAZONAS/LETICIA
      UPDATE msip_centropoblado SET nombre='Rio Blanco', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15160; -- PUTUMAYO/VILLAGARZÓN
      UPDATE msip_centropoblado SET nombre='El Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15155; -- PUTUMAYO/SAN MIGUEL
      UPDATE msip_centropoblado SET nombre='Jordán Ortíz', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=15150; -- PUTUMAYO/SAN MIGUEL
      UPDATE msip_centropoblado SET nombre='Sagrado Corazon De Jesus', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15142; -- PUTUMAYO/SIBUNDOY
      UPDATE msip_centropoblado SET nombre='El Bombon', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=15139; -- PUTUMAYO/PUERTO GUZMÁN
      UPDATE msip_centropoblado SET nombre='El Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15132; -- PUTUMAYO/ORITO
      UPDATE msip_centropoblado SET nombre='El Triunfo', observaciones='Agregado en DIVIPOLA 2023-07.' WHERE id=45565; -- CASANARE/VILLANUEVA
      UPDATE msip_centropoblado SET nombre='Dos Quebradas', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. Rehabilitado por DIVIPOLA 2019 el 2020-07-23, nombre anterior: DOS QUEBRADAS. Rehabilitado por DIVIPOLA 2019 el 2020-07-23, nombre anterior: DOS QUEBRADAS. Nombre cambiando en DIVIPOLA 2021, antes era DOSQUEBRADAS. Nombre cambiando en DIVIPOLA 2021, antes era DOSQUEBRADAS' WHERE id=12351; -- VALLE DEL CAUCA/TRUJILLO
      UPDATE msip_centropoblado SET nombre='La Union', observaciones='' WHERE id=12157; -- VALLE DEL CAUCA/PALMIRA
      UPDATE msip_centropoblado SET nombre='El Edén', observaciones='Agregado en DIVIPOLA 2022.' WHERE id=15440; -- VALLE DEL CAUCA/DAGUA
      UPDATE msip_centropoblado SET nombre='El Vinculo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=11793; -- VALLE DEL CAUCA/GUADALAJARA DE BUGA
      UPDATE msip_centropoblado SET nombre='Zaragoza Puente San Martin 2', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15063; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='Zaragoza Puente San Martin 1', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15062; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='San Antoñito (Yurumangui)', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era SAN ANTOÑITO(YURUMANGUI).' WHERE id=11704; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='Joaquincito Resguardo Indigena', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM.' WHERE id=11701; -- VALLE DEL CAUCA/BUENAVENTURA
      UPDATE msip_centropoblado SET nombre='Parcelacion La Trinidad', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15036; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Parcelacion Cantaclaro 2', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15035; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Parcelacion Cantaclaro 1', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=15034; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Amstercol Ii', observaciones='' WHERE id=11576; -- VALLE DEL CAUCA/SANTIAGO DE CALI
      UPDATE msip_centropoblado SET nombre='Invasion Bella Isla De Llanitos', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=15012; -- TOLIMA/IBAGUÉ
      UPDATE msip_centropoblado SET nombre='Guami', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=10842; -- SUCRE/PALMITO
      UPDATE msip_centropoblado SET nombre='Charcon', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14963; -- SUCRE/LOS PALMITOS
      UPDATE msip_centropoblado SET nombre='La Concepcion', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14961; -- SUCRE/LA UNIÓN
      UPDATE msip_centropoblado SET nombre='Milan', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14949; -- SUCRE/COROZAL
      UPDATE msip_centropoblado SET nombre='El Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14944; -- SUCRE/COLOSÓ
      UPDATE msip_centropoblado SET nombre='Pena Blanca', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14931; -- SANTANDER/VÉLEZ
      UPDATE msip_centropoblado SET nombre='Eden', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14909; -- SANTANDER/PIEDECUESTA
      UPDATE msip_centropoblado SET nombre='Rio De Oro', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14899; -- SANTANDER/GIRÓN
      UPDATE msip_centropoblado SET nombre='Cienaga De Opon', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14876; -- SANTANDER/BARRANCABERMEJA
      UPDATE msip_centropoblado SET nombre='Condominio El Paraiso', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14849; -- RISARALDA/PEREIRA
      UPDATE msip_centropoblado SET nombre='Recta Los Alamos', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14786; -- NORTE DE SANTANDER/CHINÁCOTA
      UPDATE msip_centropoblado SET nombre='Piñuela Rio Mira', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=8949; -- NARIÑO/SAN ANDRÉS DE TUMACO
      UPDATE msip_centropoblado SET nombre='San Jose Del Guayabo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=8855; -- NARIÑO/SAN ANDRÉS DE TUMACO
      UPDATE msip_centropoblado SET nombre='Urbanizacion Villa Cafelina', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14764; -- NARIÑO/SANDONÁ
      UPDATE msip_centropoblado SET nombre='Bolivar', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14733; -- NARIÑO/LA LLANADA
      UPDATE msip_centropoblado SET nombre='Santa Barbara', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=7882; -- NARIÑO/PASTO
      UPDATE msip_centropoblado SET nombre='El Paraiso Mejor Vivir', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14711; -- META/SAN MARTÍN
      UPDATE msip_centropoblado SET nombre='Rincon Del Indio', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM.' WHERE id=14694; -- META/MAPIRIPÁN
      UPDATE msip_centropoblado SET nombre='Rincon De Pompeya', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=7691; -- META/VILLAVICENCIO
      UPDATE msip_centropoblado SET nombre='Monteria', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14677; -- MAGDALENA/ZONA BANANERA
      UPDATE msip_centropoblado SET nombre='Rio De Piedra Ii', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14655; -- MAGDALENA/ARACATACA
      UPDATE msip_centropoblado SET nombre='Nuevo Mejico', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14644; -- MAGDALENA/SANTA MARTA
      UPDATE msip_centropoblado SET nombre='Villa Fatima', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14639; -- LA GUAJIRA/URIBIA
      UPDATE msip_centropoblado SET nombre='Paraiso', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14634; -- LA GUAJIRA/URIBIA
      UPDATE msip_centropoblado SET nombre='Arroyo Limon', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14626; -- LA GUAJIRA/MANAURE
      UPDATE msip_centropoblado SET nombre='Rio Jerez', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14614; -- LA GUAJIRA/DIBULLA
      UPDATE msip_centropoblado SET nombre='Bajo Junin', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14595; -- HUILA/ISNOS
      UPDATE msip_centropoblado SET nombre='La Teresita - Río Truandó', observaciones='Agregado en DIVIPOLA 2025-01.' WHERE id=45815; -- CHOCÓ/RIOSUCIO
      UPDATE msip_centropoblado SET nombre='Jovi', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=5369; -- CHOCÓ/NUQUÍ
      UPDATE msip_centropoblado SET nombre='Curundo La Loma', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14556; -- CHOCÓ/MEDIO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Boca De Curundo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14555; -- CHOCÓ/MEDIO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Baudo Grande', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14549; -- CHOCÓ/MEDIO ATRATO
      UPDATE msip_centropoblado SET nombre='Canchido', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14543; -- CHOCÓ/LLORÓ
      UPDATE msip_centropoblado SET nombre='Union Guaimia', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14538; -- CHOCÓ/EL LITORAL DEL SAN JUAN
      UPDATE msip_centropoblado SET nombre='Santa Catalina De Catru', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=5029; -- CHOCÓ/ALTO BAUDÓ
      UPDATE msip_centropoblado SET nombre='Campobonito', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=4971; -- CHOCÓ/QUIBDÓ
      UPDATE msip_centropoblado SET nombre='San Francisco De Quibdo', observaciones='' WHERE id=4960; -- CHOCÓ/QUIBDÓ
      UPDATE msip_centropoblado SET nombre='Malagon', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14512; -- CUNDINAMARCA/ZIPAQUIRÁ
      UPDATE msip_centropoblado SET nombre='Chico Norte', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14499; -- CUNDINAMARCA/TOCANCIPÁ
      UPDATE msip_centropoblado SET nombre='El Pencil', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era EL PENCIL (SANTA BARBARA).' WHERE id=4791; -- CUNDINAMARCA/TABIO
      UPDATE msip_centropoblado SET nombre='Santa Ines', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPM.' WHERE id=4716; -- CUNDINAMARCA/SASAIMA
      UPDATE msip_centropoblado SET nombre='Villa Shyn (Casas Moviles)', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era VILLA SHYN(CASA MOVILES).' WHERE id=4679; -- CUNDINAMARCA/SAN ANTONIO DEL TEQUENDAMA
      UPDATE msip_centropoblado SET nombre='Rio Blanco - Los Puentes', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era RIO BLANCO -LOS PUENTES.' WHERE id=4423; -- CUNDINAMARCA/FUSAGASUGÁ
      UPDATE msip_centropoblado SET nombre='El Triunfo Boqueron', observaciones='Nombre cambiado por DIVIPOLA 2018. Antes era EL TRIUNFO.' WHERE id=4420; -- CUNDINAMARCA/FUSAGASUGÁ
      UPDATE msip_centropoblado SET nombre='San Rafael  Bajo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=4385; -- CUNDINAMARCA/FACATATIVÁ
      UPDATE msip_centropoblado SET nombre='Santa Barbara', observaciones='' WHERE id=4307; -- CUNDINAMARCA/CHÍA
      UPDATE msip_centropoblado SET nombre='Rincon De Fagua', observaciones='' WHERE id=4313; -- CUNDINAMARCA/CHÍA
      UPDATE msip_centropoblado SET nombre='Urbanizacion Tierra De Ensueño', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14455; -- CUNDINAMARCA/CACHIPAY
      UPDATE msip_centropoblado SET nombre='El Darien', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14418; -- CÓRDOBA/SAN BERNARDO DEL VIENTO
      UPDATE msip_centropoblado SET nombre='Punta Bolivar', observaciones='' WHERE id=3941; -- CÓRDOBA/SAN ANTERO
      UPDATE msip_centropoblado SET nombre='La Musica', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14407; -- CÓRDOBA/SAHAGÚN
      UPDATE msip_centropoblado SET nombre='La Union', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=3745; -- CÓRDOBA/MOÑITOS
      UPDATE msip_centropoblado SET nombre='Villa Concepcion', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=3659; -- CÓRDOBA/LORICA
      UPDATE msip_centropoblado SET nombre='Los Angeles', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=3513; -- CÓRDOBA/CHINÚ
      UPDATE msip_centropoblado SET nombre='Medellin - Sapo', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14379; -- CÓRDOBA/MONTERÍA
      UPDATE msip_centropoblado SET nombre='Terraplen', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=3128; -- CESAR/SAN MARTÍN
      UPDATE msip_centropoblado SET nombre='La Union', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14357; -- CESAR/CHIMICHAGUA
      UPDATE msip_centropoblado SET nombre='Zapati', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2960; -- CESAR/CHIMICHAGUA
      UPDATE msip_centropoblado SET nombre='La Vega  Arriba', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2857; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Raices', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2900; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Los Haticos  I', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2868; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='Valencia De Jesus', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2864; -- CESAR/VALLEDUPAR
      UPDATE msip_centropoblado SET nombre='La Mesa De Belalcazar', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14325; -- CAUCA/PÁEZ
      UPDATE msip_centropoblado SET nombre='Tulipan', observaciones='' WHERE id=2433; -- CAUCA/MIRANDA
      UPDATE msip_centropoblado SET nombre='San Jose De Guare', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=2295; -- CAUCA/GUAPI
      UPDATE msip_centropoblado SET nombre='Cienaga Honda', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14292; -- CAUCA/GUACHENÉ
      UPDATE msip_centropoblado SET nombre='Puente Del Río Timbio', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14287; -- CAUCA/EL TAMBO
      UPDATE msip_centropoblado SET nombre='Isla Del Ponton', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=14278; -- CAUCA/CAJIBÍO
      UPDATE msip_centropoblado SET nombre='La Esperanza (Jardines De Paz)', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=1963; -- CAUCA/POPAYÁN
      UPDATE msip_centropoblado SET nombre='Vereda La Union', observaciones='' WHERE id=1677; -- CALDAS/SALAMINA
      UPDATE msip_centropoblado SET nombre='Santagueda', observaciones='No está en DIVIPOLA 2018. Vuelve a aparecer en DIVIPOLA 2023-07.' WHERE id=1622; -- CALDAS/PALESTINA
      UPDATE msip_centropoblado SET nombre='Jimenez Bajo', observaciones='' WHERE id=1576; -- CALDAS/MARMATO
      UPDATE msip_centropoblado SET nombre='Jimenez Alto', observaciones='' WHERE id=1581; -- CALDAS/MARMATO
      UPDATE msip_centropoblado SET nombre='Condominio Reserva De Los Alamos', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14240; -- CALDAS/MANIZALES
      UPDATE msip_centropoblado SET nombre='Kilometro 41 - Colombia', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=1459; -- CALDAS/MANIZALES
      UPDATE msip_centropoblado SET nombre='La Fabrica', observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS.' WHERE id=1263; -- BOYACÁ/SAMACÁ
      UPDATE msip_centropoblado SET nombre='Guaquira', observaciones='' WHERE id=1161; -- BOYACÁ/NOBSA
      UPDATE msip_centropoblado SET nombre='Chameza Mayor', observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era CAS.' WHERE id=1162; -- BOYACÁ/NOBSA
      UPDATE msip_centropoblado SET nombre='Turbaná', observaciones='' WHERE id=839; -- BOLÍVAR/TURBANÁ
      UPDATE msip_centropoblado SET nombre='Urbanizacion Zapote', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14224; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanizacion Catalina', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14223; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanizacion Campestre', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14222; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Urbanizacion Villa De Calatrava', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14221; -- BOLÍVAR/TURBACO
      UPDATE msip_centropoblado SET nombre='Puerto Gaitan', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14219; -- BOLÍVAR/TIQUISIO
      UPDATE msip_centropoblado SET nombre='Animas Altas', observaciones='' WHERE id=799; -- BOLÍVAR/SIMITÍ
      UPDATE msip_centropoblado SET nombre='La Union Cabecera', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14205; -- BOLÍVAR/PINILLOS
      UPDATE msip_centropoblado SET nombre='La Union', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=672; -- BOLÍVAR/PINILLOS
      UPDATE msip_centropoblado SET nombre='El Corcovado', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=653; -- BOLÍVAR/MORALES
      UPDATE msip_centropoblado SET nombre='Pital Del Carlín (Pitalito)', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.' WHERE id=12521; -- ATLÁNTICO/POLONUEVO
      UPDATE msip_centropoblado SET nombre='Parcelacion Santa Maria Del Llano', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14118; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Parcelacion Camelot', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14110; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Parcelacion Andalucia', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14109; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='Jamaica Parcelacion Campestre', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14107; -- ANTIOQUIA/RIONEGRO
      UPDATE msip_centropoblado SET nombre='El Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14071; -- ANTIOQUIA/GIRARDOTA
      UPDATE msip_centropoblado SET nombre='Parcelación Alamos Del Escobero', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14054; -- ANTIOQUIA/ENVIGADO
      UPDATE msip_centropoblado SET nombre='El Chingui  2', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14051; -- ANTIOQUIA/ENVIGADO
      UPDATE msip_centropoblado SET nombre='Fatima', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14045; -- ANTIOQUIA/EBÉJICO
      UPDATE msip_centropoblado SET nombre='Travesias', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.' WHERE id=14017; -- ANTIOQUIA/BRICEÑO
      UPDATE msip_centropoblado SET nombre='El Paraiso', observaciones='Aparece en DIVIPOLA 2018.' WHERE id=14010; -- ANTIOQUIA/BARBOSA
      
        -- Nuevos codigos de centros poblados
      DELETE FROM msip_centropoblado WHERE id>=45574 AND id<=45913;

      -- Vuelve a habilitar con nombres diferentes

      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='', nombre='La Ribera' WHERE id=12052; --La Ribera / Florida / Valle del Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='San Cristóbal' WHERE id=5254; --San Cristóbal / Istmina / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.', nombre='Mayoría' WHERE id=3556; --Mayoría / Ciénaga de Oro / Córdoba
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.', nombre='Jevala' WHERE id=2767; --Jevala / Totoró / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='Polindara' WHERE id=2763; --Polindara / Totoró / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.', nombre='Sachacoco' WHERE id=2680; --Sachacoco / Sotará - Paispamba / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='Méndez' WHERE id=2665; --Méndez / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.', nombre='La Campana' WHERE id=2668; --La Campana / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='Pueblecito' WHERE id=2670; --Pueblecito / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='', nombre='Corrales San Pedro' WHERE id=2550; --Corrales San Pedro / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='La María' WHERE id=2222; --La María / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.', nombre='Tierrero' WHERE id=2204; --Tierrero / Caloto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='', nombre='Cimarrones' WHERE id=2068; --Cimarrones / Bolívar / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.', nombre='Humos' WHERE id=2002; --Humos / Almaguer / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.', nombre='Barro Blanco' WHERE id=6749; --Barro Blanco / Caramanta / Antioquia
      
      -- Deshabilitados con mismo nombre

      UPDATE msip_centropoblado SET fechadeshabilitacion='2022-07-21', observaciones='Aparece en DIVIPOLA 2018. Nombre de DIVIPOLA 2019, el anterior era MINITAS. No está en DIVIPOLA 2022.'  WHERE id=15176; --Minitas / Barrancominas / Guainía
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=12860; --San Juan Vides / Orito / Putumayo
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=10154; --Barbosa / Girón / Santander
      UPDATE msip_centropoblado SET fechadeshabilitacion='2022-02-13', observaciones='Tipo de centro cambiado por DIVIPOLA 2018. Antes era IPD. No está en DIVIPOLA 2021.'  WHERE id=7862; --Campo Alegre / Vistahermosa / Meta
      UPDATE msip_centropoblado SET fechadeshabilitacion='2023-07-21', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.'  WHERE id=5980; --La Gloria / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion='2023-07-21', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.'  WHERE id=5976; --Guamachito / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion='2023-07-21', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2023-07.'  WHERE id=5983; --Cerro Alto / Hatonuevo / La Guajira
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=5474; --Bochoromá / Tadó / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=5293; --Guaitadó / Lloró / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion='2022-07-21', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS. No está en DIVIPOLA 2022.'  WHERE id=5195; --Papayo / El Litoral del San Juan / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=5074; --Aguasal / Bagadó / Chocó
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2751; --El Tablazo / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2754; --Santo Domingo / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2755; --Natala / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2756; --La Despensa / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2753; --La Cruz / Toribío / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.'  WHERE id=2657; --Puente Real / Silvia / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2600; --Marmato / San Sebastián / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2547; --San Miguel / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2545; --Loma Corta / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2553; --El Carmen / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2546; --Santa Helena / Piendamó - Tunía / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2487; --Chachucue / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2503; --Taravira / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2488; --La Ceja / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2471; --El Cabuyo / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2493; --Mosoco / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2477; --Lame / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2497; --Chinas / Páez / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2445; --San Roque / Morales / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2436; --Monterredondo / Miranda / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2437; --Caraqueño / Miranda / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2328; --Segovia / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2326; --San Miguel / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2337; --Guanacas / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2336; --Santa Teresa / Inzá / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2226; --La Laguna / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2228; --El Pedregal / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2013-01-04', observaciones=''  WHERE id=2219; --Los Andes / Corinto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='No está en DIVIPOLA 2018.'  WHERE id=2181; --El Credo / Caloto / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2019-03-31', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.'  WHERE id=2144; --Andalucía / Caldono / Cauca
      UPDATE msip_centropoblado SET fechadeshabilitacion='2022-02-13', observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C. No está en DIVIPOLA 2021.'  WHERE id=7310; --El Prodigio / San Luis / Antioquia

      -- Deshabilitados
     
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='14938'; -- 70124019 PUEBLO NUEVO
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='8904'; -- 52835101 LA BARCA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD.',  fechadeshabilitacion=NULL   WHERE id='14709'; -- 50683010 CAMPO ALEGRE
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2018.',  fechadeshabilitacion=NULL   WHERE id='14575'; -- 27615048 BRISAS
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14574'; -- 27615047 SANTA MARIA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era CAS.',  fechadeshabilitacion=NULL   WHERE id='14573'; -- 27615046 LA PUNTA
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='14572'; -- 27615045 7 DE AGOSTO
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='5419'; -- 27615039 PLAYA ROJA
      UPDATE msip_centropoblado SET observaciones=NULL,  fechadeshabilitacion=NULL   WHERE id='5418'; -- 27615038 NUEVO ORIENTE
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2019.',  fechadeshabilitacion=NULL   WHERE id='15302'; -- 27615037 MACONDO
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='14571'; -- 27615033 BLANQUISET
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era C.',  fechadeshabilitacion=NULL   WHERE id='5405'; -- 27615023 BELÉN DE BAJIRÁ
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD.',  fechadeshabilitacion=NULL   WHERE id='4886'; -- 25873001 SOATAMA
      UPDATE msip_centropoblado SET observaciones='  Nombre cambiado por DIVIPOLA 2018. Antes era KILÓMETRO 28.',  fechadeshabilitacion=NULL   WHERE id='1907'; -- 18785001 KILÓMETRO 28 (LA ARGELIA)
      UPDATE msip_centropoblado SET observaciones=NULL,  fechadeshabilitacion=NULL   WHERE id='1346'; -- 15790002 LA CHAPA
      UPDATE msip_centropoblado SET observaciones='Aparece en DIVIPOLA 2018.',  fechadeshabilitacion=NULL   WHERE id='14092'; -- 5585010 EL PRODIGIO
      UPDATE msip_centropoblado SET observaciones='Tipo de centro cambiado por DIVIPOLA 2019. Antes era IPD.',  fechadeshabilitacion=NULL   WHERE id='6732'; -- 5134001 LA CHIQUITA

      UPDATE public.msip_municipio SET latitud=0.096131862, longitud=-72.32036402 WHERE id=1220;
      UPDATE public.msip_municipio SET latitud=3.515860962, longitud=-72.65672742 WHERE id=1139;
      UPDATE public.msip_municipio SET latitud=5.779915281, longitud=-70.86947037 WHERE id=443;
      UPDATE public.msip_municipio SET nombre='Sotará Paispamba' WHERE id=1230;
      UPDATE public.msip_municipio SET nombre='Turbana' WHERE id=1350;
      DELETE FROM public.msip_municipio WHERE id=1799;
    SQL
  end
end

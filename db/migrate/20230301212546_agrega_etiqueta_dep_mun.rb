# frozen_string_literal: true

class AgregaEtiquetaDepMun < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      -- Departamentos
      UPDATE msip_departamento SET svgrotx='369.9' , svgroty='314.5' WHERE id=50; -- Arauca
      UPDATE msip_departamento SET svgrotx='273' , svgroty='223.8' WHERE id=20; -- Cesar
      UPDATE msip_departamento SET svgrotx='12' , svgroty='99.8' WHERE id=53; -- Archipiélago de San Andrés, Providencia y Santa Catalina
      UPDATE msip_departamento SET svgrotx='211.3' , svgroty='257.8' WHERE id=24; -- Córdoba
      UPDATE msip_departamento SET svgrotx='264.6' , svgroty='367.4' WHERE id=27; -- Cundinamarca
      UPDATE msip_departamento SET svgrotx='235' , svgroty='178.1' WHERE id=48; -- Atlántico
      UPDATE msip_departamento SET svgrotx='250' , svgroty='260' WHERE id=7; -- Bolívar
      UPDATE msip_departamento SET svgrotx='285' , svgroty='349.8' WHERE id=11; -- Boyacá
      UPDATE msip_departamento SET svgrotx='223.4' , svgroty='360.6' WHERE id=13; -- Caldas
      UPDATE msip_departamento SET svgrotx='264.4' , svgroty='523.3' WHERE id=15; -- Caquetá
      UPDATE msip_departamento SET svgrotx='352.9' , svgroty='354.2' WHERE id=51; -- Casanare
      UPDATE msip_departamento SET svgrotx='437.9' , svgroty='456.2' WHERE id=56; -- Guainía
      UPDATE msip_departamento SET svgrotx='168.6' , svgroty='337.4' WHERE id=29; -- Chocó
      UPDATE msip_departamento SET svgrotx='354.1' , svgroty='585.6' WHERE id=55; -- Amazonas
      UPDATE msip_departamento SET svgrotx='217' , svgroty='303.2' WHERE id=35; -- Antioquia
      UPDATE msip_departamento SET svgrotx='256.3' , svgroty='403' WHERE id=4; -- Bogotá, D.C.
      UPDATE msip_departamento SET svgrotx='160.9' , svgroty='456.8' WHERE id=17; -- Cauca
      UPDATE msip_departamento SET svgrotx='321.7' , svgroty='479.2' WHERE id=57; -- Guaviare
      UPDATE msip_departamento SET svgrotx='213.9' , svgroty='457.1' WHERE id=32; -- Huila
      UPDATE msip_departamento SET svgrotx='305.4' , svgroty='152.3' WHERE id=33; -- La Guajira
      UPDATE msip_departamento SET svgrotx='250.6' , svgroty='181.4' WHERE id=34; -- Magdalena
      UPDATE msip_departamento SET svgrotx='302' , svgroty='422.2' WHERE id=37; -- Meta
      UPDATE msip_departamento SET svgrotx='136.8' , svgroty='487.3' WHERE id=38; -- Nariño
      UPDATE msip_departamento SET svgrotx='197.5' , svgroty='364' WHERE id=42; -- Risaralda
      UPDATE msip_departamento SET svgrotx='273.5' , svgroty='313.2' WHERE id=43; -- Santander
      UPDATE msip_departamento SET svgrotx='225.9' , svgroty='230' WHERE id=45; -- Sucre
      UPDATE msip_departamento SET svgrotx='226.9' , svgroty='404' WHERE id=46; -- Tolima
      UPDATE msip_departamento SET svgrotx='290.3' , svgroty='254.1' WHERE id=39; -- Norte de Santander
      UPDATE msip_departamento SET svgrotx='200' , svgroty='524.2' WHERE id=52; -- Putumayo
      UPDATE msip_departamento SET svgrotx='208.1' , svgroty='390.5' WHERE id=41; -- Quindío
      UPDATE msip_departamento SET svgrotx='162.3' , svgroty='415.4' WHERE id=47; -- Valle del Cauca
      UPDATE msip_departamento SET svgrotx='370.4' , svgroty='525' WHERE id=58; -- Vaupés
      UPDATE msip_departamento SET svgrotx='425.2' , svgroty='375.6' WHERE id=59; -- Vichada

      -- Municipios
      UPDATE msip_municipio SET svgrotx='273.6' , svgroty='574.1' WHERE id=896; -- Puerto Alegría/Amazonas
      UPDATE msip_municipio SET svgrotx='180.8' , svgroty='272.9' WHERE id=766; -- Apartadó/Antioquia
      UPDATE msip_municipio SET svgrotx='194.5' , svgroty='400.2' WHERE id=615; -- Andalucía/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='199.4' , svgroty='378.2' WHERE id=711; -- Ansermanuevo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='229' , svgroty='332.8' WHERE id=555; -- Granada/Antioquia
      UPDATE msip_municipio SET svgrotx='199.5' , svgroty='371.4' WHERE id=648; -- La Celia/Risaralda
      UPDATE msip_municipio SET svgrotx='192.5' , svgroty='379.3' WHERE id=427; -- El Cairo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='260.8' , svgroty='306.1' WHERE id=1423; -- Yondó/Antioquia
      UPDATE msip_municipio SET svgrotx='191.2' , svgroty='327.1' WHERE id=1362; -- Urrao/Antioquia
      UPDATE msip_municipio SET svgrotx='242.5' , svgroty='325.1' WHERE id=193; -- Caracolí/Antioquia
      UPDATE msip_municipio SET svgrotx='226.3' , svgroty='324.1' WHERE id=343; -- Concepción/Antioquia
      UPDATE msip_municipio SET svgrotx='236' , svgroty='330.2' WHERE id=1055; -- San Carlos/Antioquia
      UPDATE msip_municipio SET svgrotx='236' , svgroty='322.1' WHERE id=1097; -- San Roque/Antioquia
      UPDATE msip_municipio SET svgrotx='226' , svgroty='307.7' WHERE id=557; -- Guadalupe/Antioquia
      UPDATE msip_municipio SET svgrotx='234.6' , svgroty='185.9' WHERE id=749; -- Manatí/Atlántico
      UPDATE msip_municipio SET svgrotx='236.3' , svgroty='200.4' WHERE id=431; -- El Guamo/Bolívar
      UPDATE msip_municipio SET svgrotx='228.4' , svgroty='179.4' WHERE id=729; -- Luruaco/Atlántico
      UPDATE msip_municipio SET svgrotx='282.8' , svgroty='341.9' WHERE id=788; -- Moniquirá/Boyacá
      UPDATE msip_municipio SET svgrotx='202.7' , svgroty='309.7' WHERE id=114; -- Buriticá/Antioquia
      UPDATE msip_municipio SET svgrotx='268.1' , svgroty='336.7' WHERE id=1247; -- Sucre/Santander
      UPDATE msip_municipio SET svgrotx='263.2' , svgroty='295.7' WHERE id=232; -- Cantagallo/Bolívar
      UPDATE msip_municipio SET svgrotx='364.5' , svgroty='545.2' WHERE id=738; -- La Victoria/Amazonas
      UPDATE msip_municipio SET svgrotx='197' , svgroty='315.3' WHERE id=665; -- Abriaquí/Antioquia
      UPDATE msip_municipio SET svgrotx='216.3' , svgroty='335.1' WHERE id=1020; -- Retiro/Antioquia
      UPDATE msip_municipio SET svgrotx='235.7' , svgroty='179.8' WHERE id=1047; -- Sabanalarga/Atlántico
      UPDATE msip_municipio SET svgrotx='269.6' , svgroty='217.7' WHERE id=571; -- Astrea/Cesar
      UPDATE msip_municipio SET svgrotx='231.3' , svgroty='260.7' WHERE id=1117; -- Ayapel/Córdoba
      UPDATE msip_municipio SET svgrotx='248.5' , svgroty='387.5' WHERE id=983; -- Apulo/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254' , svgroty='397.3' WHERE id=893; -- Arbeláez/Cundinamarca
      UPDATE msip_municipio SET svgrotx='209.3' , svgroty='463.9' WHERE id=146; -- Agrado/Huila
      UPDATE msip_municipio SET svgrotx='221.6' , svgroty='431' WHERE id=223; -- Aipe/Huila
      UPDATE msip_municipio SET svgrotx='223.8' , svgroty='456.1' WHERE id=326; -- Algeciras/Huila
      UPDATE msip_municipio SET svgrotx='207.7' , svgroty='470.4' WHERE id=453; -- Altamira/Huila
      UPDATE msip_municipio SET svgrotx='185.1' , svgroty='476' WHERE id=1088; -- San Agustín/Huila
      UPDATE msip_municipio SET svgrotx='301' , svgroty='184.4' WHERE id=1367; -- Urumita/La Guajira
      UPDATE msip_municipio SET svgrotx='264.8' , svgroty='193.2' WHERE id=534; -- Algarrobo/Magdalena
      UPDATE msip_municipio SET svgrotx='280.5' , svgroty='449.1' WHERE id=1182; -- Vistahermosa/Meta
      UPDATE msip_municipio SET svgrotx='137.3' , svgroty='462.9' WHERE id=1149; -- Santa Bárbara/Nariño
      UPDATE msip_municipio SET svgrotx='201.4' , svgroty='369.9' WHERE id=1137; -- Santuario/Risaralda
      UPDATE msip_municipio SET svgrotx='227.1' , svgroty='383' WHERE id=737; -- Anzoátegui/Tolima
      UPDATE msip_municipio SET svgrotx='216.8' , svgroty='391.5' WHERE id=138; -- Cajamarca/Tolima
      UPDATE msip_municipio SET svgrotx='228.8' , svgroty='320.4' WHERE id=1143; -- Santo Domingo/Antioquia
      UPDATE msip_municipio SET svgrotx='221.5' , svgroty='196' WHERE id=878; -- Arjona/Bolívar
      UPDATE msip_municipio SET svgrotx='250' , svgroty='230.6' WHERE id=787; -- Santa Cruz de Mompox/Bolívar
      UPDATE msip_municipio SET svgrotx='292.7' , svgroty='202.8' WHERE id=149; -- Agustín Codazzi/Cesar
      UPDATE msip_municipio SET svgrotx='209' , svgroty='199.8' WHERE id=31; -- Cartagena de Indias/Bolívar
      UPDATE msip_municipio SET svgrotx='244.5' , svgroty='189.7' WHERE id=451; -- El Piñón/Magdalena
      UPDATE msip_municipio SET svgrotx='226.1' , svgroty='495.4' WHERE id=712; -- La Montañita/Caquetá
      UPDATE msip_municipio SET svgrotx='302' , svgroty='367.8' WHERE id=870; -- Páez/Boyacá
      UPDATE msip_municipio SET svgrotx='163' , svgroty='322.1' WHERE id=1465; -- Bojayá/Chocó
      UPDATE msip_municipio SET svgrotx='156.3' , svgroty='347.6' WHERE id=820; -- Nuquí/Chocó
      UPDATE msip_municipio SET svgrotx='204.3' , svgroty='238.2' WHERE id=237; -- Cereté/Córdoba
      UPDATE msip_municipio SET svgrotx='257.1' , svgroty='362.4' WHERE id=450; -- El Peñón/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254.6' , svgroty='366.9' WHERE id=810; -- Nimaima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='258.2' , svgroty='372.8' WHERE id=1067; -- San Francisco/Cundinamarca
      UPDATE msip_municipio SET svgrotx='217.7' , svgroty='442.3' WHERE id=888; -- Palermo/Huila
      UPDATE msip_municipio SET svgrotx='299.7' , svgroty='185.8' WHERE id=728; -- La Jagua del Pilar/La Guajira
      UPDATE msip_municipio SET svgrotx='204.2' , svgroty='301.2' WHERE id=912; -- Peque/Antioquia
      UPDATE msip_municipio SET svgrotx='239' , svgroty='314.9' WHERE id=1420; -- Yolombó/Antioquia
      UPDATE msip_municipio SET svgrotx='218.3' , svgroty='351' WHERE id=148; -- Aguadas/Caldas
      UPDATE msip_municipio SET svgrotx='206.4' , svgroty='368.6' WHERE id=1082; -- San José/Caldas
      UPDATE msip_municipio SET svgrotx='234.3' , svgroty='170.6' WHERE id=1342; -- Tubará/Atlántico
      UPDATE msip_municipio SET svgrotx='240.7' , svgroty='180.6' WHERE id=934; -- Ponedera/Atlántico
      UPDATE msip_municipio SET svgrotx='243.7' , svgroty='229.5' WHERE id=740; -- Magangué/Bolívar
      UPDATE msip_municipio SET svgrotx='298.9' , svgroty='354.4' WHERE id=911; -- Pesca/Boyacá
      UPDATE msip_municipio SET svgrotx='252.2' , svgroty='339.6' WHERE id=949; -- Puerto Boyacá/Boyacá
      UPDATE msip_municipio SET svgrotx='306.6' , svgroty='334.5' WHERE id=1352; -- Tutazá/Boyacá
      UPDATE msip_municipio SET svgrotx='230.7' , svgroty='474.1' WHERE id=977; -- Puerto Rico/Caquetá
      UPDATE msip_municipio SET svgrotx='326.6' , svgroty='380.9' WHERE id=177; -- Maní/Casanare
      UPDATE msip_municipio SET svgrotx='164.5' , svgroty='455.5' WHERE id=449; -- El Tambo/Cauca
      UPDATE msip_municipio SET svgrotx='190.1' , svgroty='500.9' WHERE id=900; -- Piamonte/Cauca
      UPDATE msip_municipio SET svgrotx='190.2' , svgroty='240.1' WHERE id=724; -- Los Córdobas/Córdoba
      UPDATE msip_municipio SET svgrotx='186.5' , svgroty='247.8' WHERE id=863; -- Arboletes/Antioquia
      UPDATE msip_municipio SET svgrotx='198.8' , svgroty='309.5' WHERE id=176; -- Cañasgordas/Antioquia
      UPDATE msip_municipio SET svgrotx='177.9' , svgroty='281.8' WHERE id=256; -- Chigorodó/Antioquia
      UPDATE msip_municipio SET svgrotx='245.6' , svgroty='279' WHERE id=436; -- El Bagre/Antioquia
      UPDATE msip_municipio SET svgrotx='196.1' , svgroty='306.2' WHERE id=1355; -- Uramita/Antioquia
      UPDATE msip_municipio SET svgrotx='255.3' , svgroty='390.4' WHERE id=1202; -- Silvania/Cundinamarca
      UPDATE msip_municipio SET svgrotx='207.4' , svgroty='338.7' WHERE id=1376; -- Venecia/Antioquia
      UPDATE msip_municipio SET svgrotx='236.8' , svgroty='286.3' WHERE id=1426; -- Zaragoza/Antioquia
      UPDATE msip_municipio SET svgrotx='290.5' , svgroty='347.7' WHERE id=338; -- Cómbita/Boyacá
      UPDATE msip_municipio SET svgrotx='301.7' , svgroty='187.8' WHERE id=760; -- Manaure Balcón del Cesar/Cesar
      UPDATE msip_municipio SET svgrotx='177.3' , svgroty='361' WHERE id=1323; -- Unión Panamericana/Chocó
      UPDATE msip_municipio SET svgrotx='223.8' , svgroty='267.3' WHERE id=604; -- La Apartada/Córdoba
      UPDATE msip_municipio SET svgrotx='407.2' , svgroty='436.6' WHERE id=594; -- Barrancominas/Guainía
      UPDATE msip_municipio SET svgrotx='343' , svgroty='132.6' WHERE id=1361; -- Uribia/La Guajira
      UPDATE msip_municipio SET svgrotx='265.1' , svgroty='464.6' WHERE id=605; -- La Macarena/Meta
      UPDATE msip_municipio SET svgrotx='285' , svgroty='402.3' WHERE id=57; -- Villavicencio/Meta
      UPDATE msip_municipio SET svgrotx='148' , svgroty='498.8' WHERE id=614; -- Ancuya/Nariño
      UPDATE msip_municipio SET svgrotx='242.5' , svgroty='401' WHERE id=199; -- Carmen de Apicalá/Tolima
      UPDATE msip_municipio SET svgrotx='201' , svgroty='388.7' WHERE id=702; -- La Victoria/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='140.9' , svgroty='507.9' WHERE id=561; -- Guachucal/Nariño
      UPDATE msip_municipio SET svgrotx='317.5' , svgroty='294.5' WHERE id=638; -- Labateca/Norte de Santander
      UPDATE msip_municipio SET svgrotx='173.3' , svgroty='509.6' WHERE id=1409; -- Villagarzón/Putumayo
      UPDATE msip_municipio SET svgrotx='206' , svgroty='390.3' WHERE id=698; -- La Tebaida/Quindío
      UPDATE msip_municipio SET svgrotx='297.9' , svgroty='298.1' WHERE id=27; -- Bucaramanga/Santander
      UPDATE msip_municipio SET svgrotx='191.7' , svgroty='384.5' WHERE id=1380; -- Versalles/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='233.9' , svgroty='193.4' WHERE id=190; -- Calamar/Bolívar
      UPDATE msip_municipio SET svgrotx='260.2' , svgroty='351.9' WHERE id=965; -- Quípama/Boyacá
      UPDATE msip_municipio SET svgrotx='284.3' , svgroty='358.2' WHERE id=1377; -- Ventaquemada/Boyacá
      UPDATE msip_municipio SET svgrotx='228.5' , svgroty='363.1' WHERE id=747; -- Manzanares/Caldas
      UPDATE msip_municipio SET svgrotx='184.2' , svgroty='432.8' WHERE id=1360; -- Villa Rica/Cauca
      UPDATE msip_municipio SET svgrotx='291.6' , svgroty='210.4' WHERE id=768; -- Becerril/Cesar
      UPDATE msip_municipio SET svgrotx='193.9' , svgroty='235.7' WHERE id=957; -- Puerto Escondido/Córdoba
      UPDATE msip_municipio SET svgrotx='192.8' , svgroty='262.5' WHERE id=1368; -- Valencia/Córdoba
      UPDATE msip_municipio SET svgrotx='284.8' , svgroty='382.6' WHERE id=498; -- Gachalá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='273.8' , svgroty='360.4' WHERE id=1357; -- Villa de San Diego de Ubaté/Cundinamarca
      UPDATE msip_municipio SET svgrotx='230.6' , svgroty='173.2' WHERE id=631; -- Juan de Acosta/Atlántico
      UPDATE msip_municipio SET svgrotx='233.1' , svgroty='193.3' WHERE id=1033; -- Arroyohondo/Bolívar
      UPDATE msip_municipio SET svgrotx='235.2' , svgroty='304.3' WHERE id=550; -- Amalfi/Antioquia
      UPDATE msip_municipio SET svgrotx='202.8' , svgroty='326.5' WHERE id=752; -- Anzá/Antioquia
      UPDATE msip_municipio SET svgrotx='230.9' , svgroty='318.5' WHERE id=298; -- Cisneros/Antioquia
      UPDATE msip_municipio SET svgrotx='244.4' , svgroty='227.2' WHERE id=283; -- Cicuco/Bolívar
      UPDATE msip_municipio SET svgrotx='156.6' , svgroty='462.1' WHERE id=847; -- Argelia/Cauca
      UPDATE msip_municipio SET svgrotx='166.1' , svgroty='493.5' WHERE id=452; -- El Tablón de Gómez/Nariño
      UPDATE msip_municipio SET svgrotx='317' , svgroty='301.7' WHERE id=260; -- Chitagá/Norte de Santander
      UPDATE msip_municipio SET svgrotx='201.3' , svgroty='330.4' WHERE id=1456; -- Betulia/Antioquia
      UPDATE msip_municipio SET svgrotx='256.4' , svgroty='387.5' WHERE id=553; -- Granada/Cundinamarca
      UPDATE msip_municipio SET svgrotx='278.2' , svgroty='358.2' WHERE id=560; -- Guachetá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='246.7' , svgroty='364.6' WHERE id=573; -- Guaduas/Cundinamarca
      UPDATE msip_municipio SET svgrotx='292.3' , svgroty='357.8' WHERE id=286; -- Ciénega/Boyacá
      UPDATE msip_municipio SET svgrotx='272.7' , svgroty='378.1' WHERE id=578; -- Guasca/Cundinamarca
      UPDATE msip_municipio SET svgrotx='241.1' , svgroty='387.9' WHERE id=581; -- Guataquí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='295.8' , svgroty='280.4' WHERE id=144; -- Cáchira/Norte de Santander
      UPDATE msip_municipio SET svgrotx='213.8' , svgroty='341.2' WHERE id=1116; -- Santa Bárbara/Antioquia
      UPDATE msip_municipio SET svgrotx='187.3' , svgroty='436.7' WHERE id=192; -- Caloto/Cauca
      UPDATE msip_municipio SET svgrotx='266.2' , svgroty='400.3' WHERE id=592; -- Gutiérrez/Cundinamarca
      UPDATE msip_municipio SET svgrotx='244.3' , svgroty='385.7' WHERE id=627; -- Jerusalén/Cundinamarca
      UPDATE msip_municipio SET svgrotx='277.7' , svgroty='381.2' WHERE id=632; -- Junín/Cundinamarca
      UPDATE msip_municipio SET svgrotx='251.7' , svgroty='383' WHERE id=653; -- La Mesa/Cundinamarca
      UPDATE msip_municipio SET svgrotx='259' , svgroty='378.5' WHERE id=739; -- Madrid/Cundinamarca
      UPDATE msip_municipio SET svgrotx='282.7' , svgroty='371.6' WHERE id=750; -- Manta/Cundinamarca
      UPDATE msip_municipio SET svgrotx='259.7' , svgroty='382' WHERE id=794; -- Mosquera/Cundinamarca
      UPDATE msip_municipio SET svgrotx='210.1' , svgroty='449.8' WHERE id=612; -- Íquira/Huila
      UPDATE msip_municipio SET svgrotx='202.9' , svgroty='335.3' WHERE id=347; -- Concordia/Antioquia
      UPDATE msip_municipio SET svgrotx='216.8' , svgroty='325.1' WHERE id=358; -- Copacabana/Antioquia
      UPDATE msip_municipio SET svgrotx='326.3' , svgroty='318.2' WHERE id=590; -- Güicán de La Sierra/Boyacá
      UPDATE msip_municipio SET svgrotx='254.1' , svgroty='394.5' WHERE id=497; -- Fusagasugá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='206' , svgroty='477.6' WHERE id=1242; -- Suaza/Huila
      UPDATE msip_municipio SET svgrotx='203.9' , svgroty='468.8' WHERE id=1276; -- Tarqui/Huila
      UPDATE msip_municipio SET svgrotx='231.1' , svgroty='437.8' WHERE id=1285; -- Tello/Huila
      UPDATE msip_municipio SET svgrotx='256.2' , svgroty='371.7' WHERE id=700; -- La Vega/Cundinamarca
      UPDATE msip_municipio SET svgrotx='278.6' , svgroty='360.6' WHERE id=708; -- Lenguazaque/Cundinamarca
      UPDATE msip_municipio SET svgrotx='281.1' , svgroty='369.7' WHERE id=734; -- Machetá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='221.8' , svgroty='339.3' WHERE id=692; -- La Unión/Antioquia
      UPDATE msip_municipio SET svgrotx='304.4' , svgroty='342' WHERE id=479; -- Floresta/Boyacá
      UPDATE msip_municipio SET svgrotx='254' , svgroty='364.5' WHERE id=662; -- La Peña/Cundinamarca
      UPDATE msip_municipio SET svgrotx='229' , svgroty='429.8' WHERE id=1391; -- Villavieja/Huila
      UPDATE msip_municipio SET svgrotx='216.3' , svgroty='451' WHERE id=1412; -- Yaguará/Huila
      UPDATE msip_municipio SET svgrotx='317' , svgroty='159.5' WHERE id=602; -- Albania/La Guajira
      UPDATE msip_municipio SET svgrotx='311.7' , svgroty='166.9' WHERE id=1257; -- Barrancas/La Guajira
      UPDATE msip_municipio SET svgrotx='227.3' , svgroty='195.6' WHERE id=745; -- Mahates/Bolívar
      UPDATE msip_municipio SET svgrotx='287.6' , svgroty='162.9' WHERE id=1452; -- Dibulla/La Guajira
      UPDATE msip_municipio SET svgrotx='308.7' , svgroty='172.8' WHERE id=481; -- Fonseca/La Guajira
      UPDATE msip_municipio SET svgrotx='299.7' , svgroty='173.4' WHERE id=1058; -- San Juan del Cesar/La Guajira
      UPDATE msip_municipio SET svgrotx='302.5' , svgroty='181.6' WHERE id=1398; -- Villanueva/La Guajira
      UPDATE msip_municipio SET svgrotx='271.8' , svgroty='180' WHERE id=892; -- Aracataca/Magdalena
      UPDATE msip_municipio SET svgrotx='240.2' , svgroty='191.6' WHERE id=236; -- Cerro de San Antonio/Magdalena
      UPDATE msip_municipio SET svgrotx='142.7' , svgroty='491.9' WHERE id=1111; -- Samaniego/Nariño
      UPDATE msip_municipio SET svgrotx='210.7' , svgroty='307' WHERE id=1052; -- San Andrés de Cuerquía/Antioquia
      UPDATE msip_municipio SET svgrotx='143' , svgroty='460' WHERE id=566; -- Guapi/Cauca
      UPDATE msip_municipio SET svgrotx='207.3' , svgroty='277.2' WHERE id=784; -- Montelíbano/Córdoba
      UPDATE msip_municipio SET svgrotx='255.5' , svgroty='400.1' WHERE id=1054; -- San Bernardo/Cundinamarca
      UPDATE msip_municipio SET svgrotx='265.1' , svgroty='360.4' WHERE id=1061; -- San Cayetano/Cundinamarca
      UPDATE msip_municipio SET svgrotx='253.7' , svgroty='372.8' WHERE id=1185; -- Sasaima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='275.3' , svgroty='370.9' WHERE id=1195; -- Sesquilé/Cundinamarca
      UPDATE msip_municipio SET svgrotx='259.7' , svgroty='387' WHERE id=1216; -- Soacha/Cundinamarca
      UPDATE msip_municipio SET svgrotx='275.4' , svgroty='366.8' WHERE id=1245; -- Suesca/Cundinamarca
      UPDATE msip_municipio SET svgrotx='260' , svgroty='369.2' WHERE id=1251; -- Supatá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='228.8' , svgroty='176.1' WHERE id=921; -- Piojó/Atlántico
      UPDATE msip_municipio SET svgrotx='312.3' , svgroty='163.7' WHERE id=640; -- Hatonuevo/La Guajira
      UPDATE msip_municipio SET svgrotx='271.1' , svgroty='185.7' WHERE id=492; -- Fundación/Magdalena
      UPDATE msip_municipio SET svgrotx='262.6' , svgroty='226.5' WHERE id=564; -- Guamal/Magdalena
      UPDATE msip_municipio SET svgrotx='255.7' , svgroty='209.8' WHERE id=778; -- Nueva Granada/Magdalena
      UPDATE msip_municipio SET svgrotx='261.7' , svgroty='218' WHERE id=913; -- Pijiño del Carmen/Magdalena
      UPDATE msip_municipio SET svgrotx='218.8' , svgroty='343.7' WHERE id=300; -- Abejorral/Antioquia
      UPDATE msip_municipio SET svgrotx='198.4' , svgroty='449.2' WHERE id=873; -- Páez/Cauca
      UPDATE msip_municipio SET svgrotx='234' , svgroty='385.3' WHERE id=454; -- Alvarado/Tolima
      UPDATE msip_municipio SET svgrotx='245.1' , svgroty='406.5' WHERE id=388; -- Cunday/Tolima
      UPDATE msip_municipio SET svgrotx='309.9' , svgroty='608' WHERE id=459; -- El Encanto/Amazonas
      UPDATE msip_municipio SET svgrotx='253.6' , svgroty='360.3' WHERE id=658; -- La Palma/Cundinamarca
      UPDATE msip_municipio SET svgrotx='248.6' , svgroty='350.1' WHERE id=950; -- Puerto Salgar/Cundinamarca
      UPDATE msip_municipio SET svgrotx='207.1' , svgroty='312.3' WHERE id=714; -- Liborina/Antioquia
      UPDATE msip_municipio SET svgrotx='229.7' , svgroty='183.8' WHERE id=1017; -- Repelón/Atlántico
      UPDATE msip_municipio SET svgrotx='175.1' , svgroty='460.2' WHERE id=1315; -- Timbío/Cauca
      UPDATE msip_municipio SET svgrotx='281.5' , svgroty='185' WHERE id=943; -- Pueblo Bello/Cesar
      UPDATE msip_municipio SET svgrotx='178.5' , svgroty='336.8' WHERE id=48; -- Quibdó/Chocó
      UPDATE msip_municipio SET svgrotx='244.7' , svgroty='381.6' WHERE id=964; -- Pulí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='305.2' , svgroty='148.3' WHERE id=49; -- Riohacha/La Guajira
      UPDATE msip_municipio SET svgrotx='287.1' , svgroty='396.6' WHERE id=1018; -- Restrepo/Meta
      UPDATE msip_municipio SET svgrotx='154.1' , svgroty='513.2' WHERE id=951; -- Puerres/Nariño
      UPDATE msip_municipio SET svgrotx='310.2' , svgroty='245.8' WHERE id=1320; -- Tibú/Norte de Santander
      UPDATE msip_municipio SET svgrotx='300.1' , svgroty='363.2' WHERE id=1074; -- San Eduardo/Boyacá
      UPDATE msip_municipio SET svgrotx='302' , svgroty='340.4' WHERE id=1147; -- Santa Rosa de Viterbo/Boyacá
      UPDATE msip_municipio SET svgrotx='317' , svgroty='146.8' WHERE id=933; -- Manaure/La Guajira
      UPDATE msip_municipio SET svgrotx='296.6' , svgroty='254.3' WHERE id=1094; -- San Calixto/Norte de Santander
      UPDATE msip_municipio SET svgrotx='203.2' , svgroty='399.5' WHERE id=1196; -- Sevilla/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='301.5' , svgroty='345.8' WHERE id=1311; -- Tibasosa/Boyacá
      UPDATE msip_municipio SET svgrotx='296.3' , svgroty='351.5' WHERE id=1324; -- Toca/Boyacá
      UPDATE msip_municipio SET svgrotx='218.6' , svgroty='372.9' WHERE id=1393; -- Villamaría/Caldas
      UPDATE msip_municipio SET svgrotx='276.2' , svgroty='238.4' WHERE id=1267; -- Tamalameque/Cesar
      UPDATE msip_municipio SET svgrotx='251.3' , svgroty='365.2' WHERE id=1364; -- Útica/Cundinamarca
      UPDATE msip_municipio SET svgrotx='251.3' , svgroty='390.3' WHERE id=1401; -- Viotá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254.7' , svgroty='351.6' WHERE id=1410; -- Yacopí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='145' , svgroty='502.2' WHERE id=1351; -- Túquerres/Nariño
      UPDATE msip_municipio SET svgrotx='243.5' , svgroty='241.8' WHERE id=1244; -- Sucre/Sucre
      UPDATE msip_municipio SET svgrotx='307.1' , svgroty='581.6' WHERE id=703; -- La Chorrera/Amazonas
      UPDATE msip_municipio SET svgrotx='401.3' , svgroty='660.1' WHERE id=36; -- Leticia/Amazonas
      UPDATE msip_municipio SET svgrotx='235.9' , svgroty='336.2' WHERE id=1076; -- San Luis/Antioquia
      UPDATE msip_municipio SET svgrotx='208.4' , svgroty='319.5' WHERE id=1232; -- Sopetrán/Antioquia
      UPDATE msip_municipio SET svgrotx='175.3' , svgroty='321.3' WHERE id=1392; -- Vigía del Fuerte/Antioquia
      UPDATE msip_municipio SET svgrotx='234.6' , svgroty='175.9' WHERE id=1363; -- Usiacurí/Atlántico
      UPDATE msip_municipio SET svgrotx='221.2' , svgroty='189.4' WHERE id=1347; -- Turbaco/Bolívar
      UPDATE msip_municipio SET svgrotx='288.4' , svgroty='361' WHERE id=1309; -- Tibaná/Boyacá
      UPDATE msip_municipio SET svgrotx='218.9' , svgroty='337.6' WHERE id=634; -- La Ceja/Antioquia
      UPDATE msip_municipio SET svgrotx='270.6' , svgroty='239.8' WHERE id=466; -- El Peñón/Bolívar
      UPDATE msip_municipio SET svgrotx='265.6' , svgroty='518.8' WHERE id=215; -- Cartagena del Chairá/Caquetá
      UPDATE msip_municipio SET svgrotx='179' , svgroty='352' WHERE id=848; -- Atrato/Chocó
      UPDATE msip_municipio SET svgrotx='193.3' , svgroty='354.7' WHERE id=1192; -- Bagadó/Chocó
      UPDATE msip_municipio SET svgrotx='173.8' , svgroty='358.7' WHERE id=172; -- El Cantón del San Pablo/Chocó
      UPDATE msip_municipio SET svgrotx='291.3' , svgroty='396.4' WHERE id=387; -- Cumaral/Meta
      UPDATE msip_municipio SET svgrotx='148' , svgroty='509.3' WHERE id=356; -- Contadero/Nariño
      UPDATE msip_municipio SET svgrotx='151.2' , svgroty='489.6' WHERE id=445; -- El Peñol/Nariño
      UPDATE msip_municipio SET svgrotx='280.3' , svgroty='335.1' WHERE id=267; -- Chipatá/Santander
      UPDATE msip_municipio SET svgrotx='282.1' , svgroty='314.2' WHERE id=404; -- El Carmen de Chucurí/Santander
      UPDATE msip_municipio SET svgrotx='232.3' , svgroty='364.9' WHERE id=487; -- Fresno/Tolima
      UPDATE msip_municipio SET svgrotx='401.6' , svgroty='585.6' WHERE id=707; -- La Pedrera/Amazonas
      UPDATE msip_municipio SET svgrotx='230.6' , svgroty='325' WHERE id=349; -- Alejandría/Antioquia
      UPDATE msip_municipio SET svgrotx='209.5' , svgroty='336.2' WHERE id=536; -- Amagá/Antioquia
      UPDATE msip_municipio SET svgrotx='201.9' , svgroty='349.3' WHERE id=593; -- Andes/Antioquia
      UPDATE msip_municipio SET svgrotx='189.4' , svgroty='314' WHERE id=488; -- Frontino/Antioquia
      UPDATE msip_municipio SET svgrotx='205.6' , svgroty='352.2' WHERE id=623; -- Jardín/Antioquia
      UPDATE msip_municipio SET svgrotx='363.6' , svgroty='560.7' WHERE id=777; -- Mirití - Paraná/Amazonas
      UPDATE msip_municipio SET svgrotx='247' , svgroty='395.5' WHERE id=809; -- Nilo/Cundinamarca
      UPDATE msip_municipio SET svgrotx='324.3' , svgroty='155.3' WHERE id=741; -- Maicao/La Guajira
      UPDATE msip_municipio SET svgrotx='215.9' , svgroty='339.7' WHERE id=785; -- Montebello/Antioquia
      UPDATE msip_municipio SET svgrotx='206.7' , svgroty='335.1' WHERE id=1318; -- Titiribí/Antioquia
      UPDATE msip_municipio SET svgrotx='384.3' , svgroty='310.8' WHERE id=18; -- Arauca/Arauca
      UPDATE msip_municipio SET svgrotx='360.8' , svgroty='309.8' WHERE id=1056; -- Arauquita/Arauca
      UPDATE msip_municipio SET svgrotx='398.6' , svgroty='326.9' WHERE id=377; -- Cravo Norte/Arauca
      UPDATE msip_municipio SET svgrotx='369.4' , svgroty='321.1' WHERE id=975; -- Puerto Rondón/Arauca
      UPDATE msip_municipio SET svgrotx='240.4' , svgroty='172.2' WHERE id=746; -- Malambo/Atlántico
      UPDATE msip_municipio SET svgrotx='208.1' , svgroty='373.1' WHERE id=755; -- Marsella/Risaralda
      UPDATE msip_municipio SET svgrotx='298.1' , svgroty='309.5' WHERE id=721; -- Los Santos/Santander
      UPDATE msip_municipio SET svgrotx='391.8' , svgroty='507.8' WHERE id=39; -- Mitú/Vaupés
      UPDATE msip_municipio SET svgrotx='236.5' , svgroty='174.4' WHERE id=1255; -- Baranoa/Atlántico
      UPDATE msip_municipio SET svgrotx='239.2' , svgroty='166.5' WHERE id=22; -- Barranquilla/Atlántico
      UPDATE msip_municipio SET svgrotx='237.9' , svgroty='187.3' WHERE id=175; -- Campo de La Cruz/Atlántico
      UPDATE msip_municipio SET svgrotx='237.9' , svgroty='184.5' WHERE id=191; -- Candelaria/Atlántico
      UPDATE msip_municipio SET svgrotx='292.4' , svgroty='350.5' WHERE id=851; -- Oicatá/Boyacá
      UPDATE msip_municipio SET svgrotx='238.2' , svgroty='349.7' WHERE id=819; -- Norcasia/Caldas
      UPDATE msip_municipio SET svgrotx='227.2' , svgroty='216.5' WHERE id=859; -- Ovejas/Sucre
      UPDATE msip_municipio SET svgrotx='372.3' , svgroty='533.5' WHERE id=866; -- Pacoa/Vaupés
      UPDATE msip_municipio SET svgrotx='322.8' , svgroty='349.2' WHERE id=899; -- Paya/Boyacá
      UPDATE msip_municipio SET svgrotx='374.1' , svgroty='341.6' WHERE id=443; -- Paz de Ariporo/Casanare
      UPDATE msip_municipio SET svgrotx='179.9' , svgroty='448.6' WHERE id=916; -- Piendamó - Tunía/Cauca
      UPDATE msip_municipio SET svgrotx='210.3' , svgroty='394.8' WHERE id=917; -- Pijao/Quindío
      UPDATE msip_municipio SET svgrotx='245.5' , svgroty='332.3' WHERE id=968; -- Puerto Nare/Antioquia
      UPDATE msip_municipio SET svgrotx='237' , svgroty='167.2' WHERE id=952; -- Puerto Colombia/Atlántico
      UPDATE msip_municipio SET svgrotx='185.4' , svgroty='430.1' WHERE id=956; -- Puerto Tejada/Cauca
      UPDATE msip_municipio SET svgrotx='265.4' , svgroty='394.8' WHERE id=1359; -- Une/Cundinamarca
      UPDATE msip_municipio SET svgrotx='221.4' , svgroty='308' WHERE id=643; -- Angostura/Antioquia
      UPDATE msip_municipio SET svgrotx='200.5' , svgroty='338.3' WHERE id=1049; -- Salgar/Antioquia
      UPDATE msip_municipio SET svgrotx='208' , svgroty='367.3' WHERE id=1032; -- Risaralda/Caldas
      UPDATE msip_municipio SET svgrotx='284.6' , svgroty='262.5' WHERE id=1025; -- Río de Oro/Cesar
      UPDATE msip_municipio SET svgrotx='183.2' , svgroty='365.9' WHERE id=967; -- Río Iró/Chocó
      UPDATE msip_municipio SET svgrotx='216.8' , svgroty='230.8' WHERE id=1093; -- San Andrés de Sotavento/Córdoba
      UPDATE msip_municipio SET svgrotx='252.3' , svgroty='403.2' WHERE id=857; -- Venecia/Cundinamarca
      UPDATE msip_municipio SET svgrotx='257.8' , svgroty='367' WHERE id=1379; -- Vergara/Cundinamarca
      UPDATE msip_municipio SET svgrotx='267.7' , svgroty='369.2' WHERE id=1430; -- Zipaquirá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='484.5' , svgroty='424.7' WHERE id=1414; -- Cacahual/Guainía
      UPDATE msip_municipio SET svgrotx='450.8' , svgroty='429' WHERE id=35; -- Inírida/Guainía
      UPDATE msip_municipio SET svgrotx='505.5' , svgroty='493.2' WHERE id=1408; -- La Guadalupe/Guainía
      UPDATE msip_municipio SET svgrotx='403.5' , svgroty='460' WHERE id=1417; -- Morichal/Guainía
      UPDATE msip_municipio SET svgrotx='235.2' , svgroty='434.5' WHERE id=1256; -- Baraya/Huila
      UPDATE msip_municipio SET svgrotx='244.8' , svgroty='376.5' WHERE id=1078; -- San Juan de Rioseco/Cundinamarca
      UPDATE msip_municipio SET svgrotx='222.6' , svgroty='450.7' WHERE id=169; -- Campoalegre/Huila
      UPDATE msip_municipio SET svgrotx='245.5' , svgroty='424.2' WHERE id=342; -- Colombia/Huila
      UPDATE msip_municipio SET svgrotx='428.8' , svgroty='472.8' WHERE id=1415; -- Pana Pana/Guainía
      UPDATE msip_municipio SET svgrotx='210' , svgroty='245.2' WHERE id=1113; -- San Carlos/Córdoba
      UPDATE msip_municipio SET svgrotx='459.4' , svgroty='456' WHERE id=1407; -- Puerto Colombia/Guainía
      UPDATE msip_municipio SET svgrotx='492.8' , svgroty='469.7' WHERE id=1406; -- San Felipe/Guainía
      UPDATE msip_municipio SET svgrotx='304.1' , svgroty='487.4' WHERE id=201; -- Calamar/Guaviare
      UPDATE msip_municipio SET svgrotx='357.4' , svgroty='468.2' WHERE id=433; -- El Retorno/Guaviare
      UPDATE msip_municipio SET svgrotx='336.1' , svgroty='495.5' WHERE id=335; -- Miraflores/Guaviare
      UPDATE msip_municipio SET svgrotx='201.5' , svgroty='473' WHERE id=420; -- Elías/Huila
      UPDATE msip_municipio SET svgrotx='214.1' , svgroty='467.3' WHERE id=506; -- Garzón/Huila
      UPDATE msip_municipio SET svgrotx='332.9' , svgroty='460.7' WHERE id=51; -- San José del Guaviare/Guaviare
      UPDATE msip_municipio SET svgrotx='199.5' , svgroty='483.2' WHERE id=988; -- Acevedo/Huila
      UPDATE msip_municipio SET svgrotx='215.6' , svgroty='460.4' WHERE id=544; -- Gigante/Huila
      UPDATE msip_municipio SET svgrotx='210.1' , svgroty='473.6' WHERE id=569; -- Guadalupe/Huila
      UPDATE msip_municipio SET svgrotx='150.4' , svgroty='497.4' WHERE id=1125; -- Sandoná/Nariño
      UPDATE msip_municipio SET svgrotx='140.8' , svgroty='497.4' WHERE id=1153; -- Santacruz/Nariño
      UPDATE msip_municipio SET svgrotx='142.9' , svgroty='506' WHERE id=1188; -- Sapuyes/Nariño
      UPDATE msip_municipio SET svgrotx='297.3' , svgroty='318.3' WHERE id=1115; -- San Gil/Santander
      UPDATE msip_municipio SET svgrotx='287.3' , svgroty='368.7' WHERE id=1284; -- Tenza/Boyacá
      UPDATE msip_municipio SET svgrotx='207.1' , svgroty='453.5' WHERE id=806; -- Nátaga/Huila
      UPDATE msip_municipio SET svgrotx='230.9' , svgroty='296.6' WHERE id=690; -- Anorí/Antioquia
      UPDATE msip_municipio SET svgrotx='212' , svgroty='441.6' WHERE id=1110; -- Santa María/Huila
      UPDATE msip_municipio SET svgrotx='233.6' , svgroty='326.8' WHERE id=1087; -- San Rafael/Antioquia
      UPDATE msip_municipio SET svgrotx='293.1' , svgroty='377.7' WHERE id=1142; -- Santa María/Boyacá
      UPDATE msip_municipio SET svgrotx='281.3' , svgroty='346.4' WHERE id=1150; -- Santa Sofía/Boyacá
      UPDATE msip_municipio SET svgrotx='181.1' , svgroty='491.4' WHERE id=1175; -- Santa Rosa/Cauca
      UPDATE msip_municipio SET svgrotx='258.9' , svgroty='389.3' WHERE id=1199; -- Sibaté/Cundinamarca
      UPDATE msip_municipio SET svgrotx='205.6' , svgroty='464.8' WHERE id=918; -- Pital/Huila
      UPDATE msip_municipio SET svgrotx='194.8' , svgroty='479.6' WHERE id=926; -- Pitalito/Huila
      UPDATE msip_municipio SET svgrotx='226.9' , svgroty='446.8' WHERE id=1029; -- Rivera/Huila
      UPDATE msip_municipio SET svgrotx='192.5' , svgroty='469.7' WHERE id=1072; -- Saladoblanco/Huila
      UPDATE msip_municipio SET svgrotx='290.8' , svgroty='354.8' WHERE id=1235; -- Soracá/Boyacá
      UPDATE msip_municipio SET svgrotx='268.7' , svgroty='374.9' WHERE id=1225; -- Sopó/Cundinamarca
      UPDATE msip_municipio SET svgrotx='303.6' , svgroty='170' WHERE id=1461; -- Distracción/La Guajira
      UPDATE msip_municipio SET svgrotx='305.6' , svgroty='179.5' WHERE id=110; -- El Molino/La Guajira
      UPDATE msip_municipio SET svgrotx='310.9' , svgroty='329.9' WHERE id=1248; -- Susacón/Boyacá
      UPDATE msip_municipio SET svgrotx='280.6' , svgroty='349.6' WHERE id=1249; -- Sutamarchán/Boyacá
      UPDATE msip_municipio SET svgrotx='207.9' , svgroty='444.5' WHERE id=1308; -- Teruel/Huila
      UPDATE msip_municipio SET svgrotx='257.4' , svgroty='178.8' WHERE id=467; -- El Retén/Magdalena
      UPDATE msip_municipio SET svgrotx='301.9' , svgroty='271.1' WHERE id=1388; -- Villa Caro/Norte de Santander
      UPDATE msip_municipio SET svgrotx='200.3' , svgroty='346.5' WHERE id=1453; -- Betania/Antioquia
      UPDATE msip_municipio SET svgrotx='215.2' , svgroty='299.3' WHERE id=83; -- Briceño/Antioquia
      UPDATE msip_municipio SET svgrotx='319.3' , svgroty='277.2' WHERE id=1397; -- Villa del Rosario/Norte de Santander
      UPDATE msip_municipio SET svgrotx='165.9' , svgroty='499.4' WHERE id=370; -- Colón/Putumayo
      UPDATE msip_municipio SET svgrotx='225.4' , svgroty='281.2' WHERE id=132; -- Cáceres/Antioquia
      UPDATE msip_municipio SET svgrotx='178.8' , svgroty='502.7' WHERE id=40; -- Mocoa/Putumayo
      UPDATE msip_municipio SET svgrotx='199.9' , svgroty='322.7' WHERE id=139; -- Caicedo/Antioquia
      UPDATE msip_municipio SET svgrotx='167' , svgroty='518.7' WHERE id=575; -- Orito/Putumayo
      UPDATE msip_municipio SET svgrotx='248.5' , svgroty='179.2' WHERE id=1016; -- Remolino/Magdalena
      UPDATE msip_municipio SET svgrotx='189' , svgroty='526.3' WHERE id=940; -- Puerto Asís/Putumayo
      UPDATE msip_municipio SET svgrotx='318.2' , svgroty='265.4' WHERE id=32; -- San José de Cúcuta/Norte de Santander
      UPDATE msip_municipio SET svgrotx='311.4' , svgroty='272.8' WHERE id=1119; -- Santiago/Norte de Santander
      UPDATE msip_municipio SET svgrotx='308.1' , svgroty='260.1' WHERE id=1189; -- Sardinata/Norte de Santander
      UPDATE msip_municipio SET svgrotx='308.7' , svgroty='296.8' WHERE id=1201; -- Silos/Norte de Santander
      UPDATE msip_municipio SET svgrotx='297.8' , svgroty='243.1' WHERE id=1306; -- Teorama/Norte de Santander
      UPDATE msip_municipio SET svgrotx='323.7' , svgroty='294.5' WHERE id=1330; -- Toledo/Norte de Santander
      UPDATE msip_municipio SET svgrotx='183.5' , svgroty='516.5' WHERE id=942; -- Puerto Caicedo/Putumayo
      UPDATE msip_municipio SET svgrotx='213.8' , svgroty='324.9' WHERE id=1404; -- Bello/Antioquia
      UPDATE msip_municipio SET svgrotx='211.6' , svgroty='314.4' WHERE id=1372; -- Belmira/Antioquia
      UPDATE msip_municipio SET svgrotx='166.3' , svgroty='504.1' WHERE id=1228; -- Santiago/Putumayo
      UPDATE msip_municipio SET svgrotx='387.6' , svgroty='665.6' WHERE id=907; -- Puerto Nariño/Amazonas
      UPDATE msip_municipio SET svgrotx='339.9' , svgroty='578.7' WHERE id=1089; -- Puerto Santander/Amazonas
      UPDATE msip_municipio SET svgrotx='399.2' , svgroty='627.5' WHERE id=1282; -- Tarapacá/Amazonas
      UPDATE msip_municipio SET svgrotx='202.4' , svgroty='514.4' WHERE id=946; -- Puerto Guzmán/Putumayo
      UPDATE msip_municipio SET svgrotx='229.5' , svgroty='539.6' WHERE id=953; -- Puerto Leguízamo/Putumayo
      UPDATE msip_municipio SET svgrotx='171.9' , svgroty='502.5' WHERE id=1217; -- San Francisco/Putumayo
      UPDATE msip_municipio SET svgrotx='170.5' , svgroty='531.1' WHERE id=1222; -- San Miguel/Putumayo
      UPDATE msip_municipio SET svgrotx='169.2' , svgroty='499.6' WHERE id=1209; -- Sibundoy/Putumayo
      UPDATE msip_municipio SET svgrotx='169' , svgroty='527.5' WHERE id=1381; -- Valle del Guamuez/Putumayo
      UPDATE msip_municipio SET svgrotx='209.1' , svgroty='388.1' WHERE id=19; -- Armenia/Quindío
      UPDATE msip_municipio SET svgrotx='208.5' , svgroty='392.7' WHERE id=111; -- Buenavista/Quindío
      UPDATE msip_municipio SET svgrotx='210.6' , svgroty='389.8' WHERE id=165; -- Calarcá/Quindío
      UPDATE msip_municipio SET svgrotx='210.8' , svgroty='385' WHERE id=297; -- Circasia/Quindío
      UPDATE msip_municipio SET svgrotx='178.5' , svgroty='275.8' WHERE id=196; -- Carepa/Antioquia
      UPDATE msip_municipio SET svgrotx='223.4' , svgroty='311.4' WHERE id=214; -- Carolina/Antioquia
      UPDATE msip_municipio SET svgrotx='231.6' , svgroty='274.6' WHERE id=222; -- Caucasia/Antioquia
      UPDATE msip_municipio SET svgrotx='199.6' , svgroty='342.6' WHERE id=79; -- Ciudad Bolívar/Antioquia
      UPDATE msip_municipio SET svgrotx='228.1' , svgroty='337.1' WHERE id=299; -- Cocorná/Antioquia
      UPDATE msip_municipio SET svgrotx='189.6' , svgroty='304.8' WHERE id=403; -- Dabeiba/Antioquia
      UPDATE msip_municipio SET svgrotx='224.3' , svgroty='337.3' WHERE id=200; -- El Carmen de Viboral/Antioquia
      UPDATE msip_municipio SET svgrotx='225.3' , svgroty='332.8' WHERE id=1151; -- El Santuario/Antioquia
      UPDATE msip_municipio SET svgrotx='209.5' , svgroty='332.8' WHERE id=616; -- Angelópolis/Antioquia
      UPDATE msip_municipio SET svgrotx='210.5' , svgroty='340.8' WHERE id=486; -- Fredonia/Antioquia
      UPDATE msip_municipio SET svgrotx='343.8' , svgroty='325' WHERE id=1279; -- Tame/Arauca
      UPDATE msip_municipio SET svgrotx='218.9' , svgroty='327.8' WHERE id=567; -- Guarne/Antioquia
      UPDATE msip_municipio SET svgrotx='206.2' , svgroty='331.3' WHERE id=973; -- Armenia/Antioquia
      UPDATE msip_municipio SET svgrotx='212.5' , svgroty='335.3' WHERE id=145; -- Caldas/Antioquia
      UPDATE msip_municipio SET svgrotx='212.2' , svgroty='352.2' WHERE id=194; -- Caramanta/Antioquia
      UPDATE msip_municipio SET svgrotx='215.3' , svgroty='331.8' WHERE id=465; -- Envigado/Antioquia
      UPDATE msip_municipio SET svgrotx='269.5' , svgroty='231.1' WHERE id=421; -- El Banco/Magdalena
      UPDATE msip_municipio SET svgrotx='253.9' , svgroty='186.8' WHERE id=927; -- Pivijay/Magdalena
      UPDATE msip_municipio SET svgrotx='256.3' , svgroty='172.6' WHERE id=945; -- Puebloviejo/Magdalena
      UPDATE msip_municipio SET svgrotx='259.5' , svgroty='196.9' WHERE id=1070; -- Sabanas de San Ángel/Magdalena
      UPDATE msip_municipio SET svgrotx='270.6' , svgroty='163' WHERE id=52; -- Santa Marta/Magdalena
      UPDATE msip_municipio SET svgrotx='245' , svgroty='197' WHERE id=1459; -- Zapayán/Magdalena
      UPDATE msip_municipio SET svgrotx='303.2' , svgroty='394.5' WHERE id=136; -- Cabuyaro/Meta
      UPDATE msip_municipio SET svgrotx='264' , svgroty='412' WHERE id=380; -- Cubarral/Meta
      UPDATE msip_municipio SET svgrotx='201.7' , svgroty='314.8' WHERE id=546; -- Giraldo/Antioquia
      UPDATE msip_municipio SET svgrotx='218.6' , svgroty='324.2' WHERE id=549; -- Girardota/Antioquia
      UPDATE msip_municipio SET svgrotx='228.6' , svgroty='328.5' WHERE id=576; -- Guatapé/Antioquia
      UPDATE msip_municipio SET svgrotx='208.2' , svgroty='329.9' WHERE id=597; -- Heliconia/Antioquia
      UPDATE msip_municipio SET svgrotx='203' , svgroty='344' WHERE id=608; -- Hispania/Antioquia
      UPDATE msip_municipio SET svgrotx='226.9' , svgroty='313.2' WHERE id=552; -- Gómez Plata/Antioquia
      UPDATE msip_municipio SET svgrotx='213' , svgroty='331.1' WHERE id=617; -- Itagüí/Antioquia
      UPDATE msip_municipio SET svgrotx='260.6' , svgroty='223.5' WHERE id=1144; -- San Sebastián de Buenavista/Magdalena
      UPDATE msip_municipio SET svgrotx='207.7' , svgroty='344.9' WHERE id=626; -- Jericó/Antioquia
      UPDATE msip_municipio SET svgrotx='245.1' , svgroty='217.6' WHERE id=1186; -- Santa Bárbara de Pinto/Magdalena
      UPDATE msip_municipio SET svgrotx='247.3' , svgroty='170.8' WHERE id=1208; -- Sitionuevo/Magdalena
      UPDATE msip_municipio SET svgrotx='243.1' , svgroty='203.6' WHERE id=1283; -- Tenerife/Magdalena
      UPDATE msip_municipio SET svgrotx='262.4' , svgroty='173.9' WHERE id=1462; -- Zona Bananera/Magdalena
      UPDATE msip_municipio SET svgrotx='276.1' , svgroty='404.6' WHERE id=986; -- Acacías/Meta
      UPDATE msip_municipio SET svgrotx='302.1' , svgroty='388.7' WHERE id=106; -- Barranca de Upía/Meta
      UPDATE msip_municipio SET svgrotx='283.4' , svgroty='411.5' WHERE id=216; -- Castilla La Nueva/Meta
      UPDATE msip_municipio SET svgrotx='128.2' , svgroty='491.9' WHERE id=1270; -- Barbacoas/Nariño
      UPDATE msip_municipio SET svgrotx='211.9' , svgroty='332.5' WHERE id=646; -- La Estrella/Antioquia
      UPDATE msip_municipio SET svgrotx='213.2' , svgroty='345.8' WHERE id=655; -- La Pintada/Antioquia
      UPDATE msip_municipio SET svgrotx='346.6' , svgroty='409' WHERE id=941; -- Puerto Gaitán/Meta
      UPDATE msip_municipio SET svgrotx='292.9' , svgroty='432' WHERE id=960; -- Puerto Lleras/Meta
      UPDATE msip_municipio SET svgrotx='312.1' , svgroty='403.3' WHERE id=954; -- Puerto López/Meta
      UPDATE msip_municipio SET svgrotx='295.1' , svgroty='447.9' WHERE id=974; -- Puerto Rico/Meta
      UPDATE msip_municipio SET svgrotx='292' , svgroty='410.6' WHERE id=1118; -- San Carlos de Guaroa/Meta
      UPDATE msip_municipio SET svgrotx='274.3' , svgroty='430.7' WHERE id=1124; -- San Juan de Arama/Meta
      UPDATE msip_municipio SET svgrotx='299.8' , svgroty='419.3' WHERE id=1139; -- San Martín/Meta
      UPDATE msip_municipio SET svgrotx='253.2' , svgroty='439.2' WHERE id=630; -- Uribe/Meta
      UPDATE msip_municipio SET svgrotx='207.4' , svgroty='316.4' WHERE id=852; -- Olaya/Antioquia
      UPDATE msip_municipio SET svgrotx='241.8' , svgroty='173.9' WHERE id=1046; -- Sabanagrande/Atlántico
      UPDATE msip_municipio SET svgrotx='160.9' , svgroty='495.7' WHERE id=109; -- Buesaco/Nariño
      UPDATE msip_municipio SET svgrotx='164.2' , svgroty='485.7' WHERE id=336; -- Colón/Nariño
      UPDATE msip_municipio SET svgrotx='204.4' , svgroty='343.3' WHERE id=959; -- Pueblorrico/Antioquia
      UPDATE msip_municipio SET svgrotx='244.1' , svgroty='338.2' WHERE id=976; -- Puerto Triunfo/Antioquia
      UPDATE msip_municipio SET svgrotx='205.7' , svgroty='341.6' WHERE id=1277; -- Tarso/Antioquia
      UPDATE msip_municipio SET svgrotx='209.8' , svgroty='302.6' WHERE id=1329; -- Toledo/Antioquia
      UPDATE msip_municipio SET svgrotx='212.3' , svgroty='349' WHERE id=1370; -- Valparaíso/Antioquia
      UPDATE msip_municipio SET svgrotx='340.1' , svgroty='306.5' WHERE id=1193; -- Saravena/Arauca
      UPDATE msip_municipio SET svgrotx='238.8' , svgroty='175' WHERE id=932; -- Polonuevo/Atlántico
      UPDATE msip_municipio SET svgrotx='235.4' , svgroty='189.1' WHERE id=1108; -- Santa Lucía/Atlántico
      UPDATE msip_municipio SET svgrotx='142.3' , svgroty='510.3' WHERE id=371; -- Aldana/Nariño
      UPDATE msip_municipio SET svgrotx='241' , svgroty='176' WHERE id=1129; -- Santo Tomás/Atlántico
      UPDATE msip_municipio SET svgrotx='154.9' , svgroty='510.8' WHERE id=491; -- Funes/Nariño
      UPDATE msip_municipio SET svgrotx='229.8' , svgroty='189.9' WHERE id=1229; -- Soplaviento/Bolívar
      UPDATE msip_municipio SET svgrotx='137.9' , svgroty='467.3' WHERE id=437; -- El Charco/Nariño
      UPDATE msip_municipio SET svgrotx='148.1' , svgroty='501.9' WHERE id=574; -- Guaitarilla/Nariño
      UPDATE msip_municipio SET svgrotx='223.2' , svgroty='330.9' WHERE id=754; -- Marinilla/Antioquia
      UPDATE msip_municipio SET svgrotx='213' , svgroty='328.1' WHERE id=38; -- Medellín/Antioquia
      UPDATE msip_municipio SET svgrotx='175' , svgroty='309.3' WHERE id=796; -- Murindó/Antioquia
      UPDATE msip_municipio SET svgrotx='152.7' , svgroty='495.4' WHERE id=647; -- La Florida/Nariño
      UPDATE msip_municipio SET svgrotx='142' , svgroty='487.7' WHERE id=651; -- La Llanada/Nariño
      UPDATE msip_municipio SET svgrotx='124.7' , svgroty='459.9' WHERE id=656; -- La Tola/Nariño
      UPDATE msip_municipio SET svgrotx='160.8' , svgroty='486.1' WHERE id=664; -- La Unión/Nariño
      UPDATE msip_municipio SET svgrotx='154.7' , svgroty='474.7' WHERE id=704; -- Leiva/Nariño
      UPDATE msip_municipio SET svgrotx='288.6' , svgroty='372.7' WHERE id=373; -- Almeida/Boyacá
      UPDATE msip_municipio SET svgrotx='286.7' , svgroty='345.2' WHERE id=864; -- Arcabuco/Boyacá
      UPDATE msip_municipio SET svgrotx='306.8' , svgroty='339.7' WHERE id=1455; -- Betéitiva/Boyacá
      UPDATE msip_municipio SET svgrotx='288.8' , svgroty='356.3' WHERE id=81; -- Boyacá/Boyacá
      UPDATE msip_municipio SET svgrotx='271' , svgroty='348.8' WHERE id=82; -- Briceño/Boyacá
      UPDATE msip_municipio SET svgrotx='249.2' , svgroty='305.1' WHERE id=1015; -- Remedios/Antioquia
      UPDATE msip_municipio SET svgrotx='219.8' , svgroty='331.6' WHERE id=1026; -- Rionegro/Antioquia
      UPDATE msip_municipio SET svgrotx='269.4' , svgroty='354.7' WHERE id=87; -- Buenavista/Boyacá
      UPDATE msip_municipio SET svgrotx='233.7' , svgroty='340.8' WHERE id=1059; -- San Francisco/Antioquia
      UPDATE msip_municipio SET svgrotx='209.7' , svgroty='322.4' WHERE id=1065; -- San Jerónimo/Antioquia
      UPDATE msip_municipio SET svgrotx='210.9' , svgroty='309.3' WHERE id=1068; -- San José de La Montaña/Antioquia
      UPDATE msip_municipio SET svgrotx='214.3' , svgroty='322.2' WHERE id=1081; -- San Pedro de Los Milagros/Antioquia
      UPDATE msip_municipio SET svgrotx='189.2' , svgroty='256.1' WHERE id=1083; -- San Pedro de Urabá/Antioquia
      UPDATE msip_municipio SET svgrotx='202.7' , svgroty='319.2' WHERE id=727; -- Santa Fé de Antioquia/Antioquia
      UPDATE msip_municipio SET svgrotx='247.7' , svgroty='294.5' WHERE id=1194; -- Segovia/Antioquia
      UPDATE msip_municipio SET svgrotx='220' , svgroty='287.1' WHERE id=1274; -- Tarazá/Antioquia
      UPDATE msip_municipio SET svgrotx='222.6' , svgroty='201.8' WHERE id=759; -- María La Baja/Bolívar
      UPDATE msip_municipio SET svgrotx='251.2' , svgroty='272.3' WHERE id=775; -- Montecristo/Bolívar
      UPDATE msip_municipio SET svgrotx='267.6' , svgroty='260.9' WHERE id=791; -- Morales/Bolívar
      UPDATE msip_municipio SET svgrotx='263.4' , svgroty='252.3' WHERE id=812; -- Norosí/Bolívar
      UPDATE msip_municipio SET svgrotx='254.9' , svgroty='239.1' WHERE id=920; -- Pinillos/Bolívar
      UPDATE msip_municipio SET svgrotx='272.7' , svgroty='244.8' WHERE id=966; -- Regidor/Bolívar
      UPDATE msip_municipio SET svgrotx='265.1' , svgroty='254.5' WHERE id=1014; -- Río Viejo/Bolívar
      UPDATE msip_municipio SET svgrotx='226.7' , svgroty='188.9' WHERE id=1053; -- San Estanislao/Bolívar
      UPDATE msip_municipio SET svgrotx='256.1' , svgroty='231.9' WHERE id=1057; -- San Fernando/Bolívar
      UPDATE msip_municipio SET svgrotx='245.9' , svgroty='261.5' WHERE id=1064; -- San Jacinto del Cauca/Bolívar
      UPDATE msip_municipio SET svgrotx='231.9' , svgroty='202' WHERE id=1066; -- San Juan Nepomuceno/Bolívar
      UPDATE msip_municipio SET svgrotx='262.4' , svgroty='289.3' WHERE id=1095; -- San Pablo/Bolívar
      UPDATE msip_municipio SET svgrotx='257.4' , svgroty='278.2' WHERE id=1126; -- Santa Rosa/Bolívar
      UPDATE msip_municipio SET svgrotx='257.4' , svgroty='278.2' WHERE id=1138; -- Santa Rosa del Sur/Bolívar
      UPDATE msip_municipio SET svgrotx='266.7' , svgroty='275.1' WHERE id=1204; -- Simití/Bolívar
      UPDATE msip_municipio SET svgrotx='228.2' , svgroty='370.2' WHERE id=220; -- Casabianca/Tolima
      UPDATE msip_municipio SET svgrotx='212.6' , svgroty='414.2' WHERE id=243; -- Chaparral/Tolima
      UPDATE msip_municipio SET svgrotx='236.3' , svgroty='393' WHERE id=333; -- Coello/Tolima
      UPDATE msip_municipio SET svgrotx='271.9' , svgroty='351.6' WHERE id=167; -- Caldas/Boyacá
      UPDATE msip_municipio SET svgrotx='303.1' , svgroty='338.5' WHERE id=238; -- Cerinza/Boyacá
      UPDATE msip_municipio SET svgrotx='220.5' , svgroty='294.8' WHERE id=1365; -- Valdivia/Antioquia
      UPDATE msip_municipio SET svgrotx='290.2' , svgroty='364.3' WHERE id=257; -- Chinavita/Boyacá
      UPDATE msip_municipio SET svgrotx='289.3' , svgroty='375.5' WHERE id=406; -- Chivor/Boyacá
      UPDATE msip_municipio SET svgrotx='299.1' , svgroty='256.6' WHERE id=595; -- Hacarí/Norte de Santander
      UPDATE msip_municipio SET svgrotx='288.1' , svgroty='278.5' WHERE id=650; -- La Esperanza/Norte de Santander
      UPDATE msip_municipio SET svgrotx='241.7' , svgroty='312.6' WHERE id=1413; -- Yalí/Antioquia
      UPDATE msip_municipio SET svgrotx='218.7' , svgroty='303.1' WHERE id=1416; -- Yarumal/Antioquia
      UPDATE msip_municipio SET svgrotx='306.9' , svgroty='343.2' WHERE id=365; -- Corrales/Boyacá
      UPDATE msip_municipio SET svgrotx='237.1' , svgroty='190.5' WHERE id=1241; -- Suan/Atlántico
      UPDATE msip_municipio SET svgrotx='251.4' , svgroty='247.6' WHERE id=989; -- Achí/Bolívar
      UPDATE msip_municipio SET svgrotx='261.1' , svgroty='241.4' WHERE id=1197; -- Barranco de Loba/Bolívar
      UPDATE msip_municipio SET svgrotx='237.7' , svgroty='209.3' WHERE id=1424; -- Zambrano/Bolívar
      UPDATE msip_municipio SET svgrotx='221.4' , svgroty='229.4' WHERE id=1092; -- Sampués/Sucre
      UPDATE msip_municipio SET svgrotx='314.8' , svgroty='325.5' WHERE id=1460; -- Boavita/Boyacá
      UPDATE msip_municipio SET svgrotx='235.7' , svgroty='240' WHERE id=1112; -- San Benito Abad/Sucre
      UPDATE msip_municipio SET svgrotx='218.5' , svgroty='218.1' WHERE id=1336; -- San José de Toluviejo/Sucre
      UPDATE msip_municipio SET svgrotx='226.5' , svgroty='225.2' WHERE id=1176; -- San Juan de Betulia/Sucre
      UPDATE msip_municipio SET svgrotx='231.5' , svgroty='226.5' WHERE id=1200; -- San Luis de Sincé/Sucre
      UPDATE msip_municipio SET svgrotx='227.5' , svgroty='249.1' WHERE id=1180; -- San Marcos/Sucre
      UPDATE msip_municipio SET svgrotx='215.8' , svgroty='207.2' WHERE id=1183; -- San Onofre/Sucre
      UPDATE msip_municipio SET svgrotx='232.8' , svgroty='221.9' WHERE id=1184; -- San Pedro/Sucre
      UPDATE msip_municipio SET svgrotx='215.7' , svgroty='217.1' WHERE id=1331; -- Santiago de Tolú/Sucre
      UPDATE msip_municipio SET svgrotx='218.7' , svgroty='223.9' WHERE id=53; -- Sincelejo/Sucre
      UPDATE msip_municipio SET svgrotx='266.9' , svgroty='243.2' WHERE id=1086; -- San Martín de Loba/Bolívar
      UPDATE msip_municipio SET svgrotx='225.3' , svgroty='179.6' WHERE id=1103; -- Santa Catalina/Bolívar
      UPDATE msip_municipio SET svgrotx='310.5' , svgroty='319.8' WHERE id=369; -- Covarachía/Boyacá
      UPDATE msip_municipio SET svgrotx='245.6' , svgroty='224.7' WHERE id=1260; -- Talaigua Nuevo/Bolívar
      UPDATE msip_municipio SET svgrotx='305.5' , svgroty='336.9' WHERE id=1386; -- Belén/Boyacá
      UPDATE msip_municipio SET svgrotx='298.4' , svgroty='363.5' WHERE id=1450; -- Berbeo/Boyacá
      UPDATE msip_municipio SET svgrotx='224.4' , svgroty='438.4' WHERE id=42; -- Neiva/Huila
      UPDATE msip_municipio SET svgrotx='235.3' , svgroty='426' WHERE id=412; -- Alpujarra/Tolima
      UPDATE msip_municipio SET svgrotx='240.1' , svgroty='377.1' WHERE id=537; -- Ambalema/Tolima
      UPDATE msip_municipio SET svgrotx='239.2' , svgroty='370.2' WHERE id=923; -- Armero/Tolima
      UPDATE msip_municipio SET svgrotx='217' , svgroty='424.9' WHERE id=1091; -- Ataco/Tolima
      UPDATE msip_municipio SET svgrotx='137.5' , svgroty='501.1' WHERE id=748; -- Mallama/Nariño
      UPDATE msip_municipio SET svgrotx='305.7' , svgroty='356.6' WHERE id=789; -- Aquitania/Boyacá
      UPDATE msip_municipio SET svgrotx='192.6' , svgroty='416.3' WHERE id=429; -- El Cerrito/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='210.4' , svgroty='455.5' WHERE id=1281; -- Tesalia/Huila
      UPDATE msip_municipio SET svgrotx='314.2' , svgroty='286.9' WHERE id=883; -- Pamplonita/Norte de Santander
      UPDATE msip_municipio SET svgrotx='318.5' , svgroty='282.7' WHERE id=984; -- Ragonvalia/Norte de Santander
      UPDATE msip_municipio SET svgrotx='241.2' , svgroty='170.5' WHERE id=1224; -- Soledad/Atlántico
      UPDATE msip_municipio SET svgrotx='265.1' , svgroty='382.9' WHERE id=24; -- Bogotá, D.C./Bogotá, D.C.
      UPDATE msip_municipio SET svgrotx='260.7' , svgroty='243.3' WHERE id=535; -- Altos del Rosario/Bolívar
      UPDATE msip_municipio SET svgrotx='263.9' , svgroty='258.1' WHERE id=726; -- Arenal/Bolívar
      UPDATE msip_municipio SET svgrotx='223.8' , svgroty='182.2' WHERE id=379; -- Clemencia/Bolívar
      UPDATE msip_municipio SET svgrotx='237.2' , svgroty='217' WHERE id=361; -- Córdoba/Bolívar
      UPDATE msip_municipio SET svgrotx='228.7' , svgroty='211.6' WHERE id=418; -- El Carmen de Bolívar/Bolívar
      UPDATE msip_municipio SET svgrotx='261' , svgroty='235.2' WHERE id=541; -- Hatillo de Loba/Bolívar
      UPDATE msip_municipio SET svgrotx='260.7' , svgroty='233.2' WHERE id=753; -- Margarita/Bolívar
      UPDATE msip_municipio SET svgrotx='286.7' , svgroty='353.2' WHERE id=384; -- Cucaita/Boyacá
      UPDATE msip_municipio SET svgrotx='231.3' , svgroty='188.5' WHERE id=1034; -- San Cristóbal/Bolívar
      UPDATE msip_municipio SET svgrotx='202.5' , svgroty='474.7' WHERE id=1314; -- Timaná/Huila
      UPDATE msip_municipio SET svgrotx='264.5' , svgroty='207.2' WHERE id=962; -- Ariguaní/Magdalena
      UPDATE msip_municipio SET svgrotx='249.9' , svgroty='197.8' WHERE id=254; -- Chivolo/Magdalena
      UPDATE msip_municipio SET svgrotx='266.3' , svgroty='171.6' WHERE id=285; -- Ciénaga/Magdalena
      UPDATE msip_municipio SET svgrotx='190.1' , svgroty='386.9' WHERE id=438; -- El Dovio/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='193.9' , svgroty='428.5' WHERE id=478; -- Florida/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='193' , svgroty='413.9' WHERE id=545; -- Ginebra/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='189.6' , svgroty='412.5' WHERE id=563; -- Guacarí/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='195.8' , svgroty='409.5' WHERE id=112; -- Guadalajara de Buga/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='179.9' , svgroty='415.4' WHERE id=637; -- La Cumbre/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='196.6' , svgroty='387.2' WHERE id=694; -- La Unión/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='188.3' , svgroty='397.2' WHERE id=1340; -- Trujillo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='197.9' , svgroty='404.7' WHERE id=1344; -- Tuluá/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='207.1' , svgroty='381.1' WHERE id=1358; -- Ulloa/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='263.4' , svgroty='436.8' WHERE id=589; -- Mesetas/Meta
      UPDATE msip_municipio SET svgrotx='310.3' , svgroty='449.2' WHERE id=771; -- Puerto Concordia/Meta
      UPDATE msip_municipio SET svgrotx='201.4' , svgroty='385' WHERE id=821; -- Obando/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='192.3' , svgroty='420.4' WHERE id=881; -- Palmira/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='194' , svgroty='424.8' WHERE id=936; -- Pradera/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='181.5' , svgroty='412' WHERE id=1019; -- Restrepo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='188' , svgroty='401.5' WHERE id=1031; -- Riofrío/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='192.8' , svgroty='405.8' WHERE id=1096; -- San Pedro/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='197.3' , svgroty='383.6' WHERE id=1338; -- Toro/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='183.8' , svgroty='413.7' WHERE id=1385; -- Vijes/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='321.6' , svgroty='325' WHERE id=419; -- El Cocuy/Boyacá
      UPDATE msip_municipio SET svgrotx='311' , svgroty='343.8' WHERE id=504; -- Gámeza/Boyacá
      UPDATE msip_municipio SET svgrotx='291.4' , svgroty='368.2' WHERE id=509; -- Garagoa/Boyacá
      UPDATE msip_municipio SET svgrotx='319.5' , svgroty='319.9' WHERE id=430; -- El Espino/Boyacá
      UPDATE msip_municipio SET svgrotx='318.3' , svgroty='322' WHERE id=559; -- Guacamayas/Boyacá
      UPDATE msip_municipio SET svgrotx='285.3' , svgroty='370.5' WHERE id=579; -- Guateque/Boyacá
      UPDATE msip_municipio SET svgrotx='285.1' , svgroty='373.6' WHERE id=583; -- Guayatá/Boyacá
      UPDATE msip_municipio SET svgrotx='316.7' , svgroty='339.5' WHERE id=1219; -- Socotá/Boyacá
      UPDATE msip_municipio SET svgrotx='296.8' , svgroty='370.6' WHERE id=171; -- Campohermoso/Boyacá
      UPDATE msip_municipio SET svgrotx='266.9' , svgroty='356' WHERE id=359; -- Coper/Boyacá
      UPDATE msip_municipio SET svgrotx='302.9' , svgroty='350.1' WHERE id=620; -- Iza/Boyacá
      UPDATE msip_municipio SET svgrotx='316.5' , svgroty='328.1' WHERE id=701; -- La Uvita/Boyacá
      UPDATE msip_municipio SET svgrotx='291.6' , svgroty='371.9' WHERE id=730; -- Macanal/Boyacá
      UPDATE msip_municipio SET svgrotx='307.5' , svgroty='347.4' WHERE id=783; -- Monguí/Boyacá
      UPDATE msip_municipio SET svgrotx='228' , svgroty='372.7' WHERE id=1387; -- Villahermosa/Tolima
      UPDATE msip_municipio SET svgrotx='286.6' , svgroty='349.4' WHERE id=398; -- Chíquiza/Boyacá
      UPDATE msip_municipio SET svgrotx='293' , svgroty='351.8' WHERE id=282; -- Chivatá/Boyacá
      UPDATE msip_municipio SET svgrotx='179.5' , svgroty='432.2' WHERE id=622; -- Jamundí/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='193.8' , svgroty='389.9' WHERE id=1038; -- Roldanillo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='186.4' , svgroty='408.1' WHERE id=1421; -- Yotoco/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='198.5' , svgroty='392' WHERE id=1427; -- Zarzal/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='304.2' , svgroty='344.7' WHERE id=814; -- Nobsa/Boyacá
      UPDATE msip_municipio SET svgrotx='405.5' , svgroty='566.2' WHERE id=1084; -- Taraira/Vaupés
      UPDATE msip_municipio SET svgrotx='416.6' , svgroty='399.2' WHERE id=1246; -- Cumaribo/Vichada
      UPDATE msip_municipio SET svgrotx='286.5' , svgroty='359.1' WHERE id=817; -- Nuevo Colón/Boyacá
      UPDATE msip_municipio SET svgrotx='288.6' , svgroty='366.1' WHERE id=865; -- Pachavita/Boyacá
      UPDATE msip_municipio SET svgrotx='320' , svgroty='322.2' WHERE id=885; -- Panqueba/Boyacá
      UPDATE msip_municipio SET svgrotx='163.5' , svgroty='491.1' WHERE id=287; -- Albán/Nariño
      UPDATE msip_municipio SET svgrotx='327.5' , svgroty='306.9' WHERE id=381; -- Cubará/Boyacá
      UPDATE msip_municipio SET svgrotx='294.8' , svgroty='358.8' WHERE id=1037; -- Rondón/Boyacá
      UPDATE msip_municipio SET svgrotx='283.4' , svgroty='337.4' WHERE id=1080; -- San José de Pare/Boyacá
      UPDATE msip_municipio SET svgrotx='316.8' , svgroty='323.3' WHERE id=1102; -- San Mateo/Boyacá
      UPDATE msip_municipio SET svgrotx='303.7' , svgroty='351.1' WHERE id=389; -- Cuítiva/Boyacá
      UPDATE msip_municipio SET svgrotx='276.4' , svgroty='353.1' WHERE id=1109; -- San Miguel de Sema/Boyacá
      UPDATE msip_municipio SET svgrotx='285.4' , svgroty='335.2' WHERE id=1135; -- Santana/Boyacá
      UPDATE msip_municipio SET svgrotx='288.9' , svgroty='350.6' WHERE id=797; -- Motavita/Boyacá
      UPDATE msip_municipio SET svgrotx='280.8' , svgroty='354.4' WHERE id=1013; -- Ráquira/Boyacá
      UPDATE msip_municipio SET svgrotx='312.6' , svgroty='338.4' WHERE id=1223; -- Socha/Boyacá
      UPDATE msip_municipio SET svgrotx='260.9' , svgroty='346.1' WHERE id=858; -- Otanche/Boyacá
      UPDATE msip_municipio SET svgrotx='287.2' , svgroty='372.2' WHERE id=1231; -- Somondoco/Boyacá
      UPDATE msip_municipio SET svgrotx='161.3' , svgroty='491' WHERE id=861; -- Arboleda/Nariño
      UPDATE msip_municipio SET svgrotx='286.8' , svgroty='351.5' WHERE id=1233; -- Sora/Boyacá
      UPDATE msip_municipio SET svgrotx='287.1' , svgroty='370.1' WHERE id=1253; -- Sutatenza/Boyacá
      UPDATE msip_municipio SET svgrotx='278.8' , svgroty='351.7' WHERE id=1316; -- Tinjacá/Boyacá
      UPDATE msip_municipio SET svgrotx='312.2' , svgroty='322.7' WHERE id=1321; -- Tipacoque/Boyacá
      UPDATE msip_municipio SET svgrotx='295.8' , svgroty='366' WHERE id=772; -- Miraflores/Boyacá
      UPDATE msip_municipio SET svgrotx='285.1' , svgroty='340.1' WHERE id=1327; -- Togüí/Boyacá
      UPDATE msip_municipio SET svgrotx='307.3' , svgroty='345.1' WHERE id=1333; -- Tópaga/Boyacá
      UPDATE msip_municipio SET svgrotx='270.3' , svgroty='346.7' WHERE id=1343; -- Tununguá/Boyacá
      UPDATE msip_municipio SET svgrotx='284.5' , svgroty='360.8' WHERE id=1346; -- Turmequé/Boyacá
      UPDATE msip_municipio SET svgrotx='286.4' , svgroty='363.6' WHERE id=1356; -- Úmbita/Boyacá
      UPDATE msip_municipio SET svgrotx='284.4' , svgroty='348.6' WHERE id=709; -- Villa de Leyva/Boyacá
      UPDATE msip_municipio SET svgrotx='214.9' , svgroty='358' WHERE id=654; -- La Merced/Caldas
      UPDATE msip_municipio SET svgrotx='203.4' , svgroty='491.4' WHERE id=1457; -- Belén de Los Andaquíes/Caquetá
      UPDATE msip_municipio SET svgrotx='267.1' , svgroty='351.8' WHERE id=757; -- Maripí/Boyacá
      UPDATE msip_municipio SET svgrotx='213.3' , svgroty='354.3' WHERE id=758; -- Marmato/Caldas
      UPDATE msip_municipio SET svgrotx='232.3' , svgroty='360.8' WHERE id=762; -- Marquetalia/Caldas
      UPDATE msip_municipio SET svgrotx='210.4' , svgroty='509.5' WHERE id=1262; -- Solita/Caquetá
      UPDATE msip_municipio SET svgrotx='363.2' , svgroty='605.5' WHERE id=903; -- Puerto Arica/Amazonas
      UPDATE msip_municipio SET svgrotx='178.6' , svgroty='439' WHERE id=108; -- Buenos Aires/Cauca
      UPDATE msip_municipio SET svgrotx='292.8' , svgroty='356.2' WHERE id=1402; -- Viracachá/Boyacá
      UPDATE msip_municipio SET svgrotx='174.2' , svgroty='464.8' WHERE id=1040; -- Rosas/Cauca
      UPDATE msip_municipio SET svgrotx='182.2' , svgroty='439.6' WHERE id=1152; -- Santander de Quilichao/Cauca
      UPDATE msip_municipio SET svgrotx='193' , svgroty='439.9' WHERE id=1334; -- Toribío/Cauca
      UPDATE msip_municipio SET svgrotx='278.9' , svgroty='228.2' WHERE id=261; -- Chimichagua/Cesar
      UPDATE msip_municipio SET svgrotx='284.8' , svgroty='226.8' WHERE id=391; -- Curumaní/Cesar
      UPDATE msip_municipio SET svgrotx='291.7' , svgroty='197.9' WHERE id=1035; -- La Paz/Cesar
      UPDATE msip_municipio SET svgrotx='167.1' , svgroty='303.2' WHERE id=213; -- Carmen del Darién/Chocó
      UPDATE msip_municipio SET svgrotx='143.2' , svgroty='301.2' WHERE id=633; -- Juradó/Chocó
      UPDATE msip_municipio SET svgrotx='158.8' , svgroty='294.7' WHERE id=1028; -- Riosucio/Chocó
      UPDATE msip_municipio SET svgrotx='219.1' , svgroty='262' WHERE id=1273; -- Buenavista/Córdoba
      UPDATE msip_municipio SET svgrotx='251.4' , svgroty='367.7' WHERE id=978; -- Quebradanegra/Cundinamarca
      UPDATE msip_municipio SET svgrotx='260.3' , svgroty='353.5' WHERE id=699; -- La Victoria/Boyacá
      UPDATE msip_municipio SET svgrotx='257.6' , svgroty='358.8' WHERE id=1337; -- Topaipí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='287.4' , svgroty='379.5' WHERE id=1353; -- Ubalá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='211.9' , svgroty='355.3' WHERE id=1252; -- Supía/Caldas
      UPDATE msip_municipio SET svgrotx='230.6' , svgroty='346.8' WHERE id=922; -- Argelia/Antioquia
      UPDATE msip_municipio SET svgrotx='222.3' , svgroty='321.9' WHERE id=1271; -- Barbosa/Antioquia
      UPDATE msip_municipio SET svgrotx='291' , svgroty='360.3' WHERE id=985; -- Ramiriquí/Boyacá
      UPDATE msip_municipio SET svgrotx='213.7' , svgroty='361.4' WHERE id=474; -- Filadelfia/Caldas
      UPDATE msip_municipio SET svgrotx='206.2' , svgroty='387.4' WHERE id=790; -- Montenegro/Quindío
      UPDATE msip_municipio SET svgrotx='215.7' , svgroty='384.4' WHERE id=1141; -- Salento/Quindío
      UPDATE msip_municipio SET svgrotx='217.5' , svgroty='362.3' WHERE id=846; -- Aranzazu/Caldas
      UPDATE msip_municipio SET svgrotx='206.2' , svgroty='371.4' WHERE id=1403; -- Belalcázar/Caldas
      UPDATE msip_municipio SET svgrotx='211.2' , svgroty='371.3' WHERE id=259; -- Chinchiná/Caldas
      UPDATE msip_municipio SET svgrotx='242.6' , svgroty='353.4' WHERE id=645; -- La Dorada/Caldas
      UPDATE msip_municipio SET svgrotx='221.4' , svgroty='502.1' WHERE id=776; -- Milán/Caquetá
      UPDATE msip_municipio SET svgrotx='323.7' , svgroty='331.2' WHERE id=173; -- La Salina/Casanare
      UPDATE msip_municipio SET svgrotx='162.9' , svgroty='483.6' WHERE id=496; -- Florencia/Cauca
      UPDATE msip_municipio SET svgrotx='224.5' , svgroty='364' WHERE id=764; -- Marulanda/Caldas
      UPDATE msip_municipio SET svgrotx='188.5' , svgroty='432.6' WHERE id=868; -- Padilla/Cauca
      UPDATE msip_municipio SET svgrotx='277.9' , svgroty='257.9' WHERE id=501; -- Gamarra/Cesar
      UPDATE msip_municipio SET svgrotx='207' , svgroty='326.2' WHERE id=416; -- Ebéjico/Antioquia
      UPDATE msip_municipio SET svgrotx='214.6' , svgroty='316.7' WHERE id=462; -- Entrerríos/Antioquia
      UPDATE msip_municipio SET svgrotx='239.2' , svgroty='356.7' WHERE id=1384; -- Victoria/Caldas
      UPDATE msip_municipio SET svgrotx='285.6' , svgroty='274.7' WHERE id=1181; -- San Alberto/Cesar
      UPDATE msip_municipio SET svgrotx='166.8' , svgroty='397' WHERE id=439; -- El Litoral del San Juan/Chocó
      UPDATE msip_municipio SET svgrotx='172.1' , svgroty='352.6' WHERE id=1012; -- Río Quito/Chocó
      UPDATE msip_municipio SET svgrotx='191' , svgroty='372.2' WHERE id=1075; -- San José del Palmar/Chocó
      UPDATE msip_municipio SET svgrotx='186.8' , svgroty='362.7' WHERE id=1266; -- Tadó/Chocó
      UPDATE msip_municipio SET svgrotx='221.6' , svgroty='234' WHERE id=278; -- Chinú/Córdoba
      UPDATE msip_municipio SET svgrotx='212.2' , svgroty='226.3' WHERE id=781; -- Momil/Córdoba
      UPDATE msip_municipio SET svgrotx='245' , svgroty='392.5' WHERE id=6; -- Agua de Dios/Cundinamarca
      UPDATE msip_municipio SET svgrotx='210.4' , svgroty='493.7' WHERE id=798; -- Morelia/Caquetá
      UPDATE msip_municipio SET svgrotx='338.4' , svgroty='349.5' WHERE id=460; -- Pore/Casanare
      UPDATE msip_municipio SET svgrotx='309.2' , svgroty='361.9' WHERE id=483; -- Recetor/Casanare
      UPDATE msip_municipio SET svgrotx='302' , svgroty='377.6' WHERE id=542; -- Sabanalarga/Casanare
      UPDATE msip_municipio SET svgrotx='174.1' , svgroty='471.4' WHERE id=661; -- La Vega/Cauca
      UPDATE msip_municipio SET svgrotx='193.1' , svgroty='431.2' WHERE id=773; -- Miranda/Cauca
      UPDATE msip_municipio SET svgrotx='174' , svgroty='445.6' WHERE id=792; -- Morales/Cauca
      UPDATE msip_municipio SET svgrotx='157.3' , svgroty='439.6' WHERE id=723; -- López de Micay/Cauca
      UPDATE msip_municipio SET svgrotx='159.2' , svgroty='480.5' WHERE id=770; -- Mercaderes/Cauca
      UPDATE msip_municipio SET svgrotx='252.1' , svgroty='378.3' WHERE id=689; -- Anolaima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='249.9' , svgroty='376.2' WHERE id=1458; -- Bituima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='284.5' , svgroty='326.8' WHERE id=357; -- Contratación/Santander
      UPDATE msip_municipio SET svgrotx='302' , svgroty='329.3' WHERE id=367; -- Coromoro/Santander
      UPDATE msip_municipio SET svgrotx='252.2' , svgroty='380.3' WHERE id=135; -- Cachipay/Cundinamarca
      UPDATE msip_municipio SET svgrotx='270.3' , svgroty='333.9' WHERE id=441; -- El Peñón/Santander
      UPDATE msip_municipio SET svgrotx='299.6' , svgroty='334.5' WHERE id=461; -- Encino/Santander
      UPDATE msip_municipio SET svgrotx='179.5' , svgroty='457.6' WHERE id=46; -- Popayán/Cauca
      UPDATE msip_municipio SET svgrotx='269.9' , svgroty='391.6' WHERE id=217; -- Cáqueza/Cundinamarca
      UPDATE msip_municipio SET svgrotx='269.3' , svgroty='394.6' WHERE id=485; -- Fosca/Cundinamarca
      UPDATE msip_municipio SET svgrotx='275.5' , svgroty='357.2' WHERE id=493; -- Fúquene/Cundinamarca
      UPDATE msip_municipio SET svgrotx='178.3' , svgroty='376' WHERE id=816; -- Nóvita/Chocó
      UPDATE msip_municipio SET svgrotx='180.2' , svgroty='383.9' WHERE id=1207; -- Sipí/Chocó
      UPDATE msip_municipio SET svgrotx='162.1' , svgroty='265.1' WHERE id=1307; -- Unguía/Chocó
      UPDATE msip_municipio SET svgrotx='191.8' , svgroty='244.8' WHERE id=1451; -- Canalete/Córdoba
      UPDATE msip_municipio SET svgrotx='212.2' , svgroty='231.8' WHERE id=244; -- Chimá/Córdoba
      UPDATE msip_municipio SET svgrotx='212.5' , svgroty='241.2' WHERE id=284; -- Ciénaga de Oro/Córdoba
      UPDATE msip_municipio SET svgrotx='207.4' , svgroty='233.3' WHERE id=538; -- Cotorra/Córdoba
      UPDATE msip_municipio SET svgrotx='203.1' , svgroty='230' WHERE id=718; -- Lorica/Córdoba
      UPDATE msip_municipio SET svgrotx='252.4' , svgroty='374.7' WHERE id=288; -- Albán/Cundinamarca
      UPDATE msip_municipio SET svgrotx='272.1' , svgroty='370.9' WHERE id=500; -- Gachancipá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='297.7' , svgroty='325.1' WHERE id=822; -- Ocamonte/Santander
      UPDATE msip_municipio SET svgrotx='291.8' , svgroty='329.7' WHERE id=850; -- Oiba/Santander
      UPDATE msip_municipio SET svgrotx='307.5' , svgroty='325.4' WHERE id=853; -- Onzaga/Santander
      UPDATE msip_municipio SET svgrotx='281.4' , svgroty='380.6' WHERE id=508; -- Gama/Cundinamarca
      UPDATE msip_municipio SET svgrotx='251.5' , svgroty='375.2' WHERE id=588; -- Guayabal de Síquima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='203.2' , svgroty='235.2' WHERE id=1132; -- San Pelayo/Córdoba
      UPDATE msip_municipio SET svgrotx='196.5' , svgroty='274.9' WHERE id=1313; -- Tierralta/Córdoba
      UPDATE msip_municipio SET svgrotx='215.3' , svgroty='227.5' WHERE id=1326; -- Tuchín/Córdoba
      UPDATE msip_municipio SET svgrotx='229' , svgroty='243.1' WHERE id=137; -- Caimito/Sucre
      UPDATE msip_municipio SET svgrotx='222.7' , svgroty='215.5' WHERE id=396; -- Chalán/Sucre
      UPDATE msip_municipio SET svgrotx='224' , svgroty='241.4' WHERE id=693; -- La Unión/Sucre
      UPDATE msip_municipio SET svgrotx='267' , svgroty='373.5' WHERE id=142; -- Cajicá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='240.7' , svgroty='391.4' WHERE id=803; -- Nariño/Cundinamarca
      UPDATE msip_municipio SET svgrotx='270.1' , svgroty='359.6' WHERE id=221; -- Carmen de Carupa/Cundinamarca
      UPDATE msip_municipio SET svgrotx='270.6' , svgroty='385.3' WHERE id=277; -- Choachí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='275.4' , svgroty='363.4' WHERE id=385; -- Cucunubá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='272.8' , svgroty='393.7' WHERE id=979; -- Quetame/Cundinamarca
      UPDATE msip_municipio SET svgrotx='256.2' , svgroty='384.8' WHERE id=1050; -- San Antonio del Tequendama/Cundinamarca
      UPDATE msip_municipio SET svgrotx='253.2' , svgroty='386.5' WHERE id=425; -- El Colegio/Cundinamarca
      UPDATE msip_municipio SET svgrotx='259.8' , svgroty='375.3' WHERE id=456; -- El Rosal/Cundinamarca
      UPDATE msip_municipio SET svgrotx='256.3' , svgroty='376.7' WHERE id=469; -- Facatativá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='274.6' , svgroty='386.9' WHERE id=482; -- Fómeque/Cundinamarca
      UPDATE msip_municipio SET svgrotx='273' , svgroty='353.7' WHERE id=1206; -- Simijaca/Cundinamarca
      UPDATE msip_municipio SET svgrotx='273.8' , svgroty='356' WHERE id=1254; -- Susa/Cundinamarca
      UPDATE msip_municipio SET svgrotx='272.8' , svgroty='363' WHERE id=1261; -- Sutatausa/Cundinamarca
      UPDATE msip_municipio SET svgrotx='264.9' , svgroty='372.9' WHERE id=1264; -- Tabio/Cundinamarca
      UPDATE msip_municipio SET svgrotx='308' , svgroty='271.9' WHERE id=554; -- Gramalote/Norte de Santander
      UPDATE msip_municipio SET svgrotx='319.1' , svgroty='286.4' WHERE id=598; -- Herrán/Norte de Santander
      UPDATE msip_municipio SET svgrotx='295.4' , svgroty='259.9' WHERE id=663; -- La Playa/Norte de Santander
      UPDATE msip_municipio SET svgrotx='317.8' , svgroty='277.7' WHERE id=705; -- Los Patios/Norte de Santander
      UPDATE msip_municipio SET svgrotx='240.3' , svgroty='393.8' WHERE id=547; -- Girardot/Cundinamarca
      UPDATE msip_municipio SET svgrotx='277.3' , svgroty='339' WHERE id=582; -- Guavatá/Santander
      UPDATE msip_municipio SET svgrotx='282.1' , svgroty='336.2' WHERE id=587; -- Güepsa/Santander
      UPDATE msip_municipio SET svgrotx='274.9' , svgroty='374.3' WHERE id=586; -- Guatavita/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254.4' , svgroty='383.3' WHERE id=1280; -- Tena/Cundinamarca
      UPDATE msip_municipio SET svgrotx='289.4' , svgroty='318.3' WHERE id=596; -- Hato/Santander
      UPDATE msip_municipio SET svgrotx='273.1' , svgroty='342.1' WHERE id=628; -- Jesús María/Santander
      UPDATE msip_municipio SET svgrotx='251.3' , svgroty='394.2' WHERE id=1310; -- Tibacuy/Cundinamarca
      UPDATE msip_municipio SET svgrotx='273.1' , svgroty='397.4' WHERE id=591; -- Guayabetal/Cundinamarca
      UPDATE msip_municipio SET svgrotx='269.8' , svgroty='381.7' WHERE id=636; -- La Calera/Cundinamarca
      UPDATE msip_municipio SET svgrotx='287.9' , svgroty='388.6' WHERE id=751; -- Medina/Cundinamarca
      UPDATE msip_municipio SET svgrotx='284.6' , svgroty='368.2' WHERE id=1312; -- Tibirita/Cundinamarca
      UPDATE msip_municipio SET svgrotx='268.7' , svgroty='388.2' WHERE id=1354; -- Ubaque/Cundinamarca
      UPDATE msip_municipio SET svgrotx='249.2' , svgroty='375.2' WHERE id=1383; -- Vianí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='272.3' , svgroty='303.6' WHERE id=1319; -- Barrancabermeja/Santander
      UPDATE msip_municipio SET svgrotx='261.3' , svgroty='362' WHERE id=1389; -- Villagómez/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254.3' , svgroty='379.7' WHERE id=1429; -- Zipacón/Cundinamarca
      UPDATE msip_municipio SET svgrotx='218.4' , svgroty='454.6' WHERE id=600; -- Hobo/Huila
      UPDATE msip_municipio SET svgrotx='205.2' , svgroty='294.2' WHERE id=619; -- Ituango/Antioquia
      UPDATE msip_municipio SET svgrotx='198.2' , svgroty='470.5' WHERE id=854; -- Oporapa/Huila
      UPDATE msip_municipio SET svgrotx='262.4' , svgroty='372.3' WHERE id=1236; -- Subachoque/Cundinamarca
      UPDATE msip_municipio SET svgrotx='241.4' , svgroty='193.3' WHERE id=339; -- Concordia/Magdalena
      UPDATE msip_municipio SET svgrotx='243.1' , svgroty='183.5' WHERE id=1105; -- Salamina/Magdalena
      UPDATE msip_municipio SET svgrotx='258' , svgroty='216.7' WHERE id=1179; -- Santa Ana/Magdalena
      UPDATE msip_municipio SET svgrotx='277.6' , svgroty='392.9' WHERE id=422; -- El Calvario/Meta
      UPDATE msip_municipio SET svgrotx='132.9' , svgroty='509.3' WHERE id=390; -- Cumbal/Nariño
      UPDATE msip_municipio SET svgrotx='279.3' , svgroty='389.3' WHERE id=1130; -- San Juanito/Meta
      UPDATE msip_municipio SET svgrotx='304.2' , svgroty='311.4' WHERE id=233; -- Cepitá/Santander
      UPDATE msip_municipio SET svgrotx='313.5' , svgroty='306.8' WHERE id=239; -- Cerrito/Santander
      UPDATE msip_municipio SET svgrotx='296.7' , svgroty='330' WHERE id=241; -- Charalá/Santander
      UPDATE msip_municipio SET svgrotx='164.4' , svgroty='487' WHERE id=1341; -- Belén/Nariño
      UPDATE msip_municipio SET svgrotx='151.1' , svgroty='500.1' WHERE id=346; -- Consacá/Nariño
      UPDATE msip_municipio SET svgrotx='269.2' , svgroty='364.3' WHERE id=1278; -- Tausa/Cundinamarca
      UPDATE msip_municipio SET svgrotx='194.9' , svgroty='483.9' WHERE id=894; -- Palestina/Huila
      UPDATE msip_municipio SET svgrotx='140.9' , svgroty='511.5' WHERE id=383; -- Cuaspud Carlosama/Nariño
      UPDATE msip_municipio SET svgrotx='117.9' , svgroty='458.2' WHERE id=795; -- Mosquera/Nariño
      UPDATE msip_municipio SET svgrotx='255.2' , svgroty='224' WHERE id=1177; -- San Zenón/Magdalena
      UPDATE msip_municipio SET svgrotx='146.1' , svgroty='509.6' WHERE id=580; -- Gualmatán/Nariño
      UPDATE msip_municipio SET svgrotx='264.5' , svgroty='418.8' WHERE id=696; -- Lejanías/Meta
      UPDATE msip_municipio SET svgrotx='148.6' , svgroty='504.7' WHERE id=609; -- Imués/Nariño
      UPDATE msip_municipio SET svgrotx='148.2' , svgroty='493.7' WHERE id=715; -- Linares/Nariño
      UPDATE msip_municipio SET svgrotx='130.7' , svgroty='476.1' WHERE id=735; -- Magüí/Nariño
      UPDATE msip_municipio SET svgrotx='154.1' , svgroty='496.9' WHERE id=802; -- Nariño/Nariño
      UPDATE msip_municipio SET svgrotx='147.2' , svgroty='506.2' WHERE id=856; -- Ospina/Nariño
      UPDATE msip_municipio SET svgrotx='283.3' , svgroty='328.6' WHERE id=426; -- El Guacamayo/Santander
      UPDATE msip_municipio SET svgrotx='243.1' , svgroty='318.8' WHERE id=732; -- Maceo/Antioquia
      UPDATE msip_municipio SET svgrotx='227.2' , svgroty='351.8' WHERE id=804; -- Nariño/Antioquia
      UPDATE msip_municipio SET svgrotx='240.3' , svgroty='269.9' WHERE id=818; -- Nechí/Antioquia
      UPDATE msip_municipio SET svgrotx='177.4' , svgroty='253.5' WHERE id=811; -- Necoclí/Antioquia
      UPDATE msip_municipio SET svgrotx='145.8' , svgroty='499.3' WHERE id=939; -- Providencia/Nariño
      UPDATE msip_municipio SET svgrotx='295.8' , svgroty='268.7' WHERE id=533; -- Ábrego/Norte de Santander
      UPDATE msip_municipio SET svgrotx='226.1' , svgroty='328.6' WHERE id=910; -- Peñol/Antioquia
      UPDATE msip_municipio SET svgrotx='165.3' , svgroty='489.3' WHERE id=1128; -- San Bernardo/Nariño
      UPDATE msip_municipio SET svgrotx='282.2' , svgroty='363.3' WHERE id=1395; -- Villapinzón/Cundinamarca
      UPDATE msip_municipio SET svgrotx='158.1' , svgroty='488.4' WHERE id=1136; -- San Lorenzo/Nariño
      UPDATE msip_municipio SET svgrotx='166.5' , svgroty='484.2' WHERE id=1145; -- San Pablo/Nariño
      UPDATE msip_municipio SET svgrotx='154.9' , svgroty='487' WHERE id=1265; -- Taminango/Nariño
      UPDATE msip_municipio SET svgrotx='249.7' , svgroty='321.4' WHERE id=961; -- Puerto Berrío/Antioquia
      UPDATE msip_municipio SET svgrotx='151.7' , svgroty='502.7' WHERE id=1411; -- Yacuanquer/Nariño
      UPDATE msip_municipio SET svgrotx='306.8' , svgroty='270.4' WHERE id=722; -- Lourdes/Norte de Santander
      UPDATE msip_municipio SET svgrotx='206.7' , svgroty='306.7' WHERE id=1043; -- Sabanalarga/Antioquia
      UPDATE msip_municipio SET svgrotx='211.8' , svgroty='391.7' WHERE id=362; -- Córdoba/Quindío
      UPDATE msip_municipio SET svgrotx='201.7' , svgroty='366.4' WHERE id=767; -- Apía/Risaralda
      UPDATE msip_municipio SET svgrotx='181.6' , svgroty='245' WHERE id=1069; -- San Juan de Urabá/Antioquia
      UPDATE msip_municipio SET svgrotx='222.6' , svgroty='326.5' WHERE id=1104; -- San Vicente Ferrer/Antioquia
      UPDATE msip_municipio SET svgrotx='218' , svgroty='313.1' WHERE id=1134; -- Santa Rosa de Osos/Antioquia
      UPDATE msip_municipio SET svgrotx='230.6' , svgroty='345.5' WHERE id=1221; -- Sonsón/Antioquia
      UPDATE msip_municipio SET svgrotx='209.5' , svgroty='348.2' WHERE id=1269; -- Támesis/Antioquia
      UPDATE msip_municipio SET svgrotx='204.7' , svgroty='364.6' WHERE id=1405; -- Belén de Umbría/Risaralda
      UPDATE msip_municipio SET svgrotx='206.5' , svgroty='360.2' WHERE id=568; -- Guática/Risaralda
      UPDATE msip_municipio SET svgrotx='204.9' , svgroty='374.4' WHERE id=695; -- La Virginia/Risaralda
      UPDATE msip_municipio SET svgrotx='278.2' , svgroty='343.5' WHERE id=948; -- Puente Nacional/Santander
      UPDATE msip_municipio SET svgrotx='274.5' , svgroty='284.3' WHERE id=958; -- Puerto Wilches/Santander
      UPDATE msip_municipio SET svgrotx='287.3' , svgroty='285.7' WHERE id=1027; -- Rionegro/Santander
      UPDATE msip_municipio SET svgrotx='307.9' , svgroty='310' WHERE id=1090; -- San Andrés/Santander
      UPDATE msip_municipio SET svgrotx='162.4' , svgroty='488.9' WHERE id=1148; -- San Pedro de Cartago/Nariño
      UPDATE msip_municipio SET svgrotx='197.7' , svgroty='360.9' WHERE id=947; -- Pueblo Rico/Risaralda
      UPDATE msip_municipio SET svgrotx='241.9' , svgroty='309.1' WHERE id=1371; -- Vegachí/Antioquia
      UPDATE msip_municipio SET svgrotx='342.7' , svgroty='314' WHERE id=539; -- Fortul/Arauca
      UPDATE msip_municipio SET svgrotx='315' , svgroty='274.4' WHERE id=1101; -- San Cayetano/Norte de Santander
      UPDATE msip_municipio SET svgrotx='282.8' , svgroty='307.9' WHERE id=1140; -- San Vicente de Chucurí/Santander
      UPDATE msip_municipio SET svgrotx='209.7' , svgroty='360.2' WHERE id=981; -- Quinchía/Risaralda
      UPDATE msip_municipio SET svgrotx='237.6' , svgroty='170.7' WHERE id=502; -- Galapa/Atlántico
      UPDATE msip_municipio SET svgrotx='283.7' , svgroty='330.9' WHERE id=147; -- Aguada/Santander
      UPDATE msip_municipio SET svgrotx='280.7' , svgroty='338.7' WHERE id=1238; -- Barbosa/Santander
      UPDATE msip_municipio SET svgrotx='262.2' , svgroty='332.4' WHERE id=80; -- Bolívar/Santander
      UPDATE msip_municipio SET svgrotx='294.5' , svgroty='315.2' WHERE id=1272; -- Barichara/Santander
      UPDATE msip_municipio SET svgrotx='293.4' , svgroty='318' WHERE id=133; -- Cabrera/Santander
      UPDATE msip_municipio SET svgrotx='301.3' , svgroty='304.4' WHERE id=914; -- Piedecuesta/Santander
      UPDATE msip_municipio SET svgrotx='201.1' , svgroty='357.4' WHERE id=774; -- Mistrató/Risaralda
      UPDATE msip_municipio SET svgrotx='210.5' , svgroty='379' WHERE id=45; -- Pereira/Risaralda
      UPDATE msip_municipio SET svgrotx='301.9' , svgroty='287.6' WHERE id=1258; -- Suratá/Santander
      UPDATE msip_municipio SET svgrotx='303.9' , svgroty='298' WHERE id=1332; -- Tona/Santander
      UPDATE msip_municipio SET svgrotx='304.3' , svgroty='291' WHERE id=168; -- California/Santander
      UPDATE msip_municipio SET svgrotx='312.7' , svgroty='319.5' WHERE id=195; -- Capitanejo/Santander
      UPDATE msip_municipio SET svgrotx='256.9' , svgroty='252.1' WHERE id=1322; -- Tiquisio/Bolívar
      UPDATE msip_municipio SET svgrotx='218.8' , svgroty='193.2' WHERE id=1350; -- Turbaná/Bolívar
      UPDATE msip_municipio SET svgrotx='225' , svgroty='185.8' WHERE id=1394; -- Villanueva/Bolívar
      UPDATE msip_municipio SET svgrotx='228.1' , svgroty='414.5' WHERE id=368; -- Coyaima/Tolima
      UPDATE msip_municipio SET svgrotx='242.7' , svgroty='417.8' WHERE id=407; -- Dolores/Tolima
      UPDATE msip_municipio SET svgrotx='237' , svgroty='399' WHERE id=468; -- Espinal/Tolima
      UPDATE msip_municipio SET svgrotx='235.4' , svgroty='368.5' WHERE id=472; -- Falan/Tolima
      UPDATE msip_municipio SET svgrotx='207' , svgroty='381.8' WHERE id=325; -- Alcalá/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='293.6' , svgroty='324.9' WHERE id=348; -- Confines/Santander
      UPDATE msip_municipio SET svgrotx='301.4' , svgroty='315.7' WHERE id=392; -- Curití/Santander
      UPDATE msip_municipio SET svgrotx='312.5' , svgroty='315' WHERE id=464; -- Enciso/Santander
      UPDATE msip_municipio SET svgrotx='298.6' , svgroty='312.9' WHERE id=629; -- Jordán/Santander
      UPDATE msip_municipio SET svgrotx='272' , svgroty='367.9' WHERE id=808; -- Nemocón/Cundinamarca
      UPDATE msip_municipio SET svgrotx='254.6' , svgroty='369' WHERE id=815; -- Nocaima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='262.5' , svgroty='365.3' WHERE id=867; -- Pacho/Cundinamarca
      UPDATE msip_municipio SET svgrotx='262.3' , svgroty='357.7' WHERE id=875; -- Paime/Cundinamarca
      UPDATE msip_municipio SET svgrotx='251.8' , svgroty='399.3' WHERE id=891; -- Pandi/Cundinamarca
      UPDATE msip_municipio SET svgrotx='294' , svgroty='389.7' WHERE id=895; -- Paratebueno/Cundinamarca
      UPDATE msip_municipio SET svgrotx='258.5' , svgroty='395.2' WHERE id=902; -- Pasca/Cundinamarca
      UPDATE msip_municipio SET svgrotx='315.7' , svgroty='320.1' WHERE id=731; -- Macaravita/Santander
      UPDATE msip_municipio SET svgrotx='310.7' , svgroty='312.5' WHERE id=744; -- Málaga/Santander
      UPDATE msip_municipio SET svgrotx='292.3' , svgroty='323.9' WHERE id=890; -- Palmas del Socorro/Santander
      UPDATE msip_municipio SET svgrotx='274.2' , svgroty='349.8' WHERE id=264; -- Chiquinquirá/Boyacá
      UPDATE msip_municipio SET svgrotx='320.7' , svgroty='335.1' WHERE id=279; -- Chita/Boyacá
      UPDATE msip_municipio SET svgrotx='295.2' , svgroty='285.6' WHERE id=446; -- El Playón/Santander
      UPDATE msip_municipio SET svgrotx='295.9' , svgroty='319.7' WHERE id=919; -- Pinchote/Santander
      UPDATE msip_municipio SET svgrotx='321.1' , svgroty='314.6' WHERE id=276; -- Chiscas/Boyacá
      UPDATE msip_municipio SET svgrotx='287.3' , svgroty='337.8' WHERE id=281; -- Chitaraque/Boyacá
      UPDATE msip_municipio SET svgrotx='310.6' , svgroty='315.9' WHERE id=1127; -- San José de Miranda/Santander
      UPDATE msip_municipio SET svgrotx='313.8' , svgroty='317.9' WHERE id=1131; -- San Miguel/Santander
      UPDATE msip_municipio SET svgrotx='293.5' , svgroty='321.7' WHERE id=1218; -- Socorro/Santander
      UPDATE msip_municipio SET svgrotx='307.7' , svgroty='315.2' WHERE id=786; -- Molagavita/Santander
      UPDATE msip_municipio SET svgrotx='298.1' , svgroty='322.6' WHERE id=1369; -- Valle de San José/Santander
      UPDATE msip_municipio SET svgrotx='298.9' , svgroty='340.3' WHERE id=409; -- Duitama/Boyacá
      UPDATE msip_municipio SET svgrotx='301' , svgroty='348.4' WHERE id=476; -- Firavitoba/Boyacá
      UPDATE msip_municipio SET svgrotx='283.4' , svgroty='345.8' WHERE id=499; -- Gachantivá/Boyacá
      UPDATE msip_municipio SET svgrotx='305.8' , svgroty='292.1' WHERE id=1382; -- Vetas/Santander
      UPDATE msip_municipio SET svgrotx='226.1' , svgroty='220.3' WHERE id=720; -- Los Palmitos/Sucre
      UPDATE msip_municipio SET svgrotx='214.3' , svgroty='223.3' WHERE id=886; -- Palmito/Sucre
      UPDATE msip_municipio SET svgrotx='239.1' , svgroty='396.9' WHERE id=477; -- Flandes/Tolima
      UPDATE msip_municipio SET svgrotx='289.1' , svgroty='358.2' WHERE id=624; -- Jenesano/Boyacá
      UPDATE msip_municipio SET svgrotx='315.9' , svgroty='332.6' WHERE id=625; -- Jericó/Boyacá
      UPDATE msip_municipio SET svgrotx='233.4' , svgroty='368' WHERE id=882; -- Palocabildo/Tolima
      UPDATE msip_municipio SET svgrotx='195' , svgroty='380.9' WHERE id=905; -- Argelia/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='314.8' , svgroty='352.4' WHERE id=639; -- Labranzagrande/Boyacá
      UPDATE msip_municipio SET svgrotx='262.6' , svgroty='377' WHERE id=1286; -- Tenjo/Cundinamarca
      UPDATE msip_municipio SET svgrotx='296.7' , svgroty='343' WHERE id=871; -- Paipa/Boyacá
      UPDATE msip_municipio SET svgrotx='312.1' , svgroty='358.1' WHERE id=876; -- Pajarito/Boyacá
      UPDATE msip_municipio SET svgrotx='182.4' , svgroty='419' WHERE id=1422; -- Yumbo/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='359.7' , svgroty='505.5' WHERE id=235; -- Carurú/Vaupés
      UPDATE msip_municipio SET svgrotx='384.7' , svgroty='486.1' WHERE id=1250; -- Papunahua/Vaupés
      UPDATE msip_municipio SET svgrotx='415.3' , svgroty='513.2' WHERE id=1418; -- Yavaraté/Vaupés
      UPDATE msip_municipio SET svgrotx='414.9' , svgroty='356.7' WHERE id=887; -- La Primavera/Vichada
      UPDATE msip_municipio SET svgrotx='464.6' , svgroty='346.7' WHERE id=47; -- Puerto Carreño/Vichada
      UPDATE msip_municipio SET svgrotx='381.1' , svgroty='372' WHERE id=1042; -- Santa Rosalía/Vichada
      UPDATE msip_municipio SET svgrotx='267.6' , svgroty='347.8' WHERE id=897; -- Pauna/Boyacá
      UPDATE msip_municipio SET svgrotx='309.6' , svgroty='336.3' WHERE id=904; -- Paz de Río/Boyacá
      UPDATE msip_municipio SET svgrotx='320.3' , svgroty='345.8' WHERE id=925; -- Pisba/Boyacá
      UPDATE msip_municipio SET svgrotx='275.7' , svgroty='347.4' WHERE id=1045; -- Saboyá/Boyacá
      UPDATE msip_municipio SET svgrotx='283.3' , svgroty='351.3' WHERE id=1048; -- Sáchica/Boyacá
      UPDATE msip_municipio SET svgrotx='283.6' , svgroty='355.5' WHERE id=1051; -- Samacá/Boyacá
      UPDATE msip_municipio SET svgrotx='297.2' , svgroty='377.6' WHERE id=1085; -- San Luis de Gaceno/Boyacá
      UPDATE msip_municipio SET svgrotx='260.9' , svgroty='323.6' WHERE id=296; -- Cimitarra/Santander
      UPDATE msip_municipio SET svgrotx='314.8' , svgroty='309.6' WHERE id=345; -- Concepción/Santander
      UPDATE msip_municipio SET svgrotx='264' , svgroty='348.2' WHERE id=1120; -- San Pablo de Borbur/Boyacá
      UPDATE msip_municipio SET svgrotx='269.4' , svgroty='343.8' WHERE id=473; -- Florián/Santander
      UPDATE msip_municipio SET svgrotx='310.8' , svgroty='332.8' WHERE id=1190; -- Sativanorte/Boyacá
      UPDATE msip_municipio SET svgrotx='311.3' , svgroty='334.6' WHERE id=1191; -- Sativasur/Boyacá
      UPDATE msip_municipio SET svgrotx='294.6' , svgroty='354.5' WHERE id=1198; -- Siachoque/Boyacá
      UPDATE msip_municipio SET svgrotx='312' , svgroty='326.4' WHERE id=1215; -- Soatá/Boyacá
      UPDATE msip_municipio SET svgrotx='293' , svgroty='343.7' WHERE id=1234; -- Sotaquirá/Boyacá
      UPDATE msip_municipio SET svgrotx='311.2' , svgroty='341.2' WHERE id=1275; -- Tasco/Boyacá
      UPDATE msip_municipio SET svgrotx='301.4' , svgroty='354.8' WHERE id=1335; -- Tota/Boyacá
      UPDATE msip_municipio SET svgrotx='288.8' , svgroty='353.6' WHERE id=54; -- Tunja/Boyacá
      UPDATE msip_municipio SET svgrotx='295.5' , svgroty='348.3' WHERE id=1349; -- Tuta/Boyacá
      UPDATE msip_municipio SET svgrotx='213.2' , svgroty='332.5' WHERE id=1044; -- Sabaneta/Antioquia
      UPDATE msip_municipio SET svgrotx='295.9' , svgroty='361.8' WHERE id=1428; -- Zetaquira/Boyacá
      UPDATE msip_municipio SET svgrotx='208.5' , svgroty='365' WHERE id=725; -- Anserma/Caldas
      UPDATE msip_municipio SET svgrotx='217.1' , svgroty='368' WHERE id=37; -- Manizales/Caldas
      UPDATE msip_municipio SET svgrotx='219.9' , svgroty='358.2' WHERE id=1060; -- Salamina/Caldas
      UPDATE msip_municipio SET svgrotx='233.7' , svgroty='352.7' WHERE id=1077; -- Samaná/Caldas
      UPDATE msip_municipio SET svgrotx='241.9' , svgroty='177.7' WHERE id=880; -- Palmar de Varela/Atlántico
      UPDATE msip_municipio SET svgrotx='204.4' , svgroty='369.7' WHERE id=1400; -- Viterbo/Caldas
      UPDATE msip_municipio SET svgrotx='204.5' , svgroty='499.4' WHERE id=494; -- Albania/Caquetá
      UPDATE msip_municipio SET svgrotx='201.8' , svgroty='504.4' WHERE id=341; -- Curillo/Caquetá
      UPDATE msip_municipio SET svgrotx='226.8' , svgroty='477.3' WHERE id=428; -- El Doncello/Caquetá
      UPDATE msip_municipio SET svgrotx='224.3' , svgroty='480.8' WHERE id=447; -- El Paujíl/Caquetá
      UPDATE msip_municipio SET svgrotx='213.8' , svgroty='481.8' WHERE id=33; -- Florencia/Caquetá
      UPDATE msip_municipio SET svgrotx='249.2' , svgroty='381.1' WHERE id=982; -- Quipile/Cundinamarca
      UPDATE msip_municipio SET svgrotx='242.7' , svgroty='394.8' WHERE id=1022; -- Ricaurte/Cundinamarca
      UPDATE msip_municipio SET svgrotx='230.7' , svgroty='206.3' WHERE id=1062; -- San Jacinto/Bolívar
      UPDATE msip_municipio SET svgrotx='295.8' , svgroty='531.7' WHERE id=1220; -- Solano/Caquetá
      UPDATE msip_municipio SET svgrotx='213.8' , svgroty='504.4' WHERE id=1374; -- Valparaíso/Caquetá
      UPDATE msip_municipio SET svgrotx='318.7' , svgroty='367.6' WHERE id=59; -- Aguazul/Casanare
      UPDATE msip_municipio SET svgrotx='306.6' , svgroty='363.9' WHERE id=202; -- Chámeza/Casanare
      UPDATE msip_municipio SET svgrotx='374' , svgroty='335.2' WHERE id=141; -- Hato Corozal/Casanare
      UPDATE msip_municipio SET svgrotx='328.8' , svgroty='335.5' WHERE id=558; -- Sácama/Casanare
      UPDATE msip_municipio SET svgrotx='350' , svgroty='364.8' WHERE id=585; -- San Luis de Palenque/Casanare
      UPDATE msip_municipio SET svgrotx='328.5' , svgroty='341.3' WHERE id=697; -- Támara/Casanare
      UPDATE msip_municipio SET svgrotx='315.4' , svgroty='380.5' WHERE id=713; -- Tauramena/Casanare
      UPDATE msip_municipio SET svgrotx='308' , svgroty='388.1' WHERE id=756; -- Villanueva/Casanare
      UPDATE msip_municipio SET svgrotx='328.2' , svgroty='362.8' WHERE id=58; -- Yopal/Casanare
      UPDATE msip_municipio SET svgrotx='171.5' , svgroty='476.2' WHERE id=372; -- Almaguer/Cauca
      UPDATE msip_municipio SET svgrotx='158.5' , svgroty='470.4' WHERE id=1211; -- Balboa/Cauca
      UPDATE msip_municipio SET svgrotx='166.3' , svgroty='477.7' WHERE id=77; -- Bolívar/Cauca
      UPDATE msip_municipio SET svgrotx='176' , svgroty='451.1' WHERE id=164; -- Cajibío/Cauca
      UPDATE msip_municipio SET svgrotx='183.4' , svgroty='444.8' WHERE id=174; -- Caldono/Cauca
      UPDATE msip_municipio SET svgrotx='193.2' , svgroty='434.3' WHERE id=360; -- Corinto/Cauca
      UPDATE msip_municipio SET svgrotx='186.5' , svgroty='434.3' WHERE id=540; -- Guachené/Cauca
      UPDATE msip_municipio SET svgrotx='194.4' , svgroty='456.2' WHERE id=610; -- Inzá/Cauca
      UPDATE msip_municipio SET svgrotx='189.4' , svgroty='444.3' WHERE id=621; -- Jambaló/Cauca
      UPDATE msip_municipio SET svgrotx='172.9' , svgroty='466.3' WHERE id=657; -- La Sierra/Cauca
      UPDATE msip_municipio SET svgrotx='184' , svgroty='463.9' WHERE id=970; -- Puracé/Cauca
      UPDATE msip_municipio SET svgrotx='174.8' , svgroty='477.9' WHERE id=1146; -- San Sebastián/Cauca
      UPDATE msip_municipio SET svgrotx='187.6' , svgroty='450.1' WHERE id=1203; -- Silvia/Cauca
      UPDATE msip_municipio SET svgrotx='178.3' , svgroty='465.1' WHERE id=1230; -- Sotará Paispamba/Cauca
      UPDATE msip_municipio SET svgrotx='240' , svgroty='402.6' WHERE id=1259; -- Suárez/Cauca
      UPDATE msip_municipio SET svgrotx='168.7' , svgroty='471.2' WHERE id=1263; -- Sucre/Cauca
      UPDATE msip_municipio SET svgrotx='149.3' , svgroty='449' WHERE id=1317; -- Timbiquí/Cauca
      UPDATE msip_municipio SET svgrotx='186.1' , svgroty='455.5' WHERE id=1339; -- Totoró/Cauca
      UPDATE msip_municipio SET svgrotx='280' , svgroty='260.3' WHERE id=88; -- Aguachica/Cesar
      UPDATE msip_municipio SET svgrotx='272' , svgroty='203' WHERE id=1011; -- Bosconia/Cesar
      UPDATE msip_municipio SET svgrotx='283.7' , svgroty='221.9' WHERE id=266; -- Chiriguaná/Cesar
      UPDATE msip_municipio SET svgrotx='271.3' , svgroty='194.2' WHERE id=410; -- El Copey/Cesar
      UPDATE msip_municipio SET svgrotx='279.5' , svgroty='211.4' WHERE id=440; -- El Paso/Cesar
      UPDATE msip_municipio SET svgrotx='181' , svgroty='357.5' WHERE id=234; -- Cértegui/Chocó
      UPDATE msip_municipio SET svgrotx='183.1' , svgroty='368.3' WHERE id=340; -- Condoto/Chocó
      UPDATE msip_municipio SET svgrotx='193.5' , svgroty='343.7' WHERE id=423; -- El Carmen de Atrato/Chocó
      UPDATE msip_municipio SET svgrotx='288.8' , svgroty='255.4' WHERE id=551; -- González/Cesar
      UPDATE msip_municipio SET svgrotx='279.9' , svgroty='247.1' WHERE id=649; -- La Gloria/Cesar
      UPDATE msip_municipio SET svgrotx='289.7' , svgroty='216.7' WHERE id=691; -- La Jagua de Ibirico/Cesar
      UPDATE msip_municipio SET svgrotx='282.6' , svgroty='236.8' WHERE id=872; -- Pailitas/Cesar
      UPDATE msip_municipio SET svgrotx='280' , svgroty='243.4' WHERE id=924; -- Pelaya/Cesar
      UPDATE msip_municipio SET svgrotx='289.4' , svgroty='197.7' WHERE id=1213; -- San Diego/Cesar
      UPDATE msip_municipio SET svgrotx='282.2' , svgroty='272.1' WHERE id=1239; -- San Martín/Cesar
      UPDATE msip_municipio SET svgrotx='284.9' , svgroty='190.5' WHERE id=55; -- Valledupar/Cesar
      UPDATE msip_municipio SET svgrotx='156.3' , svgroty='254.2' WHERE id=987; -- Acandí/Chocó
      UPDATE msip_municipio SET svgrotx='163.8' , svgroty='349.9' WHERE id=432; -- Alto Baudó/Chocó
      UPDATE msip_municipio SET svgrotx='153.6' , svgroty='324.7' WHERE id=1210; -- Bahía Solano/Chocó
      UPDATE msip_municipio SET svgrotx='157.2' , svgroty='370.3' WHERE id=1237; -- Bajo Baudó/Chocó
      UPDATE msip_municipio SET svgrotx='172.5' , svgroty='377' WHERE id=618; -- Istmina/Chocó
      UPDATE msip_municipio SET svgrotx='186' , svgroty='351.3' WHERE id=717; -- Lloró/Chocó
      UPDATE msip_municipio SET svgrotx='177.1' , svgroty='336.7' WHERE id=733; -- Medio Atrato/Chocó
      UPDATE msip_municipio SET svgrotx='166.4' , svgroty='367.7' WHERE id=742; -- Medio Baudó/Chocó
      UPDATE msip_municipio SET svgrotx='173.5' , svgroty='377.1' WHERE id=769; -- Medio San Juan/Chocó
      UPDATE msip_municipio SET svgrotx='306.2' , svgroty='342.3' WHERE id=115; -- Busbanzá/Boyacá
      UPDATE msip_municipio SET svgrotx='270.1' , svgroty='372.1' WHERE id=1328; -- Tocancipá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='207.2' , svgroty='278.7' WHERE id=963; -- Puerto Libertador/Córdoba
      UPDATE msip_municipio SET svgrotx='209.5' , svgroty='225.8' WHERE id=972; -- Purísima de La Concepción/Córdoba
      UPDATE msip_municipio SET svgrotx='218.9' , svgroty='241.8' WHERE id=1071; -- Sahagún/Córdoba
      UPDATE msip_municipio SET svgrotx='207.3' , svgroty='222.9' WHERE id=1099; -- San Antero/Córdoba
      UPDATE msip_municipio SET svgrotx='201.3' , svgroty='224.2' WHERE id=1107; -- San Bernardo del Viento/Córdoba
      UPDATE msip_municipio SET svgrotx='214' , svgroty='276.8' WHERE id=1122; -- San José de Uré/Córdoba
      UPDATE msip_municipio SET svgrotx='289.3' , svgroty='333.4' WHERE id=1240; -- Suaita/Santander
      UPDATE msip_municipio SET svgrotx='241.9' , svgroty='380.4' WHERE id=1373; -- Beltrán/Cundinamarca
      UPDATE msip_municipio SET svgrotx='256.5' , svgroty='381.7' WHERE id=1464; -- Bojacá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='252.4' , svgroty='408.6' WHERE id=131; -- Cabrera/Cundinamarca
      UPDATE msip_municipio SET svgrotx='229.7' , svgroty='232.5' WHERE id=402; -- El Roble/Sucre
      UPDATE msip_municipio SET svgrotx='234.8' , svgroty='230.9' WHERE id=405; -- Galeras/Sucre
      UPDATE msip_municipio SET svgrotx='245.1' , svgroty='256.2' WHERE id=463; -- Guaranda/Sucre
      UPDATE msip_municipio SET svgrotx='250.3' , svgroty='358.6' WHERE id=198; -- Caparrapí/Cundinamarca
      UPDATE msip_municipio SET svgrotx='246.4' , svgroty='372.5' WHERE id=242; -- Chaguaní/Cundinamarca
      UPDATE msip_municipio SET svgrotx='265.7' , svgroty='391.5' WHERE id=265; -- Chipaque/Cundinamarca
      UPDATE msip_municipio SET svgrotx='279.2' , svgroty='367.2' WHERE id=280; -- Chocontá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='269' , svgroty='367.5' WHERE id=334; -- Cogua/Cundinamarca
      UPDATE msip_municipio SET svgrotx='263.8' , svgroty='378.5' WHERE id=363; -- Cota/Cundinamarca
      UPDATE msip_municipio SET svgrotx='261.1' , svgroty='379.9' WHERE id=489; -- Funza/Cundinamarca
      UPDATE msip_municipio SET svgrotx='246.2' , svgroty='398.5' WHERE id=765; -- Melgar/Tolima
      UPDATE msip_municipio SET svgrotx='226.3' , svgroty='377.4' WHERE id=779; -- Murillo/Tolima
      UPDATE msip_municipio SET svgrotx='229.1' , svgroty='420.9' WHERE id=805; -- Natagaima/Tolima
      UPDATE msip_municipio SET svgrotx='224.2' , svgroty='407.7' WHERE id=855; -- Ortega/Tolima
      UPDATE msip_municipio SET svgrotx='236.1' , svgroty='388.6' WHERE id=915; -- Piedras/Tolima
      UPDATE msip_municipio SET svgrotx='206.3' , svgroty='435.7' WHERE id=929; -- Planadas/Tolima
      UPDATE msip_municipio SET svgrotx='286.4' , svgroty='367.3' WHERE id=644; -- La Capilla/Boyacá
      UPDATE msip_municipio SET svgrotx='280.4' , svgroty='376' WHERE id=505; -- Gachetá/Cundinamarca
      UPDATE msip_municipio SET svgrotx='251.4' , svgroty='370.5' WHERE id=1399; -- Villeta/Cundinamarca
      UPDATE msip_municipio SET svgrotx='209.5' , svgroty='458.9' WHERE id=874; -- Paicol/Huila
      UPDATE msip_municipio SET svgrotx='152.9' , svgroty='514.7' WHERE id=366; -- Córdoba/Nariño
      UPDATE msip_municipio SET svgrotx='148.1' , svgroty='507.7' WHERE id=607; -- Iles/Nariño
      UPDATE msip_municipio SET svgrotx='121.8' , svgroty='463.6' WHERE id=813; -- Olaya Herrera/Nariño
      UPDATE msip_municipio SET svgrotx='305.7' , svgroty='348.4' WHERE id=1226; -- Sogamoso/Boyacá
      UPDATE msip_municipio SET svgrotx='159.7' , svgroty='504.2' WHERE id=44; -- Pasto/Nariño
      UPDATE msip_municipio SET svgrotx='149.1' , svgroty='482.1' WHERE id=906; -- Policarpa/Nariño
      UPDATE msip_municipio SET svgrotx='150.4' , svgroty='516.8' WHERE id=935; -- Potosí/Nariño
      UPDATE msip_municipio SET svgrotx='144.4' , svgroty='510' WHERE id=969; -- Pupiales/Nariño
      UPDATE msip_municipio SET svgrotx='131.1' , svgroty='499.9' WHERE id=1023; -- Ricaurte/Nariño
      UPDATE msip_municipio SET svgrotx='119' , svgroty='477.9' WHERE id=1036; -- Roberto Payán/Nariño
      UPDATE msip_municipio SET svgrotx='110.5' , svgroty='483.4' WHERE id=1345; -- San Andrés de Tumaco/Nariño
      UPDATE msip_municipio SET svgrotx='154.1' , svgroty='504.5' WHERE id=1268; -- Tangua/Nariño
      UPDATE msip_municipio SET svgrotx='210.8' , svgroty='382.7' WHERE id=475; -- Filandia/Quindío
      UPDATE msip_municipio SET svgrotx='201.8' , svgroty='373.9' WHERE id=1212; -- Balboa/Risaralda
      UPDATE msip_municipio SET svgrotx='214.4' , svgroty='376.3' WHERE id=1123; -- Santa Rosa de Cabal/Risaralda
      UPDATE msip_municipio SET svgrotx='272.9' , svgroty='344.8' WHERE id=324; -- Albania/Santander
      UPDATE msip_municipio SET svgrotx='301' , svgroty='312.7' WHERE id=860; -- Aratoca/Santander
      UPDATE msip_municipio SET svgrotx='288.3' , svgroty='302.5' WHERE id=1454; -- Betulia/Santander
      UPDATE msip_municipio SET svgrotx='196.5' , svgroty='496.6' WHERE id=1021; -- San José del Fragua/Caquetá
      UPDATE msip_municipio SET svgrotx='316.1' , svgroty='314.8' WHERE id=219; -- Carcasí/Santander
      UPDATE msip_municipio SET svgrotx='302.1' , svgroty='294.8' WHERE id=245; -- Charta/Santander
      UPDATE msip_municipio SET svgrotx='287.7' , svgroty='324.3' WHERE id=263; -- Chima/Santander
      UPDATE msip_municipio SET svgrotx='265.9' , svgroty='340.2' WHERE id=635; -- La Belleza/Santander
      UPDATE msip_municipio SET svgrotx='280.3' , svgroty='329.6' WHERE id=660; -- La Paz/Santander
      UPDATE msip_municipio SET svgrotx='271.5' , svgroty='326.2' WHERE id=652; -- Landázuri/Santander
      UPDATE msip_municipio SET svgrotx='291.1' , svgroty='295.9' WHERE id=706; -- Lebrija/Santander
      UPDATE msip_municipio SET svgrotx='299.7' , svgroty='291.5' WHERE id=763; -- Matanza/Santander
      UPDATE msip_municipio SET svgrotx='303' , svgroty='320.4' WHERE id=780; -- Mogotes/Santander
      UPDATE msip_municipio SET svgrotx='281.5' , svgroty='289.2' WHERE id=1063; -- Sabana de Torres/Santander
      UPDATE msip_municipio SET svgrotx='283.9' , svgroty='333.6' WHERE id=1100; -- San Benito/Santander
      UPDATE msip_municipio SET svgrotx='304.5' , svgroty='304.4' WHERE id=1178; -- Santa Bárbara/Santander
      UPDATE msip_municipio SET svgrotx='281.7' , svgroty='323' WHERE id=1187; -- Santa Helena del Opón/Santander
      UPDATE msip_municipio SET svgrotx='278.1' , svgroty='314.5' WHERE id=1205; -- Simacota/Santander
      UPDATE msip_municipio SET svgrotx='277.5' , svgroty='328' WHERE id=1378; -- Vélez/Santander
      UPDATE msip_municipio SET svgrotx='296.1' , svgroty='313.9' WHERE id=1390; -- Villanueva/Santander
      UPDATE msip_municipio SET svgrotx='290.9' , svgroty='307.5' WHERE id=1425; -- Zapatoca/Santander
      UPDATE msip_municipio SET svgrotx='235.8' , svgroty='223.6' WHERE id=107; -- Buenavista/Sucre
      UPDATE msip_municipio SET svgrotx='221.5' , svgroty='216.9' WHERE id=337; -- Colosó/Sucre
      UPDATE msip_municipio SET svgrotx='225.2' , svgroty='227.9' WHERE id=364; -- Corozal/Sucre
      UPDATE msip_municipio SET svgrotx='211.8' , svgroty='221.5' WHERE id=378; -- Coveñas/Sucre
      UPDATE msip_municipio SET svgrotx='242.4' , svgroty='250' WHERE id=736; -- Majagual/Sucre
      UPDATE msip_municipio SET svgrotx='222.6' , svgroty='221.9' WHERE id=793; -- Morroa/Sucre
      UPDATE msip_municipio SET svgrotx='234.5' , svgroty='402.7' WHERE id=570; -- Guamo/Tolima
      UPDATE msip_municipio SET svgrotx='225.7' , svgroty='369.6' WHERE id=599; -- Herveo/Tolima
      UPDATE msip_municipio SET svgrotx='241.5' , svgroty='364.8' WHERE id=601; -- Honda/Tolima
      UPDATE msip_municipio SET svgrotx='223.7' , svgroty='391.6' WHERE id=34; -- Ibagué/Tolima
      UPDATE msip_municipio SET svgrotx='249.4' , svgroty='400.4' WHERE id=606; -- Icononzo/Tolima
      UPDATE msip_municipio SET svgrotx='236.2' , svgroty='375.7' WHERE id=710; -- Lérida/Tolima
      UPDATE msip_municipio SET svgrotx='232.2' , svgroty='375.3' WHERE id=716; -- Líbano/Tolima
      UPDATE msip_municipio SET svgrotx='187.4' , svgroty='392.8' WHERE id=78; -- Bolívar/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='154.4' , svgroty='417.9' WHERE id=86; -- Buenaventura/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='196.7' , svgroty='398.8' WHERE id=113; -- Bugalagrande/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='205.2' , svgroty='394.4' WHERE id=134; -- Caicedonia/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='180.1' , svgroty='425.6' WHERE id=28; -- Cali/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='178.5' , svgroty='407' WHERE id=143; -- Calima/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='186.7' , svgroty='425.9' WHERE id=166; -- Candelaria/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='202.4' , svgroty='380.9' WHERE id=197; -- Cartago/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='174.9' , svgroty='416.5' WHERE id=401; -- Dagua/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='197.7' , svgroty='373.6' WHERE id=417; -- El Águila/Valle del Cauca
      UPDATE msip_municipio SET svgrotx='224.2' , svgroty='301.4' WHERE id=170; -- Campamento/Antioquia
      UPDATE msip_municipio SET svgrotx='221.3' , svgroty='320.2' WHERE id=408; -- Donmatías/Antioquia
      UPDATE msip_municipio SET svgrotx='312.2' , svgroty='347.1' WHERE id=782; -- Mongua/Boyacá
      UPDATE msip_municipio SET svgrotx='263.6' , svgroty='353.5' WHERE id=801; -- Muzo/Boyacá
      UPDATE msip_municipio SET svgrotx='156.4' , svgroty='493.4' WHERE id=415; -- Chachagüí/Nariño
      UPDATE msip_municipio SET svgrotx='217' , svgroty='365.4' WHERE id=807; -- Neira/Caldas
      UPDATE msip_municipio SET svgrotx='217.4' , svgroty='354.6' WHERE id=869; -- Pácora/Caldas
      UPDATE msip_municipio SET svgrotx='211.6' , svgroty='369.1' WHERE id=889; -- Palestina/Caldas
      UPDATE msip_municipio SET svgrotx='227.3' , svgroty='356.9' WHERE id=909; -- Pensilvania/Caldas
      UPDATE msip_municipio SET svgrotx='208.2' , svgroty='356.1' WHERE id=1024; -- Riosucio/Caldas
      UPDATE msip_municipio SET svgrotx='260.1' , svgroty='481.6' WHERE id=1214; -- San Vicente del Caguán/Caquetá
      UPDATE msip_municipio SET svgrotx='306.7' , svgroty='377' WHERE id=240; -- Monterrey/Casanare
      UPDATE msip_municipio SET svgrotx='331.5' , svgroty='354' WHERE id=386; -- Nunchía/Casanare
      UPDATE msip_municipio SET svgrotx='350.4' , svgroty='374.3' WHERE id=397; -- Orocué/Casanare
      UPDATE msip_municipio SET svgrotx='163' , svgroty='469.2' WHERE id=898; -- Patía/Cauca
      UPDATE msip_municipio SET svgrotx='200.9' , svgroty='249.8' WHERE id=41; -- Montería/Córdoba
      UPDATE msip_municipio SET svgrotx='196.3' , svgroty='228.6' WHERE id=849; -- Moñitos/Córdoba
      UPDATE msip_municipio SET svgrotx='212.5' , svgroty='259.2' WHERE id=930; -- Planeta Rica/Córdoba
      UPDATE msip_municipio SET svgrotx='219.2' , svgroty='253.1' WHERE id=944; -- Pueblo Nuevo/Córdoba
      UPDATE msip_municipio SET svgrotx='249.8' , svgroty='386.2' WHERE id=603; -- Anapoima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='268.7' , svgroty='313.4' WHERE id=955; -- Puerto Parra/Santander
      UPDATE msip_municipio SET svgrotx='246.5' , svgroty='389.6' WHERE id=1325; -- Tocaima/Cundinamarca
      UPDATE msip_municipio SET svgrotx='190.6' , svgroty='471.9' WHERE id=613; -- Isnos/Huila
      UPDATE msip_municipio SET svgrotx='195.4' , svgroty='466' WHERE id=641; -- La Argentina/Huila
      UPDATE msip_municipio SET svgrotx='199.1' , svgroty='462.5' WHERE id=659; -- La Plata/Huila
      UPDATE msip_municipio SET svgrotx='240.5' , svgroty='195.5' WHERE id=908; -- Pedraza/Magdalena
      UPDATE msip_municipio SET svgrotx='246.3' , svgroty='208.8' WHERE id=931; -- Plato/Magdalena
      UPDATE msip_municipio SET svgrotx='271.4' , svgroty='417.7' WHERE id=444; -- El Castillo/Meta
      UPDATE msip_municipio SET svgrotx='273.5' , svgroty='415.1' WHERE id=471; -- El Dorado/Meta
      UPDATE msip_municipio SET svgrotx='281.2' , svgroty='426.7' WHERE id=490; -- Fuente de Oro/Meta
      UPDATE msip_municipio SET svgrotx='275.8' , svgroty='421.9' WHERE id=556; -- Granada/Meta
      UPDATE msip_municipio SET svgrotx='268.9' , svgroty='406.8' WHERE id=565; -- Guamal/Meta
      UPDATE msip_municipio SET svgrotx='334.9' , svgroty='437.1' WHERE id=584; -- Mapiripán/Meta
      UPDATE msip_municipio SET svgrotx='146' , svgroty='482.3' WHERE id=400; -- Cumbitara/Nariño
      UPDATE msip_municipio SET svgrotx='150.3' , svgroty='478.6' WHERE id=448; -- El Rosario/Nariño
      UPDATE msip_municipio SET svgrotx='152.4' , svgroty='492.4' WHERE id=457; -- El Tambo/Nariño
      UPDATE msip_municipio SET svgrotx='111.9' , svgroty='471.2' WHERE id=879; -- Francisco Pizarro/Nariño
      UPDATE msip_municipio SET svgrotx='150.9' , svgroty='521' WHERE id=611; -- Ipiales/Nariño
      UPDATE msip_municipio SET svgrotx='168.4' , svgroty='487.1' WHERE id=642; -- La Cruz/Nariño
      UPDATE msip_municipio SET svgrotx='142.2' , svgroty='484.4' WHERE id=719; -- Los Andes/Nariño
      UPDATE msip_municipio SET svgrotx='311.4' , svgroty='280.3' WHERE id=862; -- Arboledas/Norte de Santander
      UPDATE msip_municipio SET svgrotx='313.2' , svgroty='281.1' WHERE id=1463; -- Bochalema/Norte de Santander
      UPDATE msip_municipio SET svgrotx='303.9' , svgroty='266.2' WHERE id=85; -- Bucarasica/Norte de Santander
      UPDATE msip_municipio SET svgrotx='313.4' , svgroty='294.1' WHERE id=140; -- Cácota/Norte de Santander
      UPDATE msip_municipio SET svgrotx='315.9' , svgroty='283.5' WHERE id=258; -- Chinácota/Norte de Santander
      UPDATE msip_municipio SET svgrotx='295.1' , svgroty='241.2' WHERE id=344; -- Convención/Norte de Santander
      UPDATE msip_municipio SET svgrotx='308.4' , svgroty='286.1' WHERE id=382; -- Cucutilla/Norte de Santander
      UPDATE msip_municipio SET svgrotx='312.9' , svgroty='278' WHERE id=411; -- Durania/Norte de Santander
      UPDATE msip_municipio SET svgrotx='290.9' , svgroty='239.8' WHERE id=424; -- El Carmen/Norte de Santander
      UPDATE msip_municipio SET svgrotx='300.4' , svgroty='245.8' WHERE id=442; -- El Tarra/Norte de Santander
      UPDATE msip_municipio SET svgrotx='313.9' , svgroty='266.2' WHERE id=458; -- El Zulia/Norte de Santander
      UPDATE msip_municipio SET svgrotx='309.7' , svgroty='292.4' WHERE id=800; -- Mutiscua/Norte de Santander
      UPDATE msip_municipio SET svgrotx='288.5' , svgroty='259.8' WHERE id=823; -- Ocaña/Norte de Santander
      UPDATE msip_municipio SET svgrotx='312.5' , svgroty='290.8' WHERE id=877; -- Pamplona/Norte de Santander
      UPDATE msip_municipio SET svgrotx='321.7' , svgroty='258' WHERE id=928; -- Puerto Santander/Norte de Santander
      UPDATE msip_municipio SET svgrotx='306.3' , svgroty='277' WHERE id=1073; -- Salazar/Norte de Santander
      UPDATE msip_municipio SET svgrotx='207.8' , svgroty='398.9' WHERE id=543; -- Génova/Quindío
      UPDATE msip_municipio SET svgrotx='206.9' , svgroty='384.7' WHERE id=980; -- Quimbaya/Quindío
      UPDATE msip_municipio SET svgrotx='211.1' , svgroty='376.7' WHERE id=255; -- Dosquebradas/Risaralda
      UPDATE msip_municipio SET svgrotx='299.4' , svgroty='300.4' WHERE id=480; -- Floridablanca/Santander
      UPDATE msip_municipio SET svgrotx='290.7' , svgroty='314.6' WHERE id=503; -- Galán/Santander
      UPDATE msip_municipio SET svgrotx='290.2' , svgroty='340.1' WHERE id=507; -- Gámbita/Santander
      UPDATE msip_municipio SET svgrotx='291.5' , svgroty='300.1' WHERE id=548; -- Girón/Santander
      UPDATE msip_municipio SET svgrotx='307.2' , svgroty='305.7' WHERE id=562; -- Guaca/Santander
      UPDATE msip_municipio SET svgrotx='287.9' , svgroty='329.6' WHERE id=572; -- Guadalupe/Santander
      UPDATE msip_municipio SET svgrotx='290.6' , svgroty='326.4' WHERE id=577; -- Guapotá/Santander
      UPDATE msip_municipio SET svgrotx='291.9' , svgroty='319.3' WHERE id=884; -- Palmar/Santander
      UPDATE msip_municipio SET svgrotx='296' , svgroty='323' WHERE id=901; -- Páramo/Santander
      UPDATE msip_municipio SET svgrotx='306.6' , svgroty='321.6' WHERE id=1121; -- San Joaquín/Santander
      UPDATE msip_municipio SET svgrotx='229.6' , svgroty='400.1' WHERE id=1114; -- San Luis/Tolima
      UPDATE msip_municipio SET svgrotx='237.9' , svgroty='414.5' WHERE id=937; -- Prado/Tolima
      UPDATE msip_municipio SET svgrotx='237.5' , svgroty='410.3' WHERE id=971; -- Purificación/Tolima
      UPDATE msip_municipio SET svgrotx='204.1' , svgroty='424.4' WHERE id=1030; -- Rioblanco/Tolima
      UPDATE msip_municipio SET svgrotx='213.6' , svgroty='401.8' WHERE id=1039; -- Roncesvalles/Tolima
      UPDATE msip_municipio SET svgrotx='221.2' , svgroty='398' WHERE id=1041; -- Rovira/Tolima
      UPDATE msip_municipio SET svgrotx='233' , svgroty='408.1' WHERE id=1098; -- Saldaña/Tolima
      UPDATE msip_municipio SET svgrotx='216.7' , svgroty='405.9' WHERE id=1106; -- San Antonio/Tolima
      UPDATE msip_municipio SET svgrotx='236.8' , svgroty='363.3' WHERE id=761; -- San Sebastián de Mariquita/Tolima
      UPDATE msip_municipio SET svgrotx='227' , svgroty='380.4' WHERE id=1133; -- Santa Isabel/Tolima
      UPDATE msip_municipio SET svgrotx='240' , svgroty='402.6' WHERE id=1243; -- Suárez/Tolima
      UPDATE msip_municipio SET svgrotx='228' , svgroty='398.9' WHERE id=1366; -- Valle de San Juan/Tolima
      UPDATE msip_municipio SET svgrotx='236' , svgroty='381.3' WHERE id=1375; -- Venadillo/Tolima
      UPDATE msip_municipio SET svgrotx='247' , svgroty='410.2' WHERE id=1396; -- Villarrica/Tolima
    SQL
  end

  def down
    execute(<<-SQL)
      UPDATE msip_departamento SET svgetiqueta=NULL;
      UPDATE msip_municipio SET svgetiqueta=NULL;
    SQL
  end
end

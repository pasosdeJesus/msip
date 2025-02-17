# frozen_string_literal: true

class ArreglaNombresGeo < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      UPDATE msip_municipio SET nombre='Antonio Pinto Salinas'
        WHERE id=510;

      DELETE FROM msip_municipio WHERE id=399;  --No existe Sa en Bolívar/Ven

      UPDATE msip_centropoblado SET nombre='San Jacinto de Achi'
        WHERE id=99;
      UPDATE msip_centropoblado SET nombre='Florido Viejo'
        WHERE id=594;
      UPDATE msip_centropoblado SET nombre='Santo Domingo'
        WHERE id=923;
      UPDATE msip_centropoblado SET nombre='La Barrera'
        WHERE id=1064;
      UPDATE msip_centropoblado SET nombre='Yaguará II'
        WHERE id=1892;
      UPDATE msip_centropoblado SET nombre='Haticos II'
        WHERE id=2901;
      UPDATE msip_centropoblado SET nombre='San Lázaro'
        WHERE id=3284;
      UPDATE msip_centropoblado SET nombre='Santa Rosa'
        WHERE id=3285;
      UPDATE msip_centropoblado SET nombre='La Plazuela'
        WHERE id=3288;
      UPDATE msip_centropoblado SET nombre='Chiquinquirá'
        WHERE id=3289;
      UPDATE msip_centropoblado SET nombre='Matriz'
        WHERE id=3290;
      UPDATE msip_centropoblado SET nombre='San Jacinto'
        WHERE id=3291;
      UPDATE msip_centropoblado SET nombre='Alpujarra II'
        WHERE id=3867;
      UPDATE msip_centropoblado SET nombre='Pasipara'
        WHERE id=7933;
      UPDATE msip_centropoblado SET nombre='Soledad Curay II'
        WHERE id=8801;
      UPDATE msip_centropoblado SET nombre='Pozo Negro II'
        WHERE id=9884;
      UPDATE msip_centropoblado SET nombre='Buenavista II'
        WHERE id=9889;
      UPDATE msip_centropoblado SET nombre='Guasipati'
        WHERE id=10621;
      UPDATE msip_centropoblado SET nombre='Pueblo Nuevo II'
        WHERE id=10735;
      UPDATE msip_centropoblado SET nombre='Paradero II (Tarqui)'
        WHERE id=11271;
      UPDATE msip_centropoblado SET nombre='Quinto Chipuelo'
        WHERE id=11309;
      UPDATE msip_centropoblado SET nombre='La Estancia I y II'
        WHERE id=11352;
      UPDATE msip_centropoblado SET nombre='Cascajal II'
        WHERE id=11574;
      UPDATE msip_centropoblado SET nombre='Cascajal III'
        WHERE id=11576;
      UPDATE msip_centropoblado SET nombre='Amstercol II'
        WHERE id=11576;
      UPDATE msip_centropoblado SET nombre='Argelia II'
        WHERE id=14510;
      UPDATE msip_centropoblado SET nombre='Argelia III'
        WHERE id=14511;
      UPDATE msip_centropoblado SET nombre='Rio de Piedra II'
        WHERE id=14655;
      UPDATE msip_centropoblado SET nombre='Taladro II'
        WHERE id=14919;
      UPDATE msip_centropoblado SET nombre='Caño Blanco II'
        WHERE id=15179;
      UPDATE msip_centropoblado SET nombre='Soledad Curay II'
        WHERE id=15416;
      UPDATE msip_centropoblado SET nombre='Altamira'
        WHERE id=16045;
      UPDATE msip_centropoblado SET nombre='Altos de Santa Rosa I, II y III Etapa'
        WHERE id=16074;
      UPDATE msip_centropoblado SET nombre='Bella Mar I y II Etapa'
        WHERE id=16547;
      UPDATE msip_centropoblado SET nombre='Col. 10 de Enero II Etapa'
        WHERE id=18455;
      UPDATE msip_centropoblado SET nombre='Col. 24 de Abril II Etapa'
        WHERE id=18468;
      UPDATE msip_centropoblado SET nombre='Col. Modelo Etapa II'
        WHERE id=18759;
      UPDATE msip_centropoblado SET nombre='Col. Nueva San Jose II'
        WHERE id=18787;
      UPDATE msip_centropoblado SET nombre='Col. San Jorge II'
        WHERE id=18857;
      UPDATE msip_centropoblado SET nombre='Col. Subirana II'
        WHERE id=18889;
      UPDATE msip_centropoblado SET nombre='Col. Villa Peniel II Etapa'
        WHERE id=18922;
      UPDATE msip_centropoblado SET nombre='El Portillo II'
        WHERE id=25167;
      UPDATE msip_centropoblado SET nombre='El Rancho II'
        WHERE id=25497;
      UPDATE msip_centropoblado SET nombre='El Sipe'
        WHERE id=26108;
      UPDATE msip_centropoblado SET nombre='Honduras Aguan II'
        WHERE id=29796;
      UPDATE msip_centropoblado SET nombre='La Rampla II'
        WHERE id=33422;
      UPDATE msip_centropoblado SET nombre='Res. Bella Mar III Etapa'
        WHERE id=42106;
      UPDATE msip_centropoblado SET nombre='Villa Campesina Sector I, II y III'
        WHERE id=45153;
      UPDATE msip_centropoblado SET nombre='Kutsipruan'
        WHERE id=30192;

      UPDATE msip_vereda SET nombre='Cabildo Wasipunga'
        WHERE id=490;
      UPDATE msip_vereda SET nombre='Salsipuedes'
        WHERE id=8595;
      UPDATE msip_vereda SET nombre='Sipana'
        WHERE id=17579;
      UPDATE msip_vereda SET nombre='Sipirra'
        WHERE id=21108;
      UPDATE msip_vereda SET nombre='Salsipuedes II'
        WHERE id=25327;
      UPDATE msip_vereda SET nombre='Salsipuedes I'
        WHERE id=25329;
      UPDATE msip_vereda SET nombre='Salsipuedes'
        WHERE id=29251;
      UPDATE msip_vereda SET nombre='Salsipuedes'
        WHERE id=29912;

      UPDATE msip_vereda SET nombre=replace(nombre, 'Iii', 'III')
        WHERE nombre like '%Iii%';
      UPDATE msip_vereda SET nombre=replace(nombre, 'Ii', 'II')
        WHERE nombre like '%Ii%';


    SQL
  end

  def down
  end
end

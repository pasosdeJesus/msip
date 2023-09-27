class FamiliarInverso < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION msip_agregar_o_remplazar_familiar_inverso()
        RETURNS trigger AS $ac$
      DECLARE
        num2 INTEGER;
        rinv CHAR(2);
        rexistente CHAR(2);
      BEGIN
        ASSERT(TG_OP = 'INSERT' OR TG_OP = 'UPDATE');
        RAISE NOTICE 'Insertando o actualizando en msip_persona_trelacion';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'NEW.id = %', NEW.id;
        RAISE NOTICE 'NEW.persona1 = %', NEW.persona1;
        RAISE NOTICE 'NEW.persona2 = %', NEW.persona2;
        RAISE NOTICE 'NEW.trelacion_id = %', NEW.trelacion_id;
        RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

        SELECT COUNT(*) INTO num2 FROM msip_persona_trelacion
          WHERE persona1 = NEW.persona2 AND persona2=NEW.persona1;
        RAISE NOTICE 'num2 = %', num2;
        ASSERT(num2 < 2);
        SELECT inverso INTO rinv FROM msip_trelacion 
          WHERE id = NEW.trelacion_id;
        RAISE NOTICE 'rinv = %', rinv;
        ASSERT(rinv IS NOT NULL);
        CASE num2
          WHEN 0 THEN
            INSERT INTO msip_persona_trelacion 
            (persona1, persona2, trelacion_id, observaciones, created_at, updated_at)
            VALUES (NEW.persona2, NEW.persona1, rinv, 'Inverso agregado automaticamente', NOW(), NOW());
          ELSE -- num2 = 1
            SELECT trelacion_id INTO rexistente FROM msip_persona_trelacion
              WHERE persona1=NEW.persona2 AND persona2=NEW.persona1;
            RAISE NOTICE 'rexistente = %', rexistente;
            IF rinv <> rexistente THEN
              UPDATE msip_persona_trelacion 
                SET trelacion_id = rinv,
                 observaciones = 'Inverso cambiado automaticamente (era ' ||
                   rexistente || '). ' || COALESCE(observaciones, ''),
                 updated_at = NOW()
                WHERE persona1=NEW.persona2 AND persona2=NEW.persona1;
            END IF;
        END CASE;
        RETURN NULL;
      END ;
      $ac$ LANGUAGE plpgsql;

      CREATE OR REPLACE FUNCTION msip_eliminar_familiar_inverso()
        RETURNS trigger AS $ac$
      DECLARE
        num2 INTEGER;
      BEGIN
        ASSERT(TG_OP = 'DELETE');
        RAISE NOTICE 'Eliminando inverso de msip_persona_trelacion';
        SELECT COUNT(*) INTO num2 FROM msip_persona_trelacion
          WHERE persona1 = OLD.persona2 AND persona2=OLD.persona1;
        RAISE NOTICE 'num2 = %', num2;
        ASSERT(num2 < 2);
        IF num2 = 1 THEN
            DELETE FROM msip_persona_trelacion 
            WHERE persona1 = OLD.persona2 AND persona2 = OLD.persona1;
        END IF;
        RETURN NULL;
      END ;
      $ac$ LANGUAGE plpgsql;


      CREATE OR REPLACE TRIGGER msip_insertar_familiar
        AFTER INSERT OR UPDATE ON msip_persona_trelacion
        FOR EACH ROW EXECUTE FUNCTION msip_agregar_o_remplazar_familiar_inverso()
      ;
      
      CREATE OR REPLACE TRIGGER msip_eliminar_familiar
        AFTER DELETE ON msip_persona_trelacion
        FOR EACH ROW EXECUTE FUNCTION msip_eliminar_familiar_inverso()
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER msip_eliminar_familiar ON msip_persona_trelacion;
      DROP TRIGGER msip_insertar_familiar ON msip_persona_trelacion;
      DROP FUNCTION msip_agregar_o_remplazar_familiar_inverso;
      DROP FUNCTION msip_eliminar_familiar_inverso();
    SQL
  end
end

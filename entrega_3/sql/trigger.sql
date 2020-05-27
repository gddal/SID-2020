DELIMITER $$
USE `Main`$$

DROP TRIGGER IF EXISTS `medicoes_insert`$$

CREATE TRIGGER `medicoes_insert` AFTER INSERT ON `MedicoesSensores`
FOR EACH ROW
BEGIN
SET @valAlarme = (SELECT senAlarme FROM sensores WHERE sensores.ID = NEW.TipoSensor);
SET @valMin = (SELECT senMin FROM sensores WHERE sensores.ID = NEW.TipoSensor);
IF (NEW.TipoSensor = 'tmp' OR NEW.TipoSensor = 'hum') THEN
    IF (NEW.ValorMedicao > @valAlarme OR NEW.ValorMedicao < @valMin) THEN
        INSERT INTO alerta(
            DataHoraMedicao, 
            TipoSensor, 
            ValorMedicao,
            limite, 
            Descricao   
            )
        VALUES(
            current_date(), 
            NEW.TipoSensor, 
            NEW.ValorMedicao, 
            @valAlarme,
            'Alarme'
            );
    ELSE 
        SET @valAviso = (SELECT senAviso FROM sensores WHERE sensores.ID = NEW.TipoSensor);
		IF (NEW.ValorMedicao > @valAviso) THEN
			INSERT INTO alerta(
				DataHoraMedicao, 
				TipoSensor, 
				ValorMedicao,
				limite, 
				Descricao
				)
			VALUES(
				current_date(), 
				NEW.TipoSensor, 
				NEW.ValorMedicao, 
				@valAviso,
				'Aviso'
				);
		END IF;
	END IF;
ELSE
	IF EXISTS (SELECT * FROM rondaextra WHERE dataFim IS NULL) THEN
		IF NOT EXISTS (SELECT data FROM rondaplaneada WHERE current_date() = data AND current_time() >= Ronda_inicio AND current_time() <= fim) THEN 
			IF (NEW.ValorMedicao >= @valAlarme) THEN
				INSERT INTO alerta(
					DataHoraMedicao, 
					TipoSensor, 
					ValorMedicao,
					limite, 
					Descricao
					)
				VALUES(
					current_date(), 
					NEW.TipoSensor, 
					NEW.ValorMedicao, 
					@valAlarme,
					'Alerta'
					);
			END IF;
		END IF;
	END IF;
END IF;
END$$
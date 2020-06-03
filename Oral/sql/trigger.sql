DELIMITER $$
USE `Main`$$

DROP TRIGGER IF EXISTS `medicoes_insert`$$

CREATE TRIGGER `medicoes_insert` AFTER INSERT ON `MedicoesSensores`
FOR EACH ROW
BEGIN
SET @valAlarme = (SELECT senAlarme FROM sensores WHERE sensores.ID = NEW.TipoSensor);
SET @valMin = (SELECT senMin FROM sensores WHERE sensores.ID = NEW.TipoSensor);
SET @valAviso = (SELECT senAviso FROM sensores WHERE sensores.ID = NEW.TipoSensor);
IF (NEW.TipoSensor = 'tmp' OR NEW.TipoSensor = 'hum') THEN
    IF (NEW.ValorMedicao > @valAlarme) THEN
        INSERT INTO alerta(
            DataHoraMedicao, 
            TipoSensor, 
            ValorMedicao,
            limite, 
            Descricao   
            )
        VALUES(
            NEW.DataHoraMedicao, 
            NEW.TipoSensor, 
            NEW.ValorMedicao, 
            @valAlarme,
            'Alarme - Valor acima do permitido'
            );
    ELSEIF (NEW.ValorMedicao > @valAviso) THEN
        INSERT INTO alerta(
            DataHoraMedicao, 
            TipoSensor, 
            ValorMedicao,
            limite, 
            Descricao   
            )
        VALUES(
            NEW.DataHoraMedicao, 
            NEW.TipoSensor, 
            NEW.ValorMedicao, 
            @valAlarme,
            'Aviso - Valor perto do limite permitido'
            );
    ELSE
		IF (NEW.ValorMedicao < @valMin) THEN
			INSERT INTO alerta(
				DataHoraMedicao, 
				TipoSensor, 
				ValorMedicao,
				limite, 
				Descricao
				)
			VALUES(
				NEW.DataHoraMedicao, 
				NEW.TipoSensor, 
				NEW.ValorMedicao, 
				@valMin,
				'Alarme - Valor abaixo do permitido'
				);
		END IF;
	END IF;
ELSE
	IF NOT EXISTS (SELECT * FROM rondaextra WHERE dataFim IS NULL) AND NOT EXISTS (SELECT * FROM rondaplaneada WHERE data=current_date() AND Ronda_inicio <= current_time()  AND fim >= current_time() ) THEN 
		IF (NEW.ValorMedicao >= @valAlarme) THEN
			INSERT INTO alerta(
				DataHoraMedicao, 
				TipoSensor, 
				ValorMedicao,
				limite, 
				Descricao
				)
			VALUES(
				NEW.DataHoraMedicao, 
				NEW.TipoSensor, 
				NEW.ValorMedicao, 
				@valAlarme,
				'Alarme - Sensor activado'
				);
		END IF;
	END IF;
END IF;
END$$
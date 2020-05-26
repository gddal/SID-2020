DELIMITER $$
USE `Main`$$

DROP TRIGGER IF EXISTS `medicoes_insert`$$
CREATE TRIGGER `main`.`medicoes_insert` AFTER INSERT ON `medicoes`
FOR EACH ROW
BEGIN
SET @valAlarme = (SELECT senAlarme FROM sensores WHERE sensores.ID = NEW.TipoSensor);
IF (NEW.TipoSensor = 'tmp' OR NEW.TipoSensor = 'hum') THEN
    IF (NEW.valor > @valAlarme) THEN
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
            NEW.valor, 
            @valAlarme,
            'Alarme'
            );
    ELSE 
        SET @valAviso = (SELECT senAviso FROM sensores WHERE sensores.ID = NEW.TipoSensor);
		IF (NEW.valor > @valAviso) THEN
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
				NEW.valor, 
				@valAviso,
				'Aviso'
				);
		END IF;
	END IF;
ELSE
	IF NOT EXISTS (SELECT dataInicio FROM rondaextra WHERE current_time() >= rondaextra.dataInicio AND current_time() <= rondaextra.dataFim) THEN
		IF NOT EXISTS (SELECT inicio FROM ronda WHERE current_time() >= ronda.inicio AND current_time() <= ronda.fim) THEN 
			IF (NEW.valor >= @valAlarme) THEN
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
					NEW.valor, 
					@valAlarme,
					'Alerta'
					);
			END IF;
		END IF;
	END IF;
END IF;
END$$
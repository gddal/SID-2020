-- Insert no utilizador

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`utilizador_AFTER_INSERT` AFTER INSERT ON `utilizador`
FOR EACH ROW
BEGIN
insert into new_schema2.logutilizador
(DataOperacao, EmailUtilizador, Operacao, EmailNovo, NomeNovo, TipoNovo, MoradaNova)

Values
(getdate(), user(), 'I', NEW.EmailUtilizador, NEW.NomeUtilizador, NEW.TipoUtilizador, NEW.MoradaUtilizador);

END

-- Update no utilizador

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`utilizador_AFTER_UPDATE` AFTER UPDATE ON `utilizador` 
FOR EACH ROW
BEGIN
insert into new_schema2.logutilizador
(DataOperacao, EmailUtilizador, Operacao, EmailNovo, EmailAnterior, NomeNovo, NomeAnterior, TipoNovo, TipoAnterior, MoradaNova, MoradaAnterior)

Values
(getdate(), user(), 'U', NEW.EmailUtilizador, OLD.EmailUtilizador, NEW.NomeUtilizador, OLD.NomeUtilizador, NEW.TipoUtilizador, OLD.TipoUtilizador, NEW.MoradaUtilizador, OLD.MoradaUtilizador);

END

-- Delete no utilizador

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`utilizador_AFTER_DELETE` AFTER DELETE ON `utilizador`
FOR EACH ROW
BEGIN
insert into new_schema2.logutilizador
(DataOperacao, EmailUtilizador, Operacao, EmailAnterior, NomeAnterior, TipoAnterior, MoradaAnterior)

Values
(getdate(), user(), 'D',OLD.EmailUtilizador, OLD.NomeUtilizador,OLD.TipoUtilizador,OLD.MoradaUtilizador);

END


-- Insert no rondaplaneada

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`rondaplaneada_AFTER_INSERT` AFTER INSERT ON `rondaplaneada`
FOR EACH ROW
BEGIN
insert into new_schema2.logrondaplaneada
(DataOperacao, EmailUtilizador, Operacao, EmailNovo, DataNova, HoraNova)

Values
(getdate(), user(), 'I', NEW.EmailUtilizador, NEW.DataAno, NEW.HoraRonda);

END


-- Update no rondaplaneada

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`rondaplaneada_AFTER_UPDATE` AFTER UPDATE ON `rondaplaneada` 
FOR EACH ROW
BEGIN
insert into new_schema2.logrondaplaneada
(DataOperacao, EmailUtilizador, Operacao, EmailNovo, EmailAnterior, DataNova, DataAnterior, HoraNova, HoraAnterior)

Values
(getdate(), user(), 'U', NEW.EmailUtilizador, OLD.EmailUtilizador, NEW.DataAno, OLD.DataAno, NEW.HoraRonda, OLD.HoraRonda);

END

-- Delete no rondaplaneada

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`rondaplaneada_AFTER_DELETE` AFTER DELETE ON `rondaplaneada`
FOR EACH ROW
BEGIN
insert into new_schema2.logrondaplaneada
(DataOperacao, EmailUtilizador, Operacao, EmailAnterior, DataAnterior,  HoraAnterior)

Values
(getdate(), user(), 'D',OLD.EmailUtilizador, OLD.DataAno, OLD.HoraRonda);

END



-- Insert no rondaextra


CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`rondaextra_AFTER_INSERT` AFTER INSERT ON `rondaextra`
FOR EACH ROW
BEGIN
insert into new_schema2.logrondaextra
(DataOperacao, EmailUtilizador, Operacao, EmailNovo, HoraInicioNova, HoraFimNova, DataNova)

Values
(getdate(), user(), 'I', NEW.EmailUtilizador, NEW.HoraInicio, NEW.HoraFim, NEW.Data);

END




-- Delete no rondaextra

CREATE DEFINER=`root`@`localhost` TRIGGER `new_schema2`.`rondaextra_AFTER_DELETE` AFTER DELETE ON `rondaextra`
FOR EACH ROW
BEGIN
insert into new_schema2.logrondaextra
(DataOperacao, EmailUtilizador, Operacao, EmailAnterior, HoraInicioAnterior,  HoraFimAnterior, DataAnterior)

Values
(getdate(), user(), 'D', OLD.EmailUtilizador, OLD.HoraInicio, OLD.HoraFim, OLD.Data);

END

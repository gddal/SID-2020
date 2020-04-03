-- ------------------------------------------------
-- Triggers
-- Museu.User
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`User_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`User_insert` AFTER INSERT ON `User`
FOR EACH ROW
BEGIN
  INSERT INTO User_log (
      op,
      opUser,
      opData,
      Grupo_IDDepois,
      usernameDepois,
      emailDepois,
      nomeDepois,
      apelidoDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.Grupo_ID,
      NEW.username,
      NEW.email,
      NEW.nome,
      NEW.apelido
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`User_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`User_update` AFTER UPDATE ON `User`
FOR EACH ROW
BEGIN
  INSERT INTO User_log (
      op,
      opUser,
      opData,
      Grupo_IDAntes,
      usernameAntes,
      emailAntes,
      nomeAntes,
      apelidoAntes,
      Grupo_IDDepois,
      usernameDepois,
      emailDepois,
      nomeDepois,
      apelidoDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.Grupo_ID,
      OLD.username,
      OLD.email,
      OLD.nome,
      OLD.apelido,
      NEW.Grupo_ID,
      NEW.username,
      NEW.email,
      NEW.nome,
      NEW.apelido
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`User_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`User_delete` AFTER DELETE ON `User`
FOR EACH ROW
BEGIN
  INSERT INTO User_log (
      op,
      opUser,
      opData,
      Grupo_IDAntes,
      usernameAntes,
      emailAntes,
      nomeAntes,
      apelidoAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.Grupo_ID,
      OLD.username,
      OLD.email,
      OLD.nome,
      OLD.apelido
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.Grupo
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`Grupo_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Grupo_insert` AFTER INSERT ON `Grupo`
FOR EACH ROW
BEGIN
  INSERT INTO Grupo_log (
      op,
      opUser,
      opData,
      nomeDepois,
      descricaoDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.nome,
      NEW.descricao
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Grupo_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Grupo_update` AFTER UPDATE ON `Grupo`
FOR EACH ROW
BEGIN
  INSERT INTO Grupo_log (
      op,
      opUser,
      opData,
      nomeAntes,
      descricaoAntes,
      nomeDepois,
      descricaoDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.nome,
      OLD.descricao,
      NEW.nome,
      NEW.descricao
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Grupo_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Grupo_delete` AFTER DELETE ON `Grupo`
FOR EACH ROW
BEGIN
  INSERT INTO Grupo_log (
      op,
      opUser,
      opData,
      nomeAntes,
      descricaoAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.nome,
      OLD.descricao
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.RondaExtra
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`RondaExtra_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaExtra_insert` AFTER INSERT ON `RondaExtra`
FOR EACH ROW
BEGIN
  INSERT INTO RondaExtra_log (
      op,
      opUser,
      opData,
      User_IDDepois,
      dataInicioDepois,
      dataFimDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.User_ID,
      NEW.dataInicio,
      NEW.dataFim
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`RondaExtra_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaExtra_update` AFTER UPDATE ON `RondaExtra`
FOR EACH ROW
BEGIN
  INSERT INTO RondaExtra_log (
      op,
      opUser,
      opData,
      User_IDAntes,
      dataInicioAntes,
      dataFimAntes,
      User_IDDepois,
      dataInicioDepois,
      dataFimDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.User_ID,
      OLD.dataInicio,
      OLD.dataFim,
      NEW.User_ID,
      NEW.dataInicio,
      NEW.dataFim
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`RondaExtra_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaExtra_delete` AFTER DELETE ON `RondaExtra`
FOR EACH ROW
BEGIN
  INSERT INTO RondaExtra_log (
      op,
      opUser,
      opData,
      User_IDAntes,
      dataInicioAntes,
      dataFimAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.User_ID,
      OLD.dataInicio,
      OLD.dataFim
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.Ronda
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`Ronda_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Ronda_insert` AFTER INSERT ON `Ronda`
FOR EACH ROW
BEGIN
  INSERT INTO Ronda_log (
      op,
      opUser,
      opData,
      diaSemanaDepois,
      inicioDepois,
      duracaoDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.diaSemana,
      NEW.inicio,
      NEW.duracao
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Ronda_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Ronda_update` AFTER UPDATE ON `Ronda`
FOR EACH ROW
BEGIN
  INSERT INTO Ronda_log (
      op,
      opUser,
      opData,
      diaSemanaAntes,
      inicioAntes,
      duracaoAntes,
      diaSemanaDepois,
      inicioDepois,
      duracaoDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.diaSemana,
      OLD.inicio,
      OLD.duracao,
      NEW.diaSemana,
      NEW.inicio,
      NEW.duracao
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Ronda_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Ronda_delete` AFTER DELETE ON `Ronda`
FOR EACH ROW
BEGIN
  INSERT INTO Ronda_log (
      op,
      opUser,
      opData,
      diaSemanaAntes,
      inicioAntes,
      duracaoAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.diaSemana,
      OLD.inicio,
      OLD.duracao
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.RondaPlaneada
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`RondaPlaneada_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaPlaneada_insert` AFTER INSERT ON `RondaPlaneada`
FOR EACH ROW
BEGIN
  INSERT INTO RondaPlaneada_log (
      op,
      opUser,
      opData,
      User_IDDepois,
      Ronda_diaSemanaDepois,
      Ronda_inicioDepois,
      dataDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.User_ID,
      NEW.Ronda_diaSemana,
      NEW.Ronda_inicio,
      NEW.data
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`RondaPlaneada_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaPlaneada_update` AFTER UPDATE ON `RondaPlaneada`
FOR EACH ROW
BEGIN
  INSERT INTO RondaPlaneada_log (
      op,
      opUser,
      opData,
      User_IDAntes,
      Ronda_diaSemanaAntes,
      Ronda_inicioAntes,
      dataAntes,
      User_IDDepois,
      Ronda_diaSemanaDepois,
      Ronda_inicioDepois,
      dataDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.User_ID,
      OLD.Ronda_diaSemana,
      OLD.Ronda_inicio,
      OLD.data,
      NEW.User_ID,
      NEW.Ronda_diaSemana,
      NEW.Ronda_inicio,
      NEW.data
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`RondaPlaneada_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`RondaPlaneada_delete` AFTER DELETE ON `RondaPlaneada`
FOR EACH ROW
BEGIN
  INSERT INTO RondaPlaneada_log (
      op,
      opUser,
      opData,
      User_IDAntes,
      Ronda_diaSemanaAntes,
      Ronda_inicioAntes,
      dataAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.User_ID,
      OLD.Ronda_diaSemana,
      OLD.Ronda_inicio,
      OLD.data
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.Sensores
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`Sensores_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Sensores_insert` AFTER INSERT ON `Sensores`
FOR EACH ROW
BEGIN
  INSERT INTO Sensores_log (
      op,
      opUser,
      opData,
      senTipoDepois,
      senEstadoDepois,
      senAckDepois,
      senAvisoDepois,
      senAlarmeDepois,
      sen_leiturasDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.senTipo,
      NEW.senEstado,
      NEW.senAck,
      NEW.senAviso,
      NEW.senAlarme,
      NEW.senLeituras
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Sensores_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Sensores_update` AFTER UPDATE ON `Sensores`
FOR EACH ROW
BEGIN
  INSERT INTO Sensores_log (
      op,
      opUser,
      opData,
      senTipoAntes,
      senEstadoAntes,
      senAckAntes,
      senAvisoAntes,
      senAlarmeAntes,
      sen_leiturasAntes,
      senTipoDepois,
      senEstadoDepois,
      senAckDepois,
      senAvisoDepois,
      senAlarmeDepois,
      sen_leiturasDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.senTipo,
      OLD.senEstado,
      OLD.senAck,
      OLD.senAviso,
      OLD.senAlarme,
      OLD.senLeituras,
      NEW.senTipo,
      NEW.senEstado,
      NEW.senAck,
      NEW.senAviso,
      NEW.senAlarme,
      NEW.senLeituras
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Sensores_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Sensores_delete` AFTER DELETE ON `Sensores`
FOR EACH ROW
BEGIN
  INSERT INTO Sensores_log (
      op,
      opUser,
      opData,
      senTipoAntes,
      senEstadoAntes,
      senAckAntes,
      senAvisoAntes,
      senAlarmeAntes,
      sen_leiturasAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.senTipo,
      OLD.senEstado,
      OLD.senAck,
      OLD.senAviso,
      OLD.senAlarme,
      OLD.senLeituras
      );
END$$
DELIMITER ;

-- ------------------------------------------------
-- Triggers
-- Museu.Medicoes
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Museu`.`Medicoes_insert`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Medicoes_insert` AFTER INSERT ON `Medicoes`
FOR EACH ROW
BEGIN
  INSERT INTO Medicoes_log (
      op,
      opUser,
      opData,
      Sensor_IDDepois,
      valorDepois,
      dataHoraDepois
      )
  VALUES(
      'insert',
      current_user(),
      now(),
      NEW.Sensor_ID,
      NEW.valor,
      NEW.dataHora
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Medicoes_update`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Medicoes_update` AFTER UPDATE ON `Medicoes`
FOR EACH ROW
BEGIN
  INSERT INTO Medicoes_log (
      op,
      opUser,
      opData,
      Sensor_IDAntes,
      valorAntes,
      dataHoraAntes,
      Sensor_IDDepois,
      valorDepois,
      dataHoraDepois
      )
  VALUES(
      'update',
      current_user(),
      now(),
      OLD.Sensor_ID,
      OLD.valor,
      OLD.dataHora,
      NEW.Sensor_ID,
      NEW.valor,
      NEW.dataHora
      );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `Museu`.`Medicoes_delete`;

DELIMITER $$
USE `Museu`$$
CREATE TRIGGER `Museu`.`Medicoes_delete` AFTER DELETE ON `Medicoes`
FOR EACH ROW
BEGIN
  INSERT INTO Medicoes_log (
      op,
      opUser,
      opData,
      Sensor_IDAntes,
      valorAntes,
      dataHoraAntes
      )
  VALUES(
      'delete',
      current_user(),
      now(),
      OLD.Sensor_ID,
      OLD.valor,
      OLD.dataHora
      );
END$$
DELIMITER ;

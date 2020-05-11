-- ------------------------------------------------
-- Triggers
-- Main.User
-- ------------------------------------------------


DELIMITER $$
USE `Main`$$

DROP TRIGGER IF EXISTS `User_insert`$$
CREATE TRIGGER `User_insert` AFTER INSERT ON `User`
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


DROP TRIGGER IF EXISTS `User_update`$$
CREATE TRIGGER `User_update` AFTER UPDATE ON `User`
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


DROP TRIGGER IF EXISTS `User_delete`$$
CREATE TRIGGER `User_delete` AFTER DELETE ON `User`
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

-- ------------------------------------------------
-- Triggers
-- Main.Grupo
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Grupo_insert`$$
CREATE TRIGGER `Grupo_insert` AFTER INSERT ON `Grupo`
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


DROP TRIGGER IF EXISTS `Grupo_update`$$
CREATE TRIGGER `Grupo_update` AFTER UPDATE ON `Grupo`
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


DROP TRIGGER IF EXISTS `Grupo_delete`$$
CREATE TRIGGER `Grupo_delete` AFTER DELETE ON `Grupo`
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

-- ------------------------------------------------
-- Triggers
-- Main.RondaExtra
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `RondaExtra_insert`$$
CREATE TRIGGER `RondaExtra_insert` AFTER INSERT ON `RondaExtra`
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


DROP TRIGGER IF EXISTS `RondaExtra_update`$$
CREATE TRIGGER `RondaExtra_update` AFTER UPDATE ON `RondaExtra`
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


DROP TRIGGER IF EXISTS `RondaExtra_delete`$$
CREATE TRIGGER `RondaExtra_delete` AFTER DELETE ON `RondaExtra`
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

-- ------------------------------------------------
-- Triggers
-- Main.Ronda
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Ronda_insert`$$
CREATE TRIGGER `Ronda_insert` AFTER INSERT ON `Ronda`
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


DROP TRIGGER IF EXISTS `Ronda_update`$$
CREATE TRIGGER `Ronda_update` AFTER UPDATE ON `Ronda`
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


DROP TRIGGER IF EXISTS `Ronda_delete`$$
CREATE TRIGGER `Ronda_delete` AFTER DELETE ON `Ronda`
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

-- ------------------------------------------------
-- Triggers
-- Main.RondaPlaneada
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `RondaPlaneada_insert`$$
CREATE TRIGGER `RondaPlaneada_insert` AFTER INSERT ON `RondaPlaneada`
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


DROP TRIGGER IF EXISTS `RondaPlaneada_update`$$
CREATE TRIGGER `RondaPlaneada_update` AFTER UPDATE ON `RondaPlaneada`
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


DROP TRIGGER IF EXISTS `RondaPlaneada_delete`$$
CREATE TRIGGER `RondaPlaneada_delete` AFTER DELETE ON `RondaPlaneada`
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

-- ------------------------------------------------
-- Triggers
-- Main.Sensores
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Sensores_insert`$$
CREATE TRIGGER `Sensores_insert` AFTER INSERT ON `Sensores`
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


DROP TRIGGER IF EXISTS `Sensores_update`$$
CREATE TRIGGER `Sensores_update` AFTER UPDATE ON `Sensores`
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


DROP TRIGGER IF EXISTS `Sensores_delete`$$
CREATE TRIGGER `Sensores_delete` AFTER DELETE ON `Sensores`
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

-- ------------------------------------------------
-- Triggers
-- Main.Medicoes
-- ------------------------------------------------

DROP TRIGGER IF EXISTS `Medicoes_insert`$$
CREATE TRIGGER `Medicoes_insert` AFTER INSERT ON `Medicoes`
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


DROP TRIGGER IF EXISTS `Medicoes_update`$$
CREATE TRIGGER `Medicoes_update` AFTER UPDATE ON `Medicoes`
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


DROP TRIGGER IF EXISTS `Medicoes_delete`$$
CREATE TRIGGER `Medicoes_delete` AFTER DELETE ON `Medicoes`
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

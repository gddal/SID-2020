
DELIMITER $$
USE `Main`$$
DROP procedure IF EXISTS `select_user`$$
CREATE PROCEDURE `select_user`()
BEGIN
  INSERT INTO User_log ( op, opUser, opData ) VALUES( 'select', current_user(), now() );
  SELECT ID,Grupo_ID,username,email,nome,apelido from User;
END$$


USE `Main`$$
DROP procedure IF EXISTS `Main`.`select_user_id`$$
CREATE PROCEDURE `select_user_id`(IN in_ID   Integer)
BEGIN
  INSERT INTO User_log ( op, opUser, opData, User_Id ) VALUES( 'select', current_user(), now(), in_ID );
  SELECT ID,Grupo_ID,username,email,nome,apelido from User Where ID = in_ID;
END$$


DROP procedure IF EXISTS `inserir_user`$$
CREATE PROCEDURE `inserir_user`(
  IN in_Grupo_ID  char(20),
  IN in_username   char(20),
  IN in_email   char(50),
  IN in_nome   char(20),
  IN in_apelido   char(20),
  IN in_pwd varchar(20)
  )
BEGIN
  IF NOT EXISTS (SELECT * FROM User WHERE username = in_username) THEN
    INSERT INTO User ( Grupo_ID,username,email,nome,apelido ) VALUES( in_Grupo_ID,in_username,in_email,in_nome,in_apelido );
    SET @createUserCMD = concat('CREATE USER ''', in_username, '''@''', 'localhost', ''' IDENTIFIED BY ''', in_pwd, ''';');
    PREPARE createUserStatement FROM @createUserCMD;
    EXECUTE createUserStatement;
    DEALLOCATE PREPARE createUserStatement;   
    SET @grantUserCMD = concat('GRANT ''', in_Grupo_ID ,''' TO ''', in_username, '''@''', 'localhost', ''';');
    PREPARE grantUserStatement FROM @grantUserCMD;
    EXECUTE grantUserStatement;
    DEALLOCATE PREPARE grantUserStatement;   
  END IF;
END$$

DROP procedure IF EXISTS `apagar_user`$$
CREATE PROCEDURE `apagar_user`(
  IN in_ID  Integer
  )
BEGIN
  IF EXISTS (SELECT * FROM User WHERE ID = in_ID) THEN
    SELECT username INTO @login FROM User WHERE ID = in_ID;
    DELETE FROM User WHERE ID=in_ID;
    SET @deleteUserCMD = concat('DROP USER IF EXISTS ''', @login, '''@''', 'localhost', ''';');
    PREPARE deleteUserStatement FROM @deleteUserCMD;
    EXECUTE deleteUserStatement;
    DEALLOCATE PREPARE deleteUserStatement;   
  END IF;
END$$

DROP procedure IF EXISTS `editar_user`$$
CREATE PROCEDURE `editar_user`(
  IN in_ID  Integer,
  IN in_email   char(50),
  IN in_nome   char(20),
  IN in_apelido   char(20)
  )
BEGIN
  UPDATE User SET email=in_email,nome=in_nome,apelido=in_apelido WHERE ID=in_ID;
END$$


DROP procedure IF EXISTS `mudar_password`$$
CREATE PROCEDURE `mudar_password`(
  IN pwd varchar(255)
  )
BEGIN
  SET @passwordUserCMD = concat('SET PASSWORD FOR ''', current_user(), '''@''', 'localhost', ''' = PASSWORD(''', pwd, ''');');
  PREPARE passwordUserStatement FROM @passwordUserCMD;
  EXECUTE passwordUserStatement;
  DEALLOCATE PREPARE passwordUserStatement;   
END$$


DROP procedure IF EXISTS `ackowledge_sensor`$$
CREATE PROCEDURE `ackowledge_sensor`(
  IN in_ID  Integer
  )
BEGIN
  UPDATE Sensores SET senAck=true WHERE ID=in_ID;
END$$


DROP procedure IF EXISTS `actualizar_sensor`$$
CREATE PROCEDURE `actualizar_sensor`(
  IN in_ID  Integer,
  IN in_senAviso  Integer,
  IN in_senAlarme  Integer,
  IN in_senLeituras  Integer
  
  )
BEGIN
  UPDATE Sensores SET senAviso=in_senAviso, senAlarme=in_senAlarme, senLeituras=in_senLeituras WHERE ID=in_ID;
END$$


DROP procedure IF EXISTS `ronda_extra`$$
CREATE PROCEDURE `ronda_extra`(
  IN in_ID  Integer  
  )
BEGIN
  IF EXISTS (SELECT * FROM RondaExtra WHERE dataFim IS NULL AND User_ID = in_ID) THEN
    UPDATE RondaExtra SET dataFim = now() WHERE dataFim IS NULL AND User_ID = in_ID;
  ELSE
    INSERT INTO RondaExtra (User_ID, dataInicio) VALUES (in_ID, now());
  END IF;
END$$
  
DELIMITER ;

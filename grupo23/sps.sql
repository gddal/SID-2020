DROP procedure IF EXISTS `Museu`.`select_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `select_user`()
BEGIN
  INSERT INTO User_log ( op, opUser, opData ) VALUES( 'select', current_user(), now() );
  SELECT ID,Grupo_ID,username,email,nome,apelido from User;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`select_user_id`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `select_user_id`(IN in_ID   Integer)
BEGIN
  INSERT INTO User_log ( op, opUser, opData, User_Id ) VALUES( 'select', current_user(), now(), in_ID );
  SELECT ID,Grupo_ID,username,email,nome,apelido from User Where ID = in_ID;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`inserir_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `inserir_user`(
  IN in_Grupo_ID  char(20),
  IN in_username   char(20),
  IN in_email   char(50),
  IN in_nome   char(20),
  IN in_apelido   char(20),
  IN in_pwd varchar(20)
  )
BEGIN
  INSERT INTO User ( Grupo_ID,username,email,nome,apelido ) VALUES( in_Grupo_ID,in_username,in_email,in_nome,in_apelido );
  CALL create_user(in_username, in_pwd);
  CALL grant_user(in_username, in_Grupo_ID);
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`create_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `create_user`(IN username varchar(100), IN pwd varchar(255))
BEGIN
  SET @createUserCMD = concat('CREATE USER ''', username, '''@''', 'localhost', ''' IDENTIFIED BY ''', pwd, ''';');
  PREPARE createUserStatement FROM @createUserCMD;
  EXECUTE createUserStatement;
  DEALLOCATE PREPARE createUserStatement;   
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`grant_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `grant_user`(IN username varchar(100), IN grupo  char(20))
BEGIN
  SET @grantUserCMD = concat('GRANT ''', grupo ,''' TO ''', username, '''@''', 'localhost', ''';');
  PREPARE grantUserStatement FROM @grantUserCMD;
  EXECUTE grantUserStatement;
  DEALLOCATE PREPARE grantUserStatement;   
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`apagar_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `apagar_user`(
  IN in_ID  Integer
  )
BEGIN
  DELETE FROM User WHERE ID=in_ID;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`editar_user`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `editar_user`(
  IN in_ID  Integer,
  IN in_email   char(50),
  IN in_nome   char(20),
  IN in_apelido   char(20)
  )
BEGIN
  UPDATE User SET email=in_email,nome=in_nome,apelido=in_apelido WHERE ID=in_ID;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`mudar_password`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `mudar_password`(
  IN username varchar(100),
  IN pwd varchar(255)
  )
BEGIN
  SET @passwordUserCMD = concat('SET PASSWORD FOR ''', username, '''@''', 'localhost', ''' = PASSWORD(''', pwd, ''');');
  PREPARE passwordUserStatement FROM @passwordUserCMD;
  EXECUTE passwordUserStatement;
  DEALLOCATE PREPARE passwordUserStatement;   
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`ackowledge_sensor`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `ackowledge_sensor`(
  IN in_ID  Integer
  )
BEGIN
  UPDATE Sensores SET senAck=true WHERE ID=in_ID;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`actualizar_sensor`;

USE `Museu`;
DELIMITER $$
CREATE PROCEDURE `actualizar_sensor`(
  IN in_ID  Integer,
  IN in_senAviso  Integer,
  IN in_senAlarme  Integer,
  IN in_senLeituras  Integer
  
  )
BEGIN
  UPDATE Sensores SET senAviso=in_senAviso, senAlarme=in_senAlarme, senLeituras=in_senLeituras WHERE ID=in_ID;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Museu`.`ronda_extra`;

USE `Museu`;
DELIMITER $$
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

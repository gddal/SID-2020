DELIMITER $$
USE `Main`$$
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

    SET @dropUserCMD = concat('DROP USER IF EXISTS ''', in_username, ''';');
    PREPARE dropUserStatement FROM @dropUserCMD;
    EXECUTE dropUserStatement;
    DEALLOCATE PREPARE dropUserStatement;   

    SET @createUserCMD = concat('CREATE USER ''', in_username, ''' IDENTIFIED BY ''', in_pwd, ''';');
    PREPARE createUserStatement FROM @createUserCMD;
    EXECUTE createUserStatement;
    DEALLOCATE PREPARE createUserStatement;   

    SET @grantUserCMD = concat('GRANT ''', in_Grupo_ID ,''' TO ''', in_username, ''';');
    PREPARE grantUserStatement FROM @grantUserCMD;
    EXECUTE grantUserStatement;
    DEALLOCATE PREPARE grantUserStatement;   

    SET @grantUserCMD = concat('SET DEFAULT ROLE ''', in_Grupo_ID ,''' TO ''', in_username, ''';');
    PREPARE grantDefaultRoleStatement FROM @grantUserCMD;
    EXECUTE grantDefaultRoleStatement;
    DEALLOCATE PREPARE grantDefaultRoleStatement;   
  END IF;
END$$

DROP procedure IF EXISTS `inserir_sensor`$$
CREATE PROCEDURE `inserir_sensor`(
  IN in_ID  varchar(3),
  IN in_senMin   DECIMAL(6,2),  
  IN in_senAviso  DECIMAL(6,2),
  IN in_senAlarme  DECIMAL(6,2)
  )
BEGIN
  IF NOT EXISTS (SELECT * FROM Sensores WHERE ID = in_ID) THEN
    INSERT INTO Sensores (ID,senMin,senAviso,senAlarme) VALUES(in_ID,in_senMin,in_senAviso,in_senAlarme);
  END IF;
END$$

DROP procedure IF EXISTS `actualizar_sensor`$$
CREATE PROCEDURE `actualizar_sensor`(
  IN in_ID  varchar(3),
  IN in_senMin   DECIMAL(6,2),  
  IN in_senAviso  DECIMAL(6,2),
  IN in_senAlarme  DECIMAL(6,2) 
  )
BEGIN
  UPDATE Sensores SET senMin=in_senMin, senAviso=in_senAviso, senAlarme=in_senAlarme WHERE ID = in_ID;
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

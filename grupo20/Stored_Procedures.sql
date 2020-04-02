CREATE DEFINER=`root`@`localhost` PROCEDURE `CriarUtilizador`(iEmailUtilizador varchar(100),iNomeUtilizador varchar(80) ,iTipoUtilizador enum('Seguranca','Chefe Seguranca','Administrador','DiretorMuseu') ,iMoradaUtilizador varchar(200) ,iSenhaUtilizador varchar(30))
BEGIN
  SET @criarUtilizadorCMD = concat('CREATE USER ''', iEmailUtilizador, '''@''', 'localhost', ''' IDENTIFIED BY ''', iSenhaUtilizador, ''';');
  PREPARE criarUtilizadorStatement FROM @criarUtilizadorCMD;
  EXECUTE criarUtilizadorStatement;
  DEALLOCATE PREPARE criarUtilizadorStatement;   
  
  SET @garantirUtilizadorCMD = concat('GRANT ''', iTipoUtilizador ,''' TO ''', iEmailUtilizador, '''@''', 'localhost', ''';');
  PREPARE garantirUtilizadorStatement FROM @garantirUtilizadorCMD;
  EXECUTE garantirUtilizadorStatement;
  DEALLOCATE PREPARE garantirUtilizadorStatement;   
  
  INSERT into utilizador
Values(iEmailUtilizador,iNomeUtilizador,iTipoUtilizador,iMoradaUtilizador);
END



CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoverUtilizador`(iEmailUtilizador varchar(100))
BEGIN
 SET @apagarUtilizadorCMD = concat('DROP USER ''', iEmailUtilizador, '''@''', 'localhost', ''';');
  PREPARE apagarUtilizadorStatement FROM @apagarUtilizadorCMD;
  EXECUTE apagarUtilizadorStatement;
  DEALLOCATE PREPARE apagarUtilizadorStatement; 

DELETE FROM utilizador WHERE EmailUtilizador = iEmailUtilizador;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterarPasswordUtilizador`(iEmailUtilizador varchar(100), iSenhaUtilizador varchar(255))
BEGIN
  SET @senhaUtilizadorCMD = concat('SET PASSWORD FOR ''', iEmailUtilizador, '''@''', 'localhost', ''' = PASSWORD(''', iSenhaUtilizador, ''');');
  PREPARE senhaUtilizadorStatement FROM @senhaUtilizadorCMD;
  EXECUTE senhaUtilizadorStatement;
  DEALLOCATE PREPARE senhaUtilizadorStatement;   
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterarMoradaUtilizador`(iEmailUtilizador varchar(100), iMoradaUtilizador varchar(200))
BEGIN
UPDATE utilizador SET MoradaUtilizador = iMoradaUtilizador WHERE EmailUtilizador= iEmailUtilizador;
END



CREATE DEFINER=`root`@`localhost` PROCEDURE `CriarRondaPlaneada`(iEmailUtilizador varchar(100), iDataAno date, iHoraRonda time)
BEGIN
INSERT into rondaplaneada
Values(iEmailUtilizador, iDataAno, iHoraRonda);
END



CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterarRondaPlaneada`(iEmailUtilizador varchar(100), iDataAno date, iHoraRonda time)
BEGIN
UPDATE rondaplaneada SET DataAno = iDataAno, HoraRonda = iHoraRonda WHERE EmailUtilizador= iEmailUtilizador;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoverRondaPlaneada`(iEmailUtilizador varchar(100), iDataAno date, iHoraRonda time)
BEGIN
DELETE FROM rondaplaneada WHERE EmailUtilizador = iEmailUtilizador;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `CriarRondaExtra`(iEmailUtilizador varchar(100), iHoraInicio time, iHoraFim time, iData date)
BEGIN
INSERT into rondaextra
Values(iEmailUtilizador, iHoraInicio, iHoraFim, iData);
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaUtilizadores`()
BEGIN
SELECT * FROM utilizador
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLogUtilizadores`()
BEGIN
SELECT * FROM logutilizador
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarLogRondaExtra`()
BEGIN
SELECT * FROM logrondaextra
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarLogRondaPlaneada`()
BEGIN
SELECT * FROM logrondaplaneada
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarLogSistema`()
BEGIN
SELECT * FROM logsistema
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarLogMedicoes`()
BEGIN
SELECT * FROM logmedicoes;
END


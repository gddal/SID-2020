

DROP USER 'system@localhost';
CREATE USER 'system@localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testing.* TO 'system@localhost';
GRANT ALL PRIVILEGES ON testing_log.* TO 'system@localhost';

	
CREATE ROLE Administrador,
			DiretorMuseu,
			ChefeSeguranca,
			Seguranca,
			Auditor;

-- MUSEU --
	
-- roles admin --    
    
GRANT INSERT, UPDATE, DELETE ON testing.utilizador TO Administrador; 
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.rondaplaneada TO Administrador; 
GRANT SELECT, DELETE ON testing.rondaextra TO Administrador; 
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.sistema TO Administrador; 
GRANT SELECT ON testing.medicoessensores TO Administrador; 

GRANT EXECUTE ON PROCEDURE testing.CriarUtilizador TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.RemoverUtilizador TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaPlaneada TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.AlterarRondaPlaneada TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.RemoverRondaPlaneada TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO Administrador;
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO Administrador;

-- roles Diretor --    

GRANT SELECT ON testing.rondaplaneada TO DiretorMuseu; 
GRANT SELECT ON testing.rondaextra TO DiretorMuseu; 
GRANT SELECT ON testing.sistema TO DiretorMuseu; 
GRANT SELECT ON testing.medicoessensores TO DiretorMuseu;  
 
GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO DiretorMuseu;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO DiretorMuseu; 
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO DiretorMuseu;

-- roles Chefe Seguranca --  
  
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.rondaplaneada TO ChefeSeguranca; 
GRANT SELECT ON testing.rondaextra TO ChefeSeguranca; 

GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaPlaneada TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarRondaPlaneada TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.RemoverRondaPlaneada TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO ChefeSeguranca;
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO ChefeSeguranca;

-- roles Seguranca --    

GRANT SELECT ON testing.rondaplaneada TO DiretorMuseu; 

GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO Seguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO Seguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO Seguranca;


-- LOGS --

-- roles auditor --

GRANT SELECT ON testing_log.logutilizador TO Auditor;
GRANT SELECT ON testing_log.logrondaextra TO Auditor;
GRANT SELECT ON testing_log.logrondaplaneada TO Auditor;
GRANT SELECT ON testing_log.logmedicoes TO Auditor;
GRANT SELECT ON testing_log.logsistema TO Auditor;

GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogUtilizadores TO Auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultarLogRondaExtra TO Auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultarLogRondaPlaneada TO Auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultarLogSistema TO Auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultarLogMedicoes TO Auditor;  








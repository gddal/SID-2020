DROP USER 'system@localhost';
CREATE USER 'system@localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testing.* TO 'system@localhost';
GRANT ALL PRIVILEGES ON testing_log.* TO 'system@localhost';

	
CREATE ROLE 
    role_admin, 
    role_diretor, 
    role_cseguranca,
    role_seguranca,
    role_auditor;

-- MUSEU --
	
-- roles admin --    
    
GRANT INSERT, UPDATE, DELETE ON testing.utilizador TO role_admin; 
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.rondaplaneada TO role_admin; 
GRANT SELECT, DELETE ON testing.rondaextra TO role_admin; 
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.sistema TO role_admin; 
GRANT SELECT ON testing.medicoessensores TO role_admin; 

GRANT EXECUTE ON PROCEDURE testing.CriarUtilizador TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.RemoverUtilizador TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaPlaneada TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.AlterarRondaPlaneada TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.RemoverRondaPlaneada TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO role_admin;
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO role_admin;

-- roles Diretor --    

GRANT SELECT ON testing.rondaplaneada TO role_diretor; 
GRANT SELECT ON testing.extra TO role_diretor; 
GRANT SELECT ON testing.sistema TO role_diretor; 
GRANT SELECT ON testing.medicoessensores TO role_diretor;  
 
GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO role_diretor;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO role_diretor; 
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO role_diretor;

-- roles Chefe Seguranca --  
  
GRANT SELECT, INSERT, UPDATE, DELETE ON testing.rondaplaneada TO role_cseguranca; 
GRANT SELECT ON testing.rondaextra TO role_cseguranca; 

GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaPlaneada TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarRondaPlaneada TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.RemoverRondaPlaneada TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO role_cseguranca;
GRANT EXECUTE ON PROCEDURE testing.ConsultaUtilizadores TO role_cseguranca;

-- roles Seguranca --    

GRANT SELECT ON testing.rondaplaneada TO role_diretor; 

GRANT EXECUTE ON PROCEDURE testing.AlterarPasswordUtilizador TO role_seguranca;
GRANT EXECUTE ON PROCEDURE testing.AlterarMoradaUtilizador TO role_seguranca;
GRANT EXECUTE ON PROCEDURE testing.CriarRondaExtra TO role_seguranca;




-- LOGS --

-- roles auditor --

GRANT SELECT ON testing_log.logutilizador TO role_auditor;
GRANT SELECT ON testing_log.logrondaextra TO role_auditor;
GRANT SELECT ON testing_log.logrondaplaneada TO role_auditor;
GRANT SELECT ON testing_log.logmedicoes TO role_auditor;
GRANT SELECT ON testing_log.logsistema TO role_auditor;

GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogUtilizadores TO role_auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogRondaExtra TO role_auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogRondaPlaneada TO role_auditor;
GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogUtilizadores TO role_auditor;
-- GRANT EXECUTE ON PROCEDURE testing_log.ConsultaLogMedicoes TO role_auditor;  FALTA ESTE





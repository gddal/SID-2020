USE `Main`;
DROP USER IF EXISTS museu_system;
CREATE USER museu_system IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON Main.* TO museu_system;

DROP ROLE IF EXISTS Administradores;
DROP ROLE IF EXISTS Directores;
DROP ROLE IF EXISTS Chefes;
DROP ROLE IF EXISTS Segurancas;

CREATE ROLE Administradores;
CREATE ROLE Directores;
CREATE ROLE Chefes;
CREATE ROLE Segurancas;

GRANT ALL PRIVILEGES ON Main.* TO Administradores;

GRANT SELECT ON Main.Ronda TO Segurancas;
GRANT SELECT, INSERT, UPDATE, DELETE ON Main.Ronda TO Chefes;

GRANT SELECT ON Main.RondaPlaneada TO Segurancas;
GRANT SELECT, INSERT, UPDATE, DELETE ON Main.RondaPlaneada TO Chefes;

GRANT SELECT, INSERT, UPDATE ON Main.RondaExtra TO Segurancas;
GRANT SELECT ON Main.RondaExtra TO Chefes;

GRANT SELECT ON Main.medicoessensores TO Directores;
GRANT SELECT ON Main.medicoessensores TO Chefes;

GRANT SELECT ON Main.Alerta TO Directores;
GRANT SELECT ON Main.Alerta TO Chefes;

GRANT EXECUTE ON PROCEDURE Main.inserir_user TO Administradores;
GRANT EXECUTE ON PROCEDURE Main.inserir_sensor TO Administradores;
GRANT EXECUTE ON PROCEDURE Main.actualizar_sensor TO Administradores;
GRANT EXECUTE ON PROCEDURE Main.ronda_extra TO Segurancas;

FLUSH PRIVILEGES;

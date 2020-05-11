DROP USER IF EXISTS system@localhost;
CREATE USER system@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON Main.* TO system@localhost;
GRANT ALL PRIVILEGES ON Log.* TO system@localhost;

DROP ROLE IF EXISTS Adm;
DROP ROLE IF EXISTS Dir;
DROP ROLE IF EXISTS Che;
DROP ROLE IF EXISTS Seg;
DROP ROLE IF EXISTS Aud;

CREATE ROLE Adm;
CREATE ROLE Dir;
CREATE ROLE Che;
CREATE ROLE Seg;
CREATE ROLE Aud;

GRANT SELECT ON Main.Ronda TO Seg;
GRANT SELECT, INSERT, UPDATE, DELETE ON Main.Ronda TO Che;

GRANT SELECT ON Main.RondaPlaneada TO Seg;
GRANT SELECT, INSERT, UPDATE, DELETE ON Main.RondaPlaneada TO Che;

GRANT SELECT ON Main.RondaExtra TO Che;

GRANT SELECT, INSERT, UPDATE, DELETE ON Main.User TO Adm;

GRANT SELECT ON Main.Medicoes TO Dir;
GRANT SELECT ON Main.Medicoes TO Che;

GRANT SELECT, INSERT, UPDATE, DELETE ON Main.Sensores TO Adm;


GRANT EXECUTE ON PROCEDURE Main.ronda_extra TO Seg;

GRANT EXECUTE ON PROCEDURE Main.inserir_user TO Adm;
GRANT EXECUTE ON PROCEDURE Main.create_user TO Adm;
GRANT EXECUTE ON PROCEDURE Main.grant_user TO Adm;

GRANT EXECUTE ON PROCEDURE Main.apagar_user TO Adm;
GRANT EXECUTE ON PROCEDURE Main.delete_user TO Adm;

GRANT EXECUTE ON PROCEDURE Main.select_user TO Adm;
GRANT EXECUTE ON PROCEDURE Main.select_user TO Dir;
GRANT EXECUTE ON PROCEDURE Main.select_user TO Che;
GRANT EXECUTE ON PROCEDURE Main.select_user TO Seg;

GRANT EXECUTE ON PROCEDURE Main.select_user_id TO Adm;
GRANT EXECUTE ON PROCEDURE Main.select_user_id TO Dir;
GRANT EXECUTE ON PROCEDURE Main.select_user_id TO Che;
GRANT EXECUTE ON PROCEDURE Main.select_user_id TO Seg;

GRANT EXECUTE ON PROCEDURE Main.editar_user TO Adm;
GRANT EXECUTE ON PROCEDURE Main.editar_user TO Dir;
GRANT EXECUTE ON PROCEDURE Main.editar_user TO Che;
GRANT EXECUTE ON PROCEDURE Main.editar_user TO Seg;

GRANT EXECUTE ON PROCEDURE Main.mudar_password TO Adm;
GRANT EXECUTE ON PROCEDURE Main.mudar_password TO Dir;
GRANT EXECUTE ON PROCEDURE Main.mudar_password TO Che;
GRANT EXECUTE ON PROCEDURE Main.mudar_password TO Seg;

GRANT EXECUTE ON PROCEDURE Main.ackowledge_sensor TO Che;
GRANT EXECUTE ON PROCEDURE Main.ackowledge_sensor TO Seg;

GRANT EXECUTE ON PROCEDURE Main.actualizar_sensor TO Adm;

GRANT SELECT ON Log.User_log TO Aud;
GRANT SELECT ON Log.Grupo_log TO Aud;
GRANT SELECT ON Log.Ronda_log TO Aud;
GRANT SELECT ON Log.RondaPlaneada_log TO Aud;
GRANT SELECT ON Log.RondaExtra_log TO Aud;
GRANT SELECT ON Log.Sensores_log TO Aud;
GRANT SELECT ON Log.Medicoes_log TO Aud;

FLUSH PRIVILEGES;

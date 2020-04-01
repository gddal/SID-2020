DROP USER system@localhost;
CREATE USER system@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON Museu.* TO system@localhost;
GRANT ALL PRIVILEGES ON Auditor.* TO system@localhost;

CREATE ROLE Adm;
CREATE ROLE Dir;
CREATE ROLE Che;
CREATE ROLE Seg;
CREATE ROLE Aud;

GRANT SELECT ON Museu.Ronda TO Seg;
GRANT SELECT, INSERT, UPDATE, DELETE ON Museu.Ronda TO Che;

GRANT SELECT ON Museu.RondaPlaneada TO Seg;
GRANT SELECT, INSERT, UPDATE, DELETE ON Museu.RondaPlaneada TO Che;

GRANT SELECT ON Museu.RondaExtra TO Che;

GRANT SELECT, INSERT, UPDATE, DELETE ON Museu.User TO Adm;

GRANT SELECT ON Museu.Medicoes TO Dir;
GRANT SELECT ON Museu.Medicoes TO Che;

GRANT SELECT, INSERT, UPDATE, DELETE ON Museu.Sensores TO Adm;


GRANT EXECUTE ON PROCEDURE Museu.ronda_extra TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.inserir_user TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.create_user TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.grant_user TO Adm;

GRANT EXECUTE ON PROCEDURE Museu.apagar_user TO Adm;

GRANT EXECUTE ON PROCEDURE Museu.select_user TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.select_user TO Dir;
GRANT EXECUTE ON PROCEDURE Museu.select_user TO Che;
GRANT EXECUTE ON PROCEDURE Museu.select_user TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.select_user_id TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.select_user_id TO Dir;
GRANT EXECUTE ON PROCEDURE Museu.select_user_id TO Che;
GRANT EXECUTE ON PROCEDURE Museu.select_user_id TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.editar_user TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.editar_user TO Dir;
GRANT EXECUTE ON PROCEDURE Museu.editar_user TO Che;
GRANT EXECUTE ON PROCEDURE Museu.editar_user TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.mudar_password TO Adm;
GRANT EXECUTE ON PROCEDURE Museu.mudar_password TO Dir;
GRANT EXECUTE ON PROCEDURE Museu.mudar_password TO Che;
GRANT EXECUTE ON PROCEDURE Museu.mudar_password TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.ackowledge_sensor TO Che;
GRANT EXECUTE ON PROCEDURE Museu.ackowledge_sensor TO Seg;

GRANT EXECUTE ON PROCEDURE Museu.actualizar_sensor TO Adm;

GRANT SELECT ON Auditor.User_log TO Aud;
GRANT SELECT ON Auditor.Grupo_log TO Aud;
GRANT SELECT ON Auditor.Ronda_log TO Aud;
GRANT SELECT ON Auditor.RondaPlaneada_log TO Aud;
GRANT SELECT ON Auditor.RondaExtra_log TO Aud;
GRANT SELECT ON Auditor.Sensores_log TO Aud;
GRANT SELECT ON Auditor.Medicoes_log TO Aud;

FLUSH PRIVILEGES;

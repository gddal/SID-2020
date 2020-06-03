INSERT INTO Main.Grupo (nome,descricao) VALUES ('Administradores','Administrador' );
INSERT INTO Main.Grupo (nome,descricao) VALUES ('Directores','Diretor do museu' );
INSERT INTO Main.Grupo (nome,descricao) VALUES ('Chefes','Chefe de segurança' );
INSERT INTO Main.Grupo (nome,descricao) VALUES ('Segurancas','Segurança' );

CALL Main.inserir_user( 'Administradores', 'adm', 'museu_adm@none.net', 'Administrador', 'da aplicação', 'pass' );
CALL Main.inserir_user( 'Directores', 'dir', 'museu_dir@none.net', 'Diretor', 'do museu', 'pass' );
CALL Main.inserir_user( 'Chefes', 'che', 'museu_che@none.net', 'Chefe', 'de segurança', 'pass' );
CALL Main.inserir_user( 'Segurancas', 'seg', 'museu_seg@none.net', 'Segurança', 'do museu', 'pass' );

CALL Main.inserir_sensor( 'tmp', 10, 40, 60 );
CALL Main.inserir_sensor( 'hum', 20, 80, 90 );
CALL Main.inserir_sensor( 'cel', 0, 0, 200 );
CALL Main.inserir_sensor( 'mov', 0, 0, 1 );

INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('1','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('1','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('1','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('1','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('2','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('2','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('2','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('2','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('3','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('3','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('3','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('3','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('4','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('4','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('4','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('4','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('5','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('5','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('5','18:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('5','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('6','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('6','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('6','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('6','20:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('7','01:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('7','08:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('7','15:00:00' );
INSERT INTO Main.Ronda (diaSemana,inicio) VALUES ('7','20:00:00' );

ALTER USER 'adm' identified with mysql_native_password by 'pass';
ALTER USER 'dir' identified with mysql_native_password by 'pass';
ALTER USER 'che' identified with mysql_native_password by 'pass';
ALTER USER 'seg' identified with mysql_native_password by 'pass';
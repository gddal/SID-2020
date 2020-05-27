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
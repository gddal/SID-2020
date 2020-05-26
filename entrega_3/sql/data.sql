CALL Main.inserir_user( 'Adm', 'adm', 'museu_adm@none.net', 'Administrador', 'da aplicação', 'pass' );
CALL Main.inserir_user( 'Dir', 'dir', 'museu_dir@none.net', 'Diretor', 'do museu', 'pass' );
CALL Main.inserir_user( 'Che', 'che', 'museu_che@none.net', 'Chefe', 'de segurança', 'pass' );
CALL Main.inserir_user( 'Seg', 'seg', 'museu_seg@none.net', 'Segurança', 'do museu', 'pass' );
CALL Main.inserir_user( 'Aud', 'aud', 'museu_aud@none.net', 'Auditor', 'do museu', 'pass' );

CALL Main.inserir_sensor( 'tmp', 0, 40, 60 );
CALL Main.inserir_sensor( 'hum', 20, 80, 90 );
CALL Main.inserir_sensor( 'cel', 0, 0, 700 );
CALL Main.inserir_sensor( 'mov', 0, 0, 1 );
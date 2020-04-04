LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\user_log.csv'
INTO TABLE log.user_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\grupo_log.csv'
INTO TABLE log.grupo_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\rondaplaneada_log.csv'
INTO TABLE log.rondaplaneada_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\rondaextra_log.csv'
INTO TABLE log.rondaextra_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\sensores_log.csv'
INTO TABLE log.sensores_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\medicoes_log.csv'
INTO TABLE log.medicoes_log
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


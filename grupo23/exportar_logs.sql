DELIMITER $$
USE `Main`$$
DROP procedure IF EXISTS `exportar_logs`$$
CREATE PROCEDURE `exportar_logs`()
BEGIN
    SELECT * FROM user_log
    WHERE user_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\user_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM grupo_log
    WHERE grupo_log.opData BETWEEN date_sub(now(), interval 1 day) AND now() 
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\grupo_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM ronda_log
    WHERE ronda_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\ronda_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM rondaplaneada_log
    WHERE rondaplaneada_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\rondaplaneada_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM rondaextra_log
    WHERE rondaextra_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\rondaextra_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM sensores_log
    WHERE sensores_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\sensores_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

    SELECT * FROM medicoes_log
    WHERE medicoes_log.opData BETWEEN date_sub(now(), interval 1 day) AND now()
    INTO OUTFILE 'D:\\Mega\\ISCTE\\Ano3_Semestre2\\SID\\Grupo23\\medicoes_log.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

END$$
  
DELIMITER ;

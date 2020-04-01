LOAD DATA INFILE 'C:\\xampp\\mysql\\bin\\logutilizador.csv' INTO 
TABLE logutilizador 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\xampp\\mysql\\bin\\logsistema.csv' INTO 
TABLE logsistema 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\xampp\\mysql\\bin\\logrondaextra.csv' INTO 
TABLE logrondaextra
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\xampp\\mysql\\bin\\logrondaplaneada.csv' INTO 
TABLE logrondaplaneada
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\xampp\\mysql\\bin\\logmedicoes.csv' INTO 
TABLE logmedicoes
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

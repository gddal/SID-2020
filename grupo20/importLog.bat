@echo off
if exist logutilizador.csv mysql -uroot -p -P 29999 --local-infile "new_schema2" < importaux.sql
else mysql -u root -p -P 29999 "new_schema2" -e "CALL ExportarLogs();"
if exist logutilizador.csv mysql -uroot -p -P 29999 --local-infile "new_schema2" < importaux.sql
else mysql -u root -p -P 29999 "new_schema2" -e "CALL ExportarLogs();"
pause
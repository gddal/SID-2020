@echo off
:start

del *.csv

:export
mysql -uroot -e "CALL exportar_logs();" Main

:import

mysql -uroot < importar_logs.sql


:delete
del *.csv


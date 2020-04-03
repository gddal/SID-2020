@echo off
mysql -u root -p -P 29999 "new_schema2" -e "CALL ExportarLogs();"
if exist logutilizador.csv(
	if exist logrondaextra.csv(
		if exist logrondaplaneada.csv(
			if exist logsistema.csv(
				if exist logmedicoes.csv(
					mysql -uroot -p -P 29999 --local-infile "new_schema2" < importaux.sql
				)
			)
		)
	)
)	
else (
	mysql -u root -p -P 29999 "new_schema2" -e "CALL ExportarLogs();"
	logutilizador.csv mysql -uroot -p -P 29999 --local-infile "new_schema2" < importaux.sql
	)
	
del *.csv

@echo off
:start
goto :export


:export
mysql -u root -p -P 29999 "bdorigem" -e "CALL ExportarLogs();"
goto :fileassurance



:fileassurance
if exist logutilizador.csv (
	if exist logrondaextra.csv (
		if exist logrondaplaneada.csv (
			if exist logsistema.csv (
				if exist logmedicoes.csv (
					goto :import

				)else goto :export
			)else goto :export
		)else goto :export
	)else goto :export
)else goto :export	



:import
logutilizador.csv mysql -uroot -p -P 29999 --local-infile "bddestino" < importaux.sql
goto :delete


:delete
del *.csv
goto :end

:end
echo Migration Complete

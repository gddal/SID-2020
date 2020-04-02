use testing;   -- Usar o nome da base de dados selecionada

 
CREATE TABLE `utilizador` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(80) NOT NULL,
  `TipoUtilizador` enum('Seguranca','ChefeSeguranca','Administrador','DiretorMuseu') NOT NULL,
  `MoradaUtilizador` varchar(200) NOT NULL,
  PRIMARY KEY (`EmailUtilizador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `rondaplaneada` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `DataAno` date NOT NULL,
  `HoraRonda` time NOT NULL,
  PRIMARY KEY (`EmailUtilizador`,`DataAno`,`HoraRonda`),
  CONSTRAINT `utilizador_rondaplaneada` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `sistema` (
  `LimiteTemperatura` decimal(6,2) NOT NULL,
  `LimiteHumidade` decimal(6,2) NOT NULL,
  `LimiteLuminosidade` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `rondaextra` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `HoraInicio` time NOT NULL,
  `HoraFim` time NOT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`EmailUtilizador`),
  CONSTRAINT `utilizador__rondaextra` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `medicoessensores` (
  `IDmedicao` int(11) NOT NULL,
  `ValorMedicao` decimal(6,2) DEFAULT NULL,
  `TipoSensor` varchar(3) DEFAULT NULL,
  `DataHoraMedicao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IDmedicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `logutilizador` (
  `ID` int(11) NOT NULL,
  `DataOperacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(15) NOT NULL,
  `EmailAnterior` varchar(100) DEFAULT NULL,
  `EmailNovo` varchar(100) DEFAULT NULL,
  `NomeAnterior` varchar(80) DEFAULT NULL,
  `NomeNovo` varchar(80) DEFAULT NULL,
  `MoradaAnterior` varchar(200) DEFAULT NULL,
  `MoradaNova` varchar(200) DEFAULT NULL,
  `TipoAnterior` enum('Seguranca','Chefe Seguranca','Administrador','DiretorMuseu') DEFAULT NULL,
  `TipoNovo` enum('Seguranca','Chefe Seguranca','Administrador','DiretorMuseu') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `logsistema` (
  `ID` int(11) NOT NULL,
  `DataOperacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(15) NOT NULL,
  `LimiteTemperaturaAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteTemperaturaNovo` decimal(6,2) DEFAULT NULL,
  `LimiteHumidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteHumidadeNovo` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidadeNovo` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `logrondaplaneada` (
  `ID` int(11) NOT NULL,
  `DataOperacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(15) NOT NULL,
  `EmailAnterior` varchar(100) DEFAULT NULL,
  `EmailNovo` varchar(100) DEFAULT NULL,
  `DataAnterior` date DEFAULT NULL,
  `DataNova` date DEFAULT NULL,
  `HoraAnterior` time DEFAULT NULL,
  `HoraNova` time DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `logrondaextra` (
  `ID` int(11) NOT NULL,
  `DataOperacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(15) NOT NULL,
  `UserNameAnterior` varchar(80) DEFAULT NULL,
  `UserNameNovo` varchar(80) DEFAULT NULL,
  `HoraInicioAnterior` time DEFAULT NULL,
  `HoraInicioNova` time DEFAULT NULL,
  `HoraFimAnterior` time DEFAULT NULL,
  `HoraFimNova` time DEFAULT NULL,
  `DataAnterior` date DEFAULT NULL,
  `DataNova` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `logmedicoes` (
  `ID` int(11) NOT NULL,
  `DataOperacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `utilizadorID` int(11) NOT NULL,
  `Operacao` varchar(15) NOT NULL,
  `IdMedicaoAnterior` int(11) DEFAULT NULL,
  `IdMedicaoNova` int(11) DEFAULT NULL,
  `ValorMedicaoAnterior` decimal(6,2) DEFAULT NULL,
  `ValorMedicaoNova` decimal(6,2) DEFAULT NULL,
  `TipoSensorAnterior` varchar(3) DEFAULT NULL,
  `TipoSensorNovo` varchar(3) DEFAULT NULL,
  `DataHoraMedicaoAnterior` timestamp NULL DEFAULT NULL,
  `DataHoraMedicaoNova` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



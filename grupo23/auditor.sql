create database Log;

drop table if exists Log.User_log ;
drop table if exists Log.Grupo_log ;
drop table if exists Log.Ronda_log ;
drop table if exists Log.RondaPlaneada_log ;
drop table if exists Log.RondaExtra_log ;
drop table if exists Log.Sensores_log ;
drop table if exists Log.Medicoes_log ;

create table Log.User_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null,
   User_ID   Integer   null,
   Grupo_IDAntes   char(20)   null,
   Grupo_IDDepois   char(20)   null,
   usernameAntes   char(20)   null,
   usernameDepois   char(20)   null,
   emailAntes   char(50)   null,
   emailDepois   char(50)   null,
   nomeAntes   char(20)   null,
   nomeDepois   char(20)   null,
   apelidoAntes   char(20)   null,
   apelidoDepois   char(20)   null,
 
   constraint PK_User_log primary key (ID)
);
 
create table Log.Grupo_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null,
   descricaoAntes   char(50)   null,
   descricaoDepois   char(50)   null,
   nomeAntes   char(20)   null,
   nomeDepois   char(20)   null,
 
   constraint PK_Grupo_log primary key (ID)
);
 
create table Log.Ronda_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null,
   diaSemanaAntes   char(20)   null,
   diaSemanaDepois   char(20)   null,
   inicioAntes   time   null,
   incioDepois   time   null,
   duracaoAntes   int(5)   null,
   duracaoDepois   int(5)   null,
 
   constraint PK_Ronda_logs primary key (ID)
);

create table Log.RondaPlaneada_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null,
   User_IDAntes   Integer   null,
   User_IDDepois   Integer   null,
   Ronda_diaSemanaAntes   char(20)   null,
   Ronda_diaSemanaDepois   char(20)   null,
   Ronda_inicioAntes   time   null,
   Ronda_inicioDepois   time   null,
   dataAntes   date   null,
   dataDepois   date   null,
 
   constraint PK_RondaPlaneada_log primary key (ID)
);
 
create table Log.RondaExtra_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null,
   User_IDAntes   Integer   null,
   User_IDDepois   Integer   null,
   dataInicioAntes   datetime   null,
   dataInicioDepois   datetime   null,
   dataFimAntes   datetime   null,
   dataFimDepois   datetime   null,
 
   constraint PK_RondaExtra_log primary key (ID)
);

create table Log.Sensores_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   int(20)   not null,
   senTipo   char(10)   null,
   senEstadoAntes   int(2)   null,
   senEstadoDepois   int(2)   null,
   senAckAntes   Boolean   null,
   senAckDepois   Boolean   null,
   senAvisoAntes   int(3)   null,
   senAvisoDepois   int(3)   null,
   senAlarmeAntes   int(3)   null,
   senAlarmeDepois   int(3)   null,
   sen_leiturasAntes   int(5)   null,
   sen_leiturasDepois   int(5)   null,
 
   constraint PK_Sensores_log primary key (ID)
);

create table Log.Medicoes_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   int(20)   not null,
   Sensor_IDAntes   Integer   null,
   Sensor_IDDepois   Integer   null,
   valorAntes   int(3)   null,
   valorDepois   int(3)   null,
   dataHoraAntes   datetime   null,
   dataHoraDepois   datetime   null,
 
   constraint PK_Medicoes_log primary key (ID)
);
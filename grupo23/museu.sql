create database Museu;

drop table if exists Museu.User ;
drop table if exists Museu.Grupo ;
drop table if exists Museu.Ronda ;
drop table if exists Museu.RondaExtra ;
drop table if exists Museu.RondaPlaneada ;
drop table if exists Museu.Sensores ;
drop table if exists Museu.Medicoes ;
 
create table Museu.User
(
   ID   Integer   not null auto_increment,
   Grupo_ID   char(20)   not null,
   username   char(20)   not null,
   email   char(50)   not null,
   nome   char(20)   not null,
   apelido   char(20)   not null,
 
   constraint PK_User primary key (ID)
);

create table Museu.Grupo
(
   nome   char(20)   not null,
   descricao   char(50)   not null,
 
   constraint PK_Grupo primary key (nome)
);

create table Museu.Ronda
(
   diaSemana   char(20)   not null,
   inicio   time   not null,
   duracao   int(5)   not null,
 
   constraint PK_Ronda primary key (diaSemana, inicio)
);
 
 create table Museu.RondaPlaneada
(
   User_ID   Integer   not null,
   Ronda_diaSemana   char(20)   not null,
   Ronda_inicio   time   not null,
   data   date   not null,
 
   constraint PK_RondaPlaneada primary key (User_ID, Ronda_diaSemana, Ronda_inicio)
);
 
create table Museu.RondaExtra
(
   ID   Integer   not null auto_increment,
   User_ID   Integer   not null,
   dataInicio   datetime   not null,
   dataFim   datetime   null,
 
   constraint PK_RondaExtra primary key (ID)
);
 
create table Museu.Sensores
(
   ID   Integer   not null auto_increment,
   senTipo   char(10)   null,
   senEstado   int(2)   null,
   senAck   Boolean   null,
   senAviso   int(3)   null,
   senAlarme   int(3)   null,
   senLeituras   int(5)   null,
 
   constraint PK_Sensores primary key (ID)
);
 
create table Museu.Medicoes
(
   ID   Integer   not null auto_increment,
   Sensor_ID   Integer   not null,
   valor   int(3)   null,
   datahora   datetime   null,
 
   constraint PK_Medicoes primary key (ID)
); 

alter table Museu.User
   add constraint FK_User_userGrupo_Grupo foreign key (Grupo_ID)
   references Grupo(nome)
   on delete restrict
   on update cascade
;
 
alter table Museu.RondaPlaneada
   add constraint FK_User_RondaPlaneada_Ronda_ foreign key (User_ID)
   references User(ID)
   on delete cascade
   on update cascade
; 
alter table Museu.RondaPlaneada
   add constraint FK_Ronda_RondaPlaneada_User_ foreign key (Ronda_diaSemana, Ronda_inicio)
   references Ronda(diaSemana, inicio)
   on delete cascade
   on update cascade
;

alter table Museu.RondaExtra
   add constraint FK_RondaExtra_User foreign key (User_ID)
   references User(ID)
   on delete restrict
   on update cascade
;
  
alter table Museu.Medicoes
   add constraint FK_Medicoes_noname_Sensores foreign key (Sensor_ID)
   references Sensores(ID)
   on delete restrict
   on update cascade
;

INSERT INTO Museu.Grupo (nome,descricao) VALUES ('Adm','Administrador' );
INSERT INTO Museu.Grupo (nome,descricao) VALUES ('Dir','Diretor do museu' );
INSERT INTO Museu.Grupo (nome,descricao) VALUES ('Che','Chefe de segurança' );
INSERT INTO Museu.Grupo (nome,descricao) VALUES ('Seg','Segurança' );
INSERT INTO Museu.Grupo (nome,descricao) VALUES ('Aud','Auditor' );

drop table if exists Museu.User_log ;
drop table if exists Museu.Grupo_log ;
drop table if exists Museu.Ronda_log ;
drop table if exists Museu.RondaPlaneada_log ;
drop table if exists Museu.RondaExtra_log ;
drop table if exists Museu.Sensores_log ;
drop table if exists Museu.Medicoes_log ;

create table Museu.User_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null auto_increment,
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
 
create table Museu.Grupo_log
(
   op   char(30)   null,
   op_user   char(20)   null,
   op_data   datetime   null,
   ID   Integer   not null auto_increment,
   descricaoAntes   char(50)   null,
   descricaoDepois   char(50)   null,
   nomeAntes   char(20)   null,
   nomeDepois   char(20)   null,
 
   constraint PK_Grupo_log primary key (ID)
);
 
create table Museu.Ronda_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null auto_increment,
   diaSemanaAntes   char(20)   null,
   diaSemanaDepois   char(20)   null,
   inicioAntes   time   null,
   incioDepois   time   null,
   duracaoAntes   int(5)   null,
   duracaoDepois   int(5)   null,
 
   constraint PK_Ronda_logs primary key (ID)
);

create table Museu.RondaPlaneada_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null auto_increment,
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
 
create table Museu.RondaExtra_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   Integer   not null auto_increment,
   User_IDAntes   Integer   null,
   User_IDDepois   Integer   null,
   dataInicioAntes   datetime   null,
   dataInicioDepois   datetime   null,
   dataFimAntes   datetime   null,
   dataFimDepois   datetime   null,
 
   constraint PK_RondaExtra_log primary key (ID)
);

create table Museu.Sensores_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   int(20)   not null auto_increment,
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

create table Museu.Medicoes_log
(
   op   char(30)   null,
   opUser   char(20)   null,
   opData   datetime   null,
   ID   int(20)   not null auto_increment,
   Sensor_IDAntes   Integer   null,
   Sensor_IDDepois   Integer   null,
   valorAntes   int(3)   null,
   valorDepois   int(3)   null,
   dataHoraAntes   datetime   null,
   dataHoraDepois   datetime   null,
 
   constraint PK_Medicoes_log primary key (ID)
);

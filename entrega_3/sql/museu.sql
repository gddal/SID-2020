create database Main;

drop table if exists Main.User ;
drop table if exists Main.Grupo ;
drop table if exists Main.Ronda ;
drop table if exists Main.RondaExtra ;
drop table if exists Main.RondaPlaneada ;
drop table if exists Main.Sensores ;
drop table if exists Main.MedicoesSensores;
drop table if exists Main.Alerta ;
 
create table Main.User
(
   ID   Integer   not null auto_increment,
   Grupo_ID   char(20)   not null,
   username   char(20)   not null,
   email   char(50)   not null,
   nome   char(20)   not null,
   apelido   char(20)   not null,
 
   constraint PK_User primary key (ID)
);

create table Main.Grupo
(
   nome   char(20)   not null,
   descricao   char(50)   not null,
 
   constraint PK_Grupo primary key (nome)
);

create table Main.Ronda
(
   diaSemana   char(20)   not null,
   inicio   time   not null,
 
   constraint PK_Ronda primary key (diaSemana, inicio)
);
 
 create table Main.RondaPlaneada
(
   User_ID   Integer   not null,
   Ronda_diaSemana   char(20)   not null,
   Ronda_inicio   time   not null,
   data   date   not null,
   fim   time   not null,
 
   constraint PK_RondaPlaneada primary key (User_ID, Ronda_diaSemana, Ronda_inicio)
);
 
create table Main.RondaExtra
(
   ID   Integer   not null auto_increment,
   User_ID   Integer   not null,
   dataInicio   datetime   not null,
   dataFim   datetime   null,
 
   constraint PK_RondaExtra primary key (ID)
);
 
create table Main.Sensores
(
   ID   varchar(3)   null,
   senAviso   decimal(6,2)   null,
   senAlarme   decimal(6,2)   null,
   senMin   decimal(6,2)   null,
 
   constraint PK_Sensores primary key (ID)
);

create table Main.MedicoesSensores
(
   ID   Integer   not null auto_increment,
   TipoSensor   varchar(3)   null,
   ValorMedicao   decimal(6,2)   null,
   DataHoraMedicao   timestamp   null,
 
   constraint PK_Medicoes primary key (ID)
); 

 create table Main.Alerta
(
   ID   Integer   not null auto_increment,
   DataHoraMedicao   timestamp   null,
   TipoSensor   varchar(3)   null,
   ValorMedicao   decimal(6,2)   null,
   Limite   decimal(6,2)   null,
   Descricao   varchar(1000)   null,
   Controlo   Boolean   null,
   Extra   varchar(100)   null,

   constraint PK_Alerta primary key (ID)
);

 alter table Main.User
   add constraint FK_User_userGrupo_Grupo foreign key (Grupo_ID)
   references Grupo(nome)
   on delete restrict
   on update cascade
;
 
alter table Main.RondaPlaneada
   add constraint FK_User_RondaPlaneada_Ronda_ foreign key (User_ID)
   references User(ID)
   on delete restrict
   on update cascade
; 
alter table Main.RondaPlaneada
   add constraint FK_Ronda_RondaPlaneada_User_ foreign key (Ronda_diaSemana, Ronda_inicio)
   references Ronda(diaSemana, inicio)
   on delete restrict
   on update cascade
;

alter table Main.RondaExtra
   add constraint FK_RondaExtra_User foreign key (User_ID)
   references User(ID)
   on delete restrict
   on update cascade
;
  
alter table Main.MedicoesSensores
   add constraint FK_Medicoes_noname_Sensores foreign key (TipoSensor)
   references Sensores(ID)
   on delete restrict
   on update cascade
;

alter table Main.Alerta
   add constraint FK_Alertas_noname_Sensores foreign key (TipoSensor)
   references Sensores(ID)
   on delete restrict
   on update cascade
;

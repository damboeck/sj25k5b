show databases;
create database htl_1;
use htl_1;
show tables;
CREATE TABLE `htl_1`.`person` (`id` INT NOT NULL , `vorname` VARCHAR(40) NOT NULL , `nachname` VARCHAR(40) NOT NULL , `email` VARCHAR(40) NOT NULL , PRIMARY KEY (`id`), INDEX (`vorname`), INDEX (`nachname`)) ENGINE = InnoDB; 
describe person;
create database htl_betrieb;
use htl_betrieb;
show tables;

create table abteilung (id_abteilung int not null auto_increment, abt_name varchar(60) not null, 
primary key(id_abteilung), index(abt_name)); 
create table mitarbeiter (id_mitarbeiter int not null auto_increment, nachname varchar(40) not null, 
vorname varchar(40), gebdatum date, id_abteilung int, position varchar(60), 
primary key(id_mitarbeiter), index(nachname),
foreign key (id_abteilung) references abteilung(id_abteilung));
describe abteilung;
create table projekt (id_projekt int not null auto_increment, projekt_name varchar(60),
beschreibung text(1000), 
primary key (id_projekt), index (projekt_name));
create table arbeitet_an (id_mitarbeiter int, id_projekt int, 
taetigkeit varchar(40), prozAnzteil tinyint, 
primary key (id_mitarbeiter, id_projekt),
foreign key (id_mitarbeiter) references mitarbeiter(id_mitarbeiter),
foreign key (id_projekt) references projekt(id_projekt));

insert into abteilung (id_abteilung, abt_name) values (314,'Demoabteilung');
select * from abteilung where id_abteilung=100;
insert into abteilung (abt_name) values ('Elektrotechnik');
insert into abteilung (id_abteilung, abt_name) values (100,'Maschinenbaue');
update abteilung set abt_name='Maschinenbau' where id_abteilung=100;
select *  from abteilung;
update abteilung set id_abteilung=101 where id_abteilung=100;
describe mitarbeiter;
insert into mitarbeiter(id_mitarbeiter,nachname,vorname,gebdatum,id_abteilung,position) 
values (1000,'Damböck','Werner','1970-05-13',315,'Lehrer');
select * from mitarbeiter;
insert into mitarbeiter(nachname,vorname,gebdatum,id_abteilung,position) 
values ('Klammer','Franz','1961-04-22',101,'Skifahrer'),
('Müller','Peter','1967-02-22',101,'Skifahrer');
select * from mitarbeiter;
update mitarbeiter set id_abteilung=315;
insert into mitarbeiter(nachname,vorname,gebdatum,id_abteilung,position) 
values ('Huber','Markus','2002-03-14',101,'Schüler');
update abteilung set id_abteilung=100 where id_abteilung=314;

insert into projekt(projekt_name) values ('Seifenkistl');
insert into arbeitet_an(id_mitarbeiter,id_projekt,taetigkeit,prozAnzteil) 
values (1001,1,'Reifen',100);

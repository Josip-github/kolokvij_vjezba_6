drop database if exists kolokvij_vjezba_6;
create database kolokvij_vjezba_6;
use kolokvij_vjezba_6;

create table prijatelj(
	sifra int not null primary key auto_increment,
	haljina varchar(35),
	prstena int not null,
	introvertno bit,
	stilfrizura varchar(36) not null
);

create table brat(
	sifra int not null primary key auto_increment,
	nausnica int not null,
	treciputa datetime not null,
	narukvica int not null,
	hlace varchar(31),
	prijatelj int
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	prviputa datetime not null,
	kratkamajica varchar(39) not null,
	drugiputa datetime,
	maraka decimal(14,10)
);

create table prijatelj_ostavljena(
	sifra int not null primary key auto_increment,
	prijatelj int not null,
	ostavljena int not null
);

create table zena(
	sifra int not null primary key auto_increment,
	novcica decimal(14,8) not null,
	narukvica int not null,
	dukserica varchar(40) not null,
	haljina varchar(30),
	hlace varchar(32),
	brat int not null
);

create table decko(
	sifra int not null primary key auto_increment,
	prviputa datetime,
	modelnaocala varchar(41),
	nausnica int,
	zena int not null
);

create table svekrva(
	sifra int not null primary key auto_increment,
	hlace varchar(48) not null,
	suknja varchar(42) not null,
	ogrlica int not null,
	trciputa datetime not null,
	dukserica varchar(32) not null,
	narukvica int not null,
	punac int
);

create table punac(
	sifra int not null primary key auto_increment,
	ekstrovertno bit not null,
	suknja varchar(30) not null,
	majica varchar(44) not null,
	prviputa datetime not null
);

alter table decko add foreign key (zena) references zena(sifra);

alter table zena add foreign key (brat) references brat(sifra);

alter table brat add foreign key (prijatelj) references prijatelj(sifra);

alter table prijatelj_ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key (ostavljena) references ostavljena(sifra);

alter table svekrva add foreign key (punac) references punac(sifra);

#U tablice zena, brat i prijatelj_ostavljena unesite po 3 retka.
insert into prijatelj(prstena,stilfrizura)
values(10,'normalna'),(15,'čudna'),(17,'s gelom');

insert into brat(nausnica,treciputa,narukvica)
values(10,'2015-09-09',9),(8,'2016-08-09',7),(6,'2014-10-11',6);

insert into zena(novcica,narukvica,dukserica,brat)
values(99.99,8,'jesenska',1),(99.88,6,'proljetna',2),(44.99,2,'s kapuljačom',3);

insert into ostavljena(prviputa,kratkamajica)
values('2020-10-10','nike'),('1998-09-08','Adidas'),('2013-08-12','Puma');

insert into prijatelj_ostavljena(prijatelj,ostavljena)
values(1,1),(2,2),(3,3);

#U tablici svekrva postavite svim zapisima kolonu suknja na vrijednost Osijek.
update svekrva set suknja = 'Osijek';

#U tablici decko obrišite sve zapise čija je vrijednost kolone modelnaocala manje od AB.
delete from decko where modelnaocala < 'AB';

#Izlistajte narukvica iz tablice brat uz uvjet da vrijednost kolone treciputa nepoznate.
select narukvica from brat where treciputa is null;

/*Prikažite drugiputa iz tablice ostavljena, zena iz tablice decko te
narukvica iz tablice zena uz uvjet da su vrijednosti kolone treciputa iz
tablice brat poznate te da su vrijednosti kolone prstena iz tablice
prijatelj jednake broju 219. Podatke posložite po narukvica iz tablice
zena silazno.*/

#ostavljena, decko, zena, brat, prijatelj
select o.drugiputa , d.zena , z.narukvica 
from ostavljena o inner join prijatelj_ostavljena po on o.sifra = po.ostavljena 
inner join prijatelj p on p.sifra = po.prijatelj 
inner join brat b on p.sifra = b.prijatelj 
inner join zena z on b.sifra = z.brat 
inner join decko d on z.sifra = d.zena 
where b.treciputa is not null and p.prstena = 219;














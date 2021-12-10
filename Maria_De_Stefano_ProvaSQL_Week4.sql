create database NegozioDischi

create table Band(
IDBand INTEGER IDENTITY(1,1) NOT NULL,
NomeBand VARCHAR(40) NOT NULL,
NumeroDiComponenti INTEGER NOT NULL CHECK (NumerodiComponenti>0),
CONSTRAINT PK_BAND PRIMARY KEY(IDBand),
);

create table Brano(
IDBrano INTEGER IDENTITY(1,1) NOT NULL,
Titolo VARCHAR(30) NOT NULL,
Durata INTEGER NOT NULL CHECK (Durata>0),
CONSTRAINT PK_BRANO PRIMARY KEY (IDBrano),
);

create table Album(
IDAlbum INTEGER IDENTITY(1,1),
BandID INT NOT NULL,
Titolo VARCHAR(30),
AnnodiUscita INTEGER NOT NULL,
CasaDiscografica VARCHAR(30),
Genere VARCHAR(20),
SupportoDiDistribuzione VARCHAR(10),
CONSTRAINT PK_ALBUM PRIMARY KEY (IDAlbum),
CONSTRAINT UC_ALBUM UNIQUE (Titolo, AnnodiUscita, CasaDiscografica, Genere, SupportoDiDistribuzione, BandID),
CONSTRAINT FK_1 FOREIGN KEY (BandID) references Band(IDBand),
CONSTRAINT CHK_GENERE CHECK (Genere='Classico' or Genere='Jazz' or Genere='Pop' or Genere='Rock' or Genere='Metal'),
CONSTRAINT CHK_SUPPORTO CHECK (SupportoDiDistribuzione='CD'or SupportoDiDistribuzione='Vinile' or SupportoDiDistribuzione='Streaming')
);


create table BranoAlbum(
IDBrano INT NOT NULL FOREIGN KEY REFERENCES Brano(IDBrano),
IDAlbum INT NOT NULL FOREIGN KEY REFERENCES Album(IDAlbum),
CONSTRAINT PK_BRANOALBUM PRIMARY KEY (IDBrano, IDAlbum),
);


--inserimento dati
insert into Band values ('883', '5');
insert into Band values ('Maneskin', '4');
insert into Band values ('TheGiornalisti', '3');
select * from Band;

delete from Band 
where IDBand='4'

delete from Band 
where IDBand='5'

delete from Band
where IDBand='6'


insert into Album values (1,'Hanno ucciso l''uomo ragno', '1992', 'Fri Records', 'Pop', 'CD');
insert into Album values (1,'Nord Sud Ovest Est', '1993', 'Fri Records', 'Pop', 'CD');
insert into Album values (1,'La donna e il sogno', '1995', 'Fri Records', 'Pop', 'CD');
insert into Album values (1,'La dura legge del gol!', '1997', 'Fri Records', 'Pop', 'CD');
insert into Album values (1,'Uno in più', '2001', 'Wea International', 'Pop', 'CD');
select * from Album;

delete from Album
where IDAlbum=1;

insert into Brano values ('Zitti e buoni', '211');
insert into Brano values ('Coraline', '300');
insert into Brano values ('Torna a casa', '250');
insert into Brano values ('Riccione', '180');
insert into Brano values ('Love', '229');
insert into Brano values ('Milano Roma', '250');
insert into Brano values ('Overture', '160');
select * from Brano

insert into BranoAlbum values (4,3);
insert into BranoAlbum values (5,3);
insert into BranoAlbum values (6,3);

--1. Mostrare tutti gli album degli 883 in ordine alfabetico
select a.*
from Album a 
order by Titolo;

--2. Selezionare tutti gli album della casa discografica  Sony Music relativi all'anno 2020
select a.*
from Album a 
where CasaDiscografica='Sony Music'
and AnnodiUscita='2020';

--3. Selezionare tutti i titoli delle canzoni dei “Maneskin” appartenenti ad album pubblicati prima del 2019
select b.Titolo
from Brano b, Band ba, Album a
where NomeBand='Maneskin' and AnnodiUscita<'2019';

--4. Individuare tutti gli album in cui è contenuta la canzone “Imagine”

select a.*
from Album a join Brano b on b.IDBrano=a.IDAlbum
where b.Titolo='Imagine';

--5. Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”
select a.Titolo, COUNT(ba.NomeBand) as 'Numero Totale Canzoni del group the Giornalisti'
from Brano b
join BranoAlbum ab on b.IDBrano=ab.IDBrano
join Album a on ab.IDAlbum=a.IDAlbum
join Band ba on ba.IDBand=a.BandID
where ba.NomeBand='The Giornalisti'
group by ba.NomeBand;


--6. Contare per ogni album, la “durata totale” cioè la somma dei secondi dei suoi brani
select a.Titolo, sum(b.Durata) as 'Duarata totale Album'
from Brano b
join BranoAlbum ab on ab.IDBrano=b.IdBrano
join Album a on a.IDAlbum=ab.IDAlbum
group by a.Titolo


--7. Mostrare i brani (distinti) degli “883” che durano più di 3 minuti (in alternativa usare i  secondi quindi 180 s).
 


--Esercitazione Teorica
/*
1) c 
2) se l'associazione è N a N, si aggiunge una terza tabella, che contiene le chiavi delle altre
due tabelle (ed eventuali attributi riferiti a quella relazione)
3) b:DML
4) a
5)no
/*
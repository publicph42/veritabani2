use TEKRAR;

create table Departmanlar(
DepartmanID int primary key,
DepartmanAd varchar(100) not null unique,
Bina varchar(50) not null);

create table Unvanlar(
UnvanID int primary key not null,
UnvanAd varchar(100) not null,
TabanMaas decimal(10,2) not null,
TavanMaas decimal(10,2) not null);

create table Calisanlar(
CalisanID int primary key,
Ad varchar(100) not null,
Soyad varchar(100) not null,
Eposta varchar(100) not null unique,
IseGirisTarihi date not null,
Maas decimal(10,2) not null,
DepartmanID int not null,
UnvanID int not null,
YoneticiID int);

create table Projeler(
ProjeID int primary key,
ProjeAD varchar(100) not null,
Butce decimal(12,2) not null,
BaslangicTarihi date not null,
BitisTarihi date null,
DepartmanID int not null);

create table ProjeGorevlendirmeleri(
GorevlendirmeID int primary key,
ProjeID int not null,
CalisanID int not null,
HaftalikSaat int not null check (HaftalikSaat>0),
GorevTarihi date not null,
constraint UQ_Proje_Calisan unique (ProjeID, CalisanID));

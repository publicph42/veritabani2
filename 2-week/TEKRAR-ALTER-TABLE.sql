use TEKRAR;

alter table Calisanlar
add constraint FK_Calisan_Departman
foreign key (DepartmanID) references Departmanlar(DepartmanID);

alter table Calisanlar add constraint FK_Calisan_Unvan
foreign key (UnvanID) references Unvanlar(UnvanID);

alter table Projeler add constraint FK_Proje_Departman
foreign key (DepartmanID) references Departmanlar(DepartmanID);

alter table ProjeGorevlendirmeleri add constraint FK_Gorev_Proje
foreign key (ProjeID) references Projeler(ProjeID);

alter table ProjeGorevlendirmeleri add constraint FK_Gorev_Calisan
foreign key (CalisanID) references Calisanlar(CalisanID);

alter table Calisanlar add constraint FK_Calisan_Yonetici
foreign key (YoneticiID) references Calisanlar(CalisanID);
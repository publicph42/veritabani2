use TEKRAR;

insert into Departmanlar (DepartmanID, DepartmanAd, Bina) values
(1, 'Yazilim', 'A binasi'),
(2, 'Donanim', 'A binasi'),
(3, 'Pazarlama', 'B binasi'),
(4, 'Insan Kaynaklari', 'B binasi'),
(5, 'Ar-Ge', 'C binasi');

insert into Unvanlar(UnvanID , UnvanAd, TabanMaas, TavanMaas) 
values
(1, 'Yazilim Mimari', 75000.00, 120000.00),
(2, 'Kidemli Gelistirici', 55000.00, 800000.00),
(3, 'Sistem Mimari', 50000.00, 750000.00),
(4, 'Pazarlama Uzmani', 35000.00, 550000.00),
(5, 'IK Uzmani', 30000.00, 480000.00);


insert into Calisanlar(CalisanID, Ad, Soyad, Eposta, IseGirisTarihi, Maas, 
DepartmanID, UnvanID, YoneticiID) values
(101, 'Ahmet', 'Yilmaz', 'ahmet.yilmaz@sirket.com', '2021-03-15', 95000.00, 1, 1, null),
(102, 'Selin', 'Kaya', 'selin.kaya@sirket.com', '2021-06-01', 72000.00, 2, 3, null),
(103, 'Mehmet', 'Demir', 'mehmet.demir@sirket.com', '2022-09-10', 68000.00, 1, 2, 101),
(104, 'Ayse', 'Celik', 'ayse.celik@sirket.com', '2023-01-20', 42000.00, 3, 4, 101),
(105, 'Burak', 'Ozturk', 'burak.ozturk@sirket.com', '2023-11-05', 36000.00, 4, 5, 102);

insert into Projeler(ProjeID, ProjeAD, Butce, BaslangicTarihi, BitisTarihi, DepartmanID) values
(201, 'Bulut Donusum Platformu', 850000.00, '2023-01-01', null, 1),
(202, 'IoT Sensor Agi', 450000.00, '2023-04-15', '2023-12-31', 2),
(203, 'Yeni Nesil Moil Bankacilik', 1200000.00, '2023-08-01', null, 1),
(204, 'Global Marka Kampanyasi', 300000.00, '2023-09-01', '2024-03-01', 3),
(205, 'Otonom RObotik Kontrol', 950000.00, '2024-02-01', null, 5);

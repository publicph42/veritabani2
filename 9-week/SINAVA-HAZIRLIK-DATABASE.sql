-- BÖLÜM 1: BCNF Uyumlu Veritabanı ve Örnek Veri Scripti

-- 1. Veritabanını Oluşturma
IF DB_ID('UniversiteTeknolojiDB') IS NOT NULL
BEGIN
    ALTER DATABASE UniversiteTeknolojiDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE UniversiteTeknolojiDB;
END
GO

CREATE DATABASE UniversiteTeknolojiDB;
GO

USE UniversiteTeknolojiDB;
GO

-- 2. Tablo Tanımları (BCNF)

-- A. Kategoriler Tablosu
CREATE TABLE Kategoriler (
    KategoriID INT PRIMARY KEY IDENTITY(1,1),
    KategoriAdi NVARCHAR(50) NOT NULL UNIQUE
);

-- B. Tedarikciler Tablosu
CREATE TABLE Tedarikciler (
    TedarikciID INT PRIMARY KEY IDENTITY(1,1),
    SirketAdi NVARCHAR(100) NOT NULL,
    YetkiliKisi NVARCHAR(100) NOT NULL,
    Telefon VARCHAR(20) NOT NULL,
    Sehir NVARCHAR(50) NOT NULL
);

-- C. Departmanlar Tablosu
CREATE TABLE Departmanlar (
    DepartmanID INT PRIMARY KEY IDENTITY(1,1),
    DepartmanAdi NVARCHAR(50) NOT NULL UNIQUE
);

-- D. Personeller Tablosu (Self-Join desteği ile BCNF uyumlu)
CREATE TABLE Personeller (
    PersonelID INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    DepartmanID INT NOT NULL FOREIGN KEY REFERENCES Departmanlar(DepartmanID),
    YoneticiID INT NULL FOREIGN KEY REFERENCES Personeller(PersonelID),
    IseGirisTarihi DATE NOT NULL,
    Maas DECIMAL(10,2) NOT NULL
);

-- E. Musteriler Tablosu
CREATE TABLE Musteriler (
    MusteriID INT PRIMARY KEY IDENTITY(1,1),
    MusteriAdi NVARCHAR(50) NOT NULL,
    MusteriSoyadi NVARCHAR(50) NOT NULL,
    Eposta VARCHAR(100) NOT NULL UNIQUE,
    Sehir NVARCHAR(50) NOT NULL,
    Bakiye DECIMAL(12,2) DEFAULT 0.00
);

-- F. Urunler Tablosu
CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY IDENTITY(1,1),
    UrunAdi NVARCHAR(100) NOT NULL,
    KategoriID INT NOT NULL FOREIGN KEY REFERENCES Kategoriler(KategoriID),
    TedarikciID INT NOT NULL FOREIGN KEY REFERENCES Tedarikciler(TedarikciID),
    BirimFiyat DECIMAL(10,2) NOT NULL CHECK (BirimFiyat >= 0),
    StokMiktari INT NOT NULL CHECK (StokMiktari >= 0),
    AktifMi BIT DEFAULT 1
);

-- G. Siparisler Tablosu
CREATE TABLE Siparisler (
    SiparisID INT PRIMARY KEY IDENTITY(1,1),
    MusteriID INT NOT NULL FOREIGN KEY REFERENCES Musteriler(MusteriID),
    PersonelID INT NOT NULL FOREIGN KEY REFERENCES Personeller(PersonelID),
    SiparisTarihi DATETIME DEFAULT GETDATE(),
    KargoUcreti DECIMAL(8,2) DEFAULT 0.00
);

-- H. SiparisDetay Tablosu (Kompozit Primary Key)
CREATE TABLE SiparisDetay (
    SiparisID INT NOT NULL FOREIGN KEY REFERENCES Siparisler(SiparisID),
    UrunID INT NOT NULL FOREIGN KEY REFERENCES Urunler(UrunID),
    Adet INT NOT NULL CHECK (Adet > 0),
    BirimFiyat DECIMAL(10,2) NOT NULL CHECK (BirimFiyat >= 0),
    PRIMARY KEY (SiparisID, UrunID)
);
GO

-- 3. Örnek Veri Girişi Scripti

-- Kategoriler (4 Kayıt)
INSERT INTO Kategoriler (KategoriAdi) VALUES 
(N'Bilgisayar & Tablet'),
(N'Akıllı Telefon'),
(N'Çevre Birimleri'),
(N'Depolama & Bellek');

-- Tedarikciler (4 Kayıt)
INSERT INTO Tedarikciler (SirketAdi, YetkiliKisi, Telefon, Sehir) VALUES 
(N'TeknoDağıtım A.Ş.', N'Ahmet Yılmaz', '02124567890', N'İstanbul'),
(N'Ege Bilişim Ltd.', N'Mehmet Kaya', '02321234567', N'İzmir'),
(N'Karadeniz Depo', N'Mustafa Çelik', '04529998877', N'Ordu'),
(N'Başkent Lojistik', N'Ayşe Demir', '03125554433', N'Ankara');

-- Departmanlar (4 Kayıt)
INSERT INTO Departmanlar (DepartmanAdi) VALUES 
(N'Yönetim'),
(N'Satış & Pazarlama'),
(N'Bilgi İşlem'),
(N'Müşteri Hizmetleri');

-- Personeller (6 Kayıt - Self-Join Test Verisi)
INSERT INTO Personeller (Ad, Soyad, DepartmanID, YoneticiID, IseGirisTarihi, Maas) VALUES 
(N'Furkan', N'Akın', 1, NULL, '2020-01-15', 85000.00), -- Genel Müdür (1)
(N'Kemal', N'Sunal', 2, 1, '2021-03-10', 48000.00),     -- Satış Müdürü (2)
(N'Şener', N'Şen', 2, 2, '2022-06-01', 35000.00),       -- Satış Temsilcisi (3)
(N'Halit', N'Akçatepe', 3, 1, '2021-08-15', 52000.00),  -- IT Müdürü (4)
(N'Münir', N'Özkul', 3, 4, '2023-02-20', 38000.00),     -- Sistem Uzmanı (5)
(N'Adile', N'Naşit', 4, 1, '2022-11-05', 36000.00);     -- Destek Uzmanı (6)

-- Musteriler (6 Kayıt - 1 Tanesi Hiç Sipariş Vermeyecek)
INSERT INTO Musteriler (MusteriAdi, MusteriSoyadi, Eposta, Sehir, Bakiye) VALUES 
(N'Ali', N'Vural', 'ali.vural@gmail.com', N'İstanbul', 1500.00),
(N'Zeynep', N'Güneş', 'zeynep.gunes@hotmail.com', N'Ordu', 250.00),
(N'Burak', N'Öztürk', 'burak.ozturk@yahoo.com', N'Samsun', 0.00),
(N'Elif', N'Boran', 'elif.boran@outlook.com', N'Ankara', 3200.00),
(N'Emre', N'Koç', 'emre.koc@gmail.com', N'İzmir', 500.00),
(N'Hakan', N'Sessiz', 'hakan.sessiz@mail.com', N'Trabzon', 0.00); -- Siparişsiz müşteri

-- Urunler (7 Kayıt - 1 Tanesi Hiç Satılmamış ve Kritik Stoklu)
INSERT INTO Urunler (UrunAdi, KategoriID, TedarikciID, BirimFiyat, StokMiktari, AktifMi) VALUES 
(N'ThinkPad L14 Dizüstü', 1, 1, 38000.00, 20, 1),
(N'MacBook Air M2', 1, 1, 46000.00, 12, 1),
(N'Galaxy S24 Ultra', 2, 2, 62000.00, 15, 1),
(N'Redmi Note 13', 2, 2, 14000.00, 30, 1),
(N'Logitech MX Master 3S', 3, 3, 4200.00, 45, 1),
(N'Samsung 990 Pro 2TB SSD', 4, 3, 6800.00, 2, 1), -- Kritik Stok
(N'Eski Nesil USB Hub', 3, 4, 350.00, 0, 0);       -- Pasif ve Satılmamış Ürün

-- Siparisler (5 Kayıt)
INSERT INTO Siparisler (MusteriID, PersonelID, SiparisTarihi, KargoUcreti) VALUES 
(1, 2, '2026-01-10 10:30:00', 50.00),
(2, 3, '2026-01-12 14:15:00', 0.00),
(3, 2, '2026-02-01 09:00:00', 75.00),
(1, 3, '2026-02-15 16:45:00', 0.00),
(4, 2, '2026-03-01 11:20:00', 100.00);

-- SiparisDetay (9 Satır)
INSERT INTO SiparisDetay (SiparisID, UrunID, Adet, BirimFiyat) VALUES 
(1, 1, 1, 38000.00),
(1, 5, 2, 4200.00),
(2, 3, 1, 62000.00),
(3, 4, 2, 14000.00),
(3, 6, 1, 6800.00),
(4, 2, 1, 46000.00),
(4, 5, 1, 4200.00),
(5, 1, 2, 38000.00),
(5, 5, 3, 4200.00);
GO
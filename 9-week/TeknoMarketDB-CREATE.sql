-- Eğer varsa eski veritabanını silip sıfırdan oluşturma (İsteğe bağlı)
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'TeknoMarketDB')
BEGIN
    ALTER DATABASE TeknoMarketDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TeknoMarketDB;
END
GO

-- 1. Veritabanını Oluştur
CREATE DATABASE TeknoMarketDB;
GO
USE TeknoMarketDB;
GO

-- 2. Kategoriler Tablosu
CREATE TABLE Kategoriler (
    KategoriID INT PRIMARY KEY IDENTITY(1,1),
    KategoriAdi NVARCHAR(50) NOT NULL
);

-- 3. Urunler Tablosu
CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY IDENTITY(1,1),
    UrunAdi NVARCHAR(100) NOT NULL,
    KategoriID INT FOREIGN KEY REFERENCES Kategoriler(KategoriID),
    BirimFiyat DECIMAL(18,2) NOT NULL,
    StokMiktari INT NOT NULL,
    AktifMi BIT DEFAULT 1
);

-- 4. Satislar Tablosu
CREATE TABLE Satislar (
    SatisID INT PRIMARY KEY IDENTITY(1,1),
    UrunID INT FOREIGN KEY REFERENCES Urunler(UrunID),
    Adet INT NOT NULL,
    SatisFiyati DECIMAL(18,2) NOT NULL,
    SatisTarihi DATETIME DEFAULT GETDATE()
);
GO

-- 5. Örnek Verilerin Eklenmesi
INSERT INTO Kategoriler (KategoriAdi) VALUES 
(N'Bilgisayar'), (N'Telefon'), (N'Çevre Birimleri'), (N'Depolama');

INSERT INTO Urunler (UrunAdi, KategoriID, BirimFiyat, StokMiktari) VALUES 
(N'Dizüstü Bilgisayar Pro', 1, 45000.00, 15),
(N'Oyuncu Bilgisayarı X', 1, 60000.00, 8),
(N'Akıllı Telefon S24', 2, 38000.00, 25),
(N'Mekanik Klavye RGB', 3, 2500.00, 50),
(N'Kablosuz Mouse', 3, 1200.00, 3), -- Kritik stok!
(N'1TB NVMe M.2 SSD', 4, 3200.00, 40);

INSERT INTO Satislar (UrunID, Adet, SatisFiyati) VALUES 
(1, 2, 45000.00),
(3, 1, 38000.00),
(4, 5, 2500.00),
(1, 1, 45000.00);
GO
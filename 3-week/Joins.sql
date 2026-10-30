create database joinler;
CREATE TABLE Departmanlar (
    DepartmanID INT PRIMARY KEY IDENTITY(1,1),
    DepartmanAdi NVARCHAR(50) NOT NULL
);

CREATE TABLE Calisanlar (
    CalisanID INT PRIMARY KEY IDENTITY(1,1),
    AdSoyad NVARCHAR(50) NOT NULL,
    Maas DECIMAL(10,2) NOT NULL,
    DepartmanID INT NULL,
    CONSTRAINT FK_Calisan_Departman FOREIGN KEY (DepartmanID) 
        REFERENCES Departmanlar(DepartmanID)
);

-- 2. Departman Verileri (6 Kayýt)
INSERT INTO Departmanlar (DepartmanAdi) VALUES 
('Yazýlým'),          -- ID: 1
('Ýnsan Kaynaklarý'), -- ID: 2
('Pazarlama'),        -- ID: 3
('Finans'),           -- ID: 4
('Ar-Ge'),            -- ID: 5 (Çalýþansýz Departman)
('Lojistik');         -- ID: 6 (Çalýþansýz Departman)

-- 3. Çalýþan Verileri (26 Kayýt - Toplamda 32 Kayýt)
INSERT INTO Calisanlar (AdSoyad, Maas, DepartmanID) VALUES
('Ahmet Yýlmaz', 45000, 1),
('Mehmet Kaya', 42000, 1),
('Ayþe Demir', 48000, 1),
('Caner Erkin', 39000, 1),
('Burak Yýlmaz', 51000, 1),
('Zeynep Çelik', 35000, 2),
('Fatma Þahin', 38000, 2),
('Emre Aksoy', 36000, 2),
('Deniz Aydýn', 34000, 2),
('Mustafa Koç', 41000, 3),
('Selin Öztürk', 43000, 3),
('Murat Arslan', 39500, 3),
('Gökhan Tepe', 46000, 4),
('Büþra Kara', 47500, 4),
('Serkan Çetin', 44000, 4),
('Cemre Solmaz', 42500, 4),
('Oðuzhan Uður', 49000, 1),
('Ali Rýza', 37000, 2),
('Ece Erken', 40000, 3),
('Tolga Sarýtaþ', 52000, 1),
('Hande Erçel', 33000, 2),
-- Departmaný henüz atanmamýþ çalýþanlar (DepartmanID = NULL):
('Berk Oktay', 31000, NULL),
('Melis Sezen', 32000, NULL),
('Kerem Bürsin', 55000, NULL),
('Hazal Kaya', 41000, NULL),
('Çaðatay Ulusoy', 53000, NULL);

--INNER JOIN: AnB

SELECT c.AdSoyad, c.Maas, c.DepartmanID
FROM Calisanlar c
INNER JOIN Departmanlar d ON 
c.DepartmanID= d.DepartmanID

--LEFT (OUTER) JOIN A

SELECT d.DepartmanID, c.CalisanID, c.AdSoyad
FROM Departmanlar d
LEFT JOIN  Calisanlar c ON
d.DepartmanID=c.DepartmanID

SELECT c.CalisanID, d.DepartmanID, d.DepartmanAdi
FROM Calisanlar c
LEFT JOIN  Departmanlar d ON
d.DepartmanID=c.DepartmanID

--RIGHT (OUTER) JOIN B

SELECT d.DepartmanID, c.CalisanID, c.AdSoyad
FROM Departmanlar d
RIGHT JOIN  Calisanlar c ON
d.DepartmanID=c.DepartmanID

--FULL (OUTER) JOIN AUB

SELECT d.DepartmanID, c.AdSoyad
FROM Departmanlar d
FULL OUTER JOIN Calisanlar c ON
d.DepartmanID=c.DepartmanID

SELECT d.DepartmanID, c.AdSoyad
FROM Calisanlar c
FULL OUTER JOIN Departmanlar d ON
d.DepartmanID=c.DepartmanID

-- LEFT EXCLUDING JOIN A\B
SELECT d.DepartmanID
FROM Departmanlar d
LEFT JOIN Calisanlar c ON
d.DepartmanID=c.DepartmanID
WHERE c.CalisanID IS NULL

-- RIGHT EXCLUDING JOIN A\B
SELECT c.AdSoyad, c.Maas
FROM Departmanlar d
RIGHT JOIN Calisanlar c ON
d.DepartmanID=c.DepartmanID
WHERE d.DepartmanID IS NULL

-- FULL OUTER EXCLUDING JOIN
SELECT d.DepartmanID, c.AdSoyad
FROM Departmanlar d
FULL OUTER JOIN Calisanlar c ON
d.DepartmanID=c.DepartmanID
WHERE c.CalisanID IS NULL
OR
d.DepartmanID IS NULL

-- CROSS JOIN
SELECT d.DepartmanID, c.AdSoyad
FROM Departmanlar d
CROSS JOIN Calisanlar c


-- --------------

-- 1. Projeler Tablosu (Küme C)
CREATE TABLE Projeler (
    ProjeID INT PRIMARY KEY IDENTITY(1,1),
    ProjeAdi NVARCHAR(50) NOT NULL,
    Butce DECIMAL(12,2) NOT NULL
);

-- 2. Ýliþki (Mapping) Tablosu (B ile C arasýndaki bað)
CREATE TABLE CalisanProjeleri (
    CalisanID INT NOT NULL,
    ProjeID INT NOT NULL,
    PRIMARY KEY (CalisanID, ProjeID),
    CONSTRAINT FK_CP_Calisan FOREIGN KEY (CalisanID) REFERENCES Calisanlar(CalisanID),
    CONSTRAINT FK_CP_Proje FOREIGN KEY (ProjeID) REFERENCES Projeler(ProjeID)
);

-- 3. Proje Verileri (6 Proje)
INSERT INTO Projeler (ProjeAdi, Butce) VALUES
('Mobil Uygulama', 250000),      -- ID: 1
('ERP Dönüþümü', 500000),        -- ID: 2
('Yapay Zeka Ar-Ge', 750000),    -- ID: 3
('Bordro Otomasyonu', 120000),   -- ID: 4
('Yeni Kampanya', 180000),       -- ID: 5
('Otonom Drone', 900000);        -- ID: 6 (Henüz kimsenin atanmadýðý proje)

-- 4. Çalýþan - Proje Eþleþtirmeleri
-- Not: Bazý departmanlý çalýþanlar, bazý departmansýz çalýþanlar projelere atanmýþtýr.
INSERT INTO CalisanProjeleri (CalisanID, ProjeID) VALUES
(1, 1),  -- Ahmet Yýlmaz (Yazýlým Dept) -> Mobil Uygulama
(2, 1),  -- Mehmet Kaya (Yazýlým Dept) -> Mobil Uygulama
(3, 2),  -- Ayþe Demir (Yazýlým Dept) -> ERP Dönüþümü
(5, 3),  -- Burak Yýlmaz (Yazýlým Dept) -> Yapay Zeka Ar-Ge
(6, 4),  -- Zeynep Çelik (ÝK Dept) -> Bordro Otomasyonu
(10, 5), -- Mustafa Koç (Pazarlama Dept) -> Yeni Kampanya
(22, 1), -- Berk Oktay (Departmaný NULL) -> Mobil Uygulama
(23, 2); -- Melis Sezen (Departmaný NULL) -> ERP Dönüþümü

-- INNER JOIN

SELECT d.DepartmanID, c.AdSoyad,c.CalisanID, p.ProjeAdi, p.ProjeID
FROM Calisanlar c
INNER JOIN Departmanlar d ON c.DepartmanID=d.DepartmanID
INNER JOIN CalisanProjeleri cp ON c.CalisanID=cp.CalisanID
INNER JOIN Projeler p ON cp.ProjeID=p.ProjeID

-- FULL OUTER JOIN
SELECT d.DepartmanID, c.AdSoyad,c.CalisanID, p.ProjeAdi, p.ProjeID
FROM Departmanlar d
FULL OUTER JOIN Calisanlar c ON c.DepartmanID=d.DepartmanID
FULL OUTER JOIN CalisanProjeleri cp ON c.CalisanID=cp.CalisanID
FULL OUTER JOIN Projeler p ON cp.ProjeID=p.ProjeID

-- Departmaný olup Projesi olmayan Çalýþanlar

SELECT d.DepartmanID, c.CalisanID, c.AdSoyad
FROM Calisanlar c
INNER JOIN Departmanlar d ON c.DepartmanID=d.DepartmanID
LEFT JOIN CalisanProjeleri cp ON c.CalisanID=cp.CalisanID
WHERE cp.ProjeID IS NULL

-- Projesi olup Departmaný olmayan çalýþanlar

SELECT p.ProjeAdi, c.CalisanID, c.AdSoyad
FROM Calisanlar c 
INNER JOIN CalisanProjeleri cp ON c.CalisanID=cp.CalisanID
INNER JOIN Projeler p ON p.ProjeID=cp.ProjeID
LEFT JOIN Departmanlar d ON c.DepartmanID=d.DepartmanID
WHERE d.DepartmanID IS NULL
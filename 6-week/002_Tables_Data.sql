
-- 1. LOKASYONLAR TABLOSU (4 Kayıt)
CREATE TABLE Lokasyonlar (
    lokasyon_id INT PRIMARY KEY,
    sehir VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Lokasyonlar VALUES 
(1, 'İstanbul'), 
(2, 'Ankara'), 
(3, 'İzmir'), 
(4, 'Bursa'); -- Bursa'da hiç departman olmayacak (Sağ/Sol dış birleştirme testi için)

-- 2. DEPARTMANLAR TABLOSU (5 Kayıt)
CREATE TABLE Departmanlar (
    dep_id INT PRIMARY KEY,
    dep_adi VARCHAR(50) NOT NULL UNIQUE,
    lokasyon_id INT NULL, -- Uzaktan çalışan departmanlar için NULL olabilir
    FOREIGN KEY (lokasyon_id) REFERENCES Lokasyonlar(lokasyon_id)
);

INSERT INTO Departmanlar VALUES 
(10, 'Yazılım', 1),
(20, 'İK', 2),
(30, 'Finans', 1),
(40, 'Ar-Ge', 3),     -- Ar-Ge'de hiç personel ve proje olmayacak
(50, 'Pazarlama', NULL); -- Lokasyonu belli olmayan (Remote) departman

-- 3. PERSONELLER TABLOSU (6 Kayıt)
CREATE TABLE Personeller (
    per_id INT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    dep_id INT NULL,      -- Henüz departmanı atanmamış personel olabilir
    yonetici_id INT NULL, -- Self-Join için kendi tablosuna referans
    maas DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (dep_id) REFERENCES Departmanlar(dep_id),
    FOREIGN KEY (yonetici_id) REFERENCES Personeller(per_id)
);

INSERT INTO Personeller VALUES 
(101, 'Ahmet', 10, NULL, 90000),  -- Genel Müdür / Yazılım Lideri
(102, 'Mehmet', 10, 101, 65000),  -- Yazılım
(103, 'Ayşe', 20, 101, 55000),    -- İK
(104, 'Fatma', 30, 103, 60000),   -- Finans
(105, 'Can', NULL, 101, 40000),   -- Stajyer / Oryantasyonda (Departmanı NULL!)
(106, 'Zeynep', NULL, NULL, 75000); -- Dış Danışman (Departmanı ve Yöneticisi NULL!)

-- 4. PROJELER TABLOSU (3 Kayıt)
CREATE TABLE Projeler (
    proje_id INT PRIMARY KEY,
    proje_adi VARCHAR(50) NOT NULL UNIQUE,
    dep_id INT NULL, -- Departmandan bağımsız şirket içi projeler için NULL olabilir
    butce DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (dep_id) REFERENCES Departmanlar(dep_id)
);

INSERT INTO Projeler VALUES 
(1001, 'E-Ticaret', 10, 500000),
(1002, 'ERP Geçiş', 10, 300000),
(1003, 'İşe Alım Portalı', 20, 150000),
(1004, 'Yapay Zeka', NULL, 400000)
-- Not: 4 kayıt olması için 1 tane de departmansız proje ekleyelim (Sayı farklılığı için 3'te de kalabilir ama 7 tablo farklı sayılar: 4, 5, 6, 3, 7, 2, 8 yapalım!)
-- Projeler tablosunu 3 kayıtta bırakıyoruz: (1001, 1002, 1003).

-- 5. PERSONEL_PROJELER TABLOSU (7 Kayıt - N:M Çözümleme Tablosu)
CREATE TABLE Personel_Projeler (
    per_id INT,
    proje_id INT,
    rol VARCHAR(50) NOT NULL,
    haftalik_saat INT NOT NULL,
    PRIMARY KEY (per_id, proje_id), -- BCNF: Rol ve saat, (per_id, proje_id) ikilisine tam bağımlıdır
    FOREIGN KEY (per_id) REFERENCES Personeller(per_id),
    FOREIGN KEY (proje_id) REFERENCES Projeler(proje_id)
);

INSERT INTO Personel_Projeler VALUES 
(101, 1001, 'Mimari Lider', 20),
(101, 1002, 'Danışman', 10),
(102, 1001, 'Kıdemli Geliştirici', 40),
(102, 1002, 'Geliştirici', 20),
(103, 1003, 'Proje Yöneticisi', 30),
(105, 1001, 'Test Uzmanı', 25), -- Dikkat: Can'ın departmanı NULL ama projede çalışıyor!
(104, 1002, 'Bütçe Analisti', 15);

-- 6. MUSTERILER TABLOSU (2 Kayıt)
CREATE TABLE Musteriler (
    musteri_id INT PRIMARY KEY,
    musteri_adi VARCHAR(100) NOT NULL UNIQUE,
    sektor VARCHAR(50) NOT NULL
);

INSERT INTO Musteriler VALUES 
(501, 'Global Finans A.Ş.', 'Bankacılık'),
(502, 'Mega Perakende Ltd.', 'Perakende');

-- 7. FATURALAR TABLOSU (8 Kayıt)
CREATE TABLE Faturalar (
    fatura_id INT PRIMARY KEY,
    proje_id INT NOT NULL,
    musteri_id INT NULL, -- İç projelerde müşteri NULL olabilir
    tutar DECIMAL(12,2) NOT NULL,
    odendi_mi BIT NOT NULL,
    FOREIGN KEY (proje_id) REFERENCES Projeler(proje_id),
    FOREIGN KEY (musteri_id) REFERENCES Musteriler(musteri_id)
);

INSERT INTO Faturalar VALUES 
(9001, 1001, 502, 100000, 1),
(9002, 1001, 502, 150000, 1),
(9003, 1001, 502, 250000, 0),
(9004, 1002, 501, 120000, 1),
(9005, 1002, 501, 180000, 0),
(9006, 1003, NULL, 50000, 1),
(9007, 1003, NULL, 50000, 1),
(9008, 1003, NULL, 50000, 0);
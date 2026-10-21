CREATE joinornek;
USE joinornek;

-- 1. Tabloları Oluşturma ve İlişkilendirme
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

-- 2. Departman Verileri (6 Kayıt)
INSERT INTO Departmanlar (DepartmanAdi) VALUES 
('Yazılım'),          -- ID: 1
('İnsan Kaynakları'), -- ID: 2
('Pazarlama'),        -- ID: 3
('Finans'),           -- ID: 4
('Ar-Ge'),            -- ID: 5 (Çalışansız Departman)
('Lojistik');         -- ID: 6 (Çalışansız Departman)

-- 3. Çalışan Verileri (26 Kayıt - Toplamda 32 Kayıt)
INSERT INTO Calisanlar (AdSoyad, Maas, DepartmanID) VALUES
('Ahmet Yılmaz', 45000, 1),
('Mehmet Kaya', 42000, 1),
('Ayşe Demir', 48000, 1),
('Caner Erkin', 39000, 1),
('Burak Yılmaz', 51000, 1),
('Zeynep Çelik', 35000, 2),
('Fatma Şahin', 38000, 2),
('Emre Aksoy', 36000, 2),
('Deniz Aydın', 34000, 2),
('Mustafa Koç', 41000, 3),
('Selin Öztürk', 43000, 3),
('Murat Arslan', 39500, 3),
('Gökhan Tepe', 46000, 4),
('Büşra Kara', 47500, 4),
('Serkan Çetin', 44000, 4),
('Cemre Solmaz', 42500, 4),
('Oğuzhan Uğur', 49000, 1),
('Ali Rıza', 37000, 2),
('Ece Erken', 40000, 3),
('Tolga Sarıtaş', 52000, 1),
('Hande Erçel', 33000, 2),
-- Departmanı henüz atanmamış çalışanlar (DepartmanID = NULL):
('Berk Oktay', 31000, NULL),
('Melis Sezen', 32000, NULL),
('Kerem Bürsin', 55000, NULL),
('Hazal Kaya', 41000, NULL),
('Çağatay Ulusoy', 53000, NULL);

-- -----

-- 1. Projeler Tablosu (Küme C)
CREATE TABLE Projeler (
    ProjeID INT PRIMARY KEY IDENTITY(1,1),
    ProjeAdi NVARCHAR(50) NOT NULL,
    Butce DECIMAL(12,2) NOT NULL
);

-- 2. İlişki (Mapping) Tablosu (B ile C arasındaki bağ)
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
('ERP Dönüşümü', 500000),        -- ID: 2
('Yapay Zeka Ar-Ge', 750000),    -- ID: 3
('Bordro Otomasyonu', 120000),   -- ID: 4
('Yeni Kampanya', 180000),       -- ID: 5
('Otonom Drone', 900000);        -- ID: 6 (Henüz kimsenin atanmadığı proje)

-- 4. Çalışan - Proje Eşleştirmeleri
-- Not: Bazı departmanlı çalışanlar, bazı departmansız çalışanlar projelere atanmıştır.
INSERT INTO CalisanProjeleri (CalisanID, ProjeID) VALUES
(1, 1),  -- Ahmet Yılmaz (Yazılım Dept) -> Mobil Uygulama
(2, 1),  -- Mehmet Kaya (Yazılım Dept) -> Mobil Uygulama
(3, 2),  -- Ayşe Demir (Yazılım Dept) -> ERP Dönüşümü
(5, 3),  -- Burak Yılmaz (Yazılım Dept) -> Yapay Zeka Ar-Ge
(6, 4),  -- Zeynep Çelik (İK Dept) -> Bordro Otomasyonu
(10, 5), -- Mustafa Koç (Pazarlama Dept) -> Yeni Kampanya
(22, 1), -- Berk Oktay (Departmanı NULL) -> Mobil Uygulama
(23, 2); -- Melis Sezen (Departmanı NULL) -> ERP Dönüşümü
-- DEÐÝÞKENLER

--1---SQL Server’da bir deðiþkeni ‘--DECLARE--’ komutu ile tanýmlarýz.
--2---Ardýndan deðiþkeni baþýna --@--iþareti koyarak isimlendiririz.
--3---Daha sonra ‘--AS--’ ile deðiþken tipini tanýmlarýz.
--4---‘SET’ @-- ile deðiþkene deðer atarýz.
--5---Veri tabanýndan dönen bir deðeri bir deðiþkene atamak için :
--SELECT @DEÐÝÞKENADI = KOLON_ADI

-- Tekli Tanýmlama
DECLARE @UrunSayisi INT;

-- Ýlk deðer aama yolu ile tanýmlama
DECLARE @KDVOrani DECIMAL(5,2) = 0.20;

-- Çoklu tanýmlama
DECLARE @MinFiyat MONEY,
		@MaxFiyat MONEY,
		@ArananKelime NVARCHAR(50) = N'Bilgisayar';

-- -----
DECLARE @UrunAdi NVARCHAR(50), 
@Fiyati DECIMAL(18,2), 
@ToplamUrun INT;

SET @ToplamUrun = 
(SELECT COUNT(*) FROM URUNLER);

--SELECT @ToplamUrun;

SELECT 
@UrunAdi = UrunAdi,
@Fiyati = BirimFiyat
FROM Urunler ;

PRINT N'Toplam Ürün Çeþidi: ' + 
CAST(@ToplamUrun AS NVARCHAR(10));
SELECT @UrunAdi AS [Ürün Adý], 
@Fiyati AS [Birim Fiyatý];

-- -----

DECLARE @KritikStokTablosu TABLE(
ID INT,
Ad NVARCHAR(100),
MevcutStok INT);

INSERT INTO @KritikStokTablosu
SELECT UrunID, UrunAdi, StokMiktari
FROM Urunler
WHERE StokMiktari < 10;

SELECT * FROM @KritikStokTablosu;
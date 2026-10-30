-- Parametre Almayan
CREATE PROCEDURE usp_TumUrunleriListele
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
	u.UrunID, u.UrunAdi,
	k.KategoriAdi, u.BirimFiyat,
	u.StokMiktari
	FROM Urunler u
	INNER JOIN Kategoriler k ON 
	u.KategoriID=k.KategoriID
	WHERE u.AktifMi = 1;
END;

EXEC usp_TumUrunleriListele;


-- Parametre Alan

CREATE PROCEDURE usp_KategoriyeUygunUrunGetir
	@Kat_ID INT -- Giriþ (Input) parametresi
AS
BEGIN
	SET NOCOUNT ON;

	SELECT UrunID, UrunAdi, 
	BirimFiyat,StokMiktari,
	KategoriID
	FROM Urunler
	WHERE KategoriID = @Kat_ID;
END

EXEC usp_KategoriyeUygunUrunGetir 1;

-- Çoklu ve Varsayýlan Deðer

CREATE PROCEDURE usp_UrunArama
@ArananKelime NVARCHAR(50) = N'',
@MinFiyat DECIMAL(18,2) = 0,
@MaxFiyat DECIMAL(18,2) = 999999.99
AS
BEGIN
	SET NOCOUNT ON;

	SELECT UrunAdi, BirimFiyat, StokMiktari
	FROM URUNLER
	WHERE UrunAdi LIKE N'%' + @ArananKelime + N'%'
	AND BirimFiyat BETWEEN @MinFiyat AND @MaxFiyat
END

EXEC usp_UrunArama;

EXEC usp_UrunArama @ArananKelime= N'Bilgisayar';

EXEC usp_UrunArama @MinFiyat = 30000;

EXEC usp_UrunArama @MinFiyat = 30000, @MaxFiyat=50000;

EXEC usp_UrunArama @ArananKelime= N'Bilgisayar',
@MinFiyat = 30000, @MaxFiyat=50000; 

-- Geri Dönüþ Deðeri Olan

CREATE PROCEDURE usp_UrunSatisOzetiGetir
	@UrunID INT,
	@ToplamSatilanAdet INT OUTPUT,
	@ToplamCiro DECIMAL(18,2) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	@ToplamSatilanAdet = ISNULL(SUM(Adet), 0),
	@ToplamCiro = ISNULL(SUM(Adet * SatisFiyati), 0)
	FROM Satislar
	WHERE UrunID = @UrunID
END;

DECLARE @DonenAdet INT, @DonenCiro DECIMAL(18,2);

EXEC usp_UrunSatisOzetiGetir
	@UrunID =1,
	@ToplamSatilanAdet = @DonenAdet OUTPUT,
	@ToplamCiro = @DonenCiro OUTPUT;

SELECT @DonenAdet AS [Toplam Satilan Adet],
@DonenCiro AS [Elde Edilen Ciro]; 

-- Return Ýfadesi

CREATE PROCEDURE usp_StokKontrolEt
	@UrunID INT,
	@IstenenAdet INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @MevcutStok INT;

	IF NOT EXISTS (SELECT 1 FROM Urunler WHERE UrunID= @UrunID)
		RETURN -1; -- Hata Kodu -1: Ürün bulunamadý!

	SELECT @MevcutStok = StokMiktari FROM Urunler
	WHERE UrunId=@UrunID;

	IF @MevcutStok < @IstenenAdet
		RETURN -2; -- Hata Kodu -2: Yetersiz Stok!

	RETURN 0; -- Durum Kodu 0: Her þey yolunda.
END;

DECLARE @DurumKodu INT;
EXEC @DurumKodu = usp_StokKontrolEt @UrunId = 5,
@IstenenAdet = 10;
SELECT @DurumKodu AS [Dönen Durum Kodu];





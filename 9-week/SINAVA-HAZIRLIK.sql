-- SORU 1: 
--Tum urunlerin adini, birim fiyatini ve
-- ait olduklari kategori adini listeleyen sorguyu yaziniz

select u.UrunAdi, u.BirimFiyat, k.KategoriAdi from Urunler u
left join Kategoriler k on k.KategoriID = u.KategoriID;

-- SORU 2: 
--Tum personllerin adini, soyadini
-- calistiklari departmanlari listeleyiniz
select p.Ad, p.Soyad, d.DepartmanAdi from Personeller p
left join Departmanlar d on p.DepartmanID = d.DepartmanID;

-- SORU 5: 
--Siparisleri onaylayan personellerin ad-soyad
-- ile SiparisID ve SiparisTarihi bilgilerini eslestiiriniz
select p.Ad + '-' + p.Soyad as [Personel], s.SiparisID, s.SiparisTarihi from Siparisler s
left join Personeller p on s.PersonelID = p.PersonelID;

-- SORU 7:
-- Siparisleri olsun ya da olmasin tum musterileri
-- ve varsa siparis numaralarina listeleyiniz 
-- (olsun ya da olmasin dedigi icin left join kullandik.
-- sadece olanlari isteseydi inner join kullanirdik)
select m.MusteriID, m.MusteriAdi + '-' + m.MusteriSoyadi, s.SiparisID from Musteriler m
left join Siparisler s on s.MusteriID = m.MusteriID;

-- SORU 8:
-- Henuz hicbir sipariste satilmamis urunleri 
-- LEFT JOIN (anti-join) yontemi ile bulunuz
select u.UrunID, u.UrunAdi, s.SiparisID from Urunler u
left join SiparisDetay s on u.UrunID = s.UrunID
where s.SiparisID is null

-- SORU 17:
-- Hangi tedarikciden toplam kac Tl'lik urun
-- stogu bulundugunu (StokMiktari * BirimFiyat) tedarikci
-- sirket adiyla birlikte listeleyiniz
select u.UrunAdi, sum(u.StokMiktari * u.BirimFiyat) as [ToplamUrunFiyati], t.SirketAdi from Urunler u
left join Tedarikciler t on u.TedarikciID = t.TedarikciID 
group by t.SirketAdi, u.UrunAdi;

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

-- SORU 1 ( parametresiz ):
-- Stok miktari 5'in altina dusmus kritik seviyedeki urunleri
-- ve kategorilerini listeleyen sp_KritikStokRaporu isimli proseduru yaziniz
create procedure dbo.usp_KritikStokRaporu
as
begin
	select u.UrunID, u.UrunAdi, k.KategoriAdi, u.StokMiktari
	from Urunler u 
	inner join Kategoriler k on u.KategoriID = k.KategoriID
	where u.StokMiktari < 5;
end

exec dbo.usp_KritikStokRaporu

-- SORU 3 ( 1 parametreli ekleme ):
-- Yeni bir kategoriyi veritabani ekleyen
-- sp_KategoriEkle prosedurunu yaziniz
create procedure sp_KategoriEkle
	@KategoriAdi nvarchar(50)
as
begin
	set nocount on;
	insert into dbo.Kategoriler (KategoriAdi) values (@KategoriAdi);
	print 'Kategori Basariyla Eklendi';
end;

select * from Kategoriler;

exec dbo.sp_KategoriEkle 'Kara Esya'


----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
----------------------- SINAVDA KESIN CIKICAK ------------------------
-- SORU 8 ( output parametreli ):
-- Verilen departman ID'sine ait toplam personel sayisini
-- OUTPUT parametresi olarak disariya donduren
-- sp_DepartmanPersonelSayisi prosedurunu yaziniz
create procedure sp_DepartmanPersonelSayisi
	@DepartmanID int,
	@ToplamPersonelSayisi int output
as
begin
	set nocount on;
	select @ToplamPersonelSayisi = count(*)
	from dbo.Personeller
	where DepartmanID = @DepartmanID;
end;

declare @Sonuc int;
exec sp_DepartmanPersonelSayisi @DepartmanID = 2, @ToplamPersonelSayisi = @Sonuc output
print ' Departmandaki Personel Sayisi: ' + cast(@Sonuc as varchar(10));


--------------------- VIEWLERE DE CALISMAYA UNUTMA HOCA ATICAK ----------------------
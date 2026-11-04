-- SORU 1

create view vw_AktifUrunKatalogu
as select u.UrunID, u.UrunAdi, k.KategoriID, u.StokMiktari, u.BirimFiyat from dbo.Urunler u 
left join dbo.Kategoriler k on u.KategoriID = k.KategoriID
where u.AktifMi = 1;

-- SORU 2

create view vw_KategoriSatisOzeti
as select k.KategoriAdi, count(distinct u.UrunID) as [UrunCesidSayisi],
isnull(sum(s.Adet), 0) as [ToplamSatilanAdet],
isnull(sum(s.Adet * s.SatisFiyati), 0 ) as [ToplamCiro]
from dbo.Kategoriler k
left join dbo.Urunler u on u.KategoriID = k.KategoriID 
left join dbo.Satislar s on u.UrunID =  s.UrunID
group by k.KategoriID, k.KategoriAdi;
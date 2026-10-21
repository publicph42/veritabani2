use TEKRAR;

-- 1. Sirketteki ortalama maasin uzerinde kazanan calisanlari listeleyin
select * from calisanlar 
where Maas > (select avg(Maas) from Calisanlar);

-- 2. En yuksek butceye sahip projenin detaylarini gosterin
select * from Projeler 
where Butce = (select max(Butce) from Projeler);

-- 3. En son ise giren kisinin adi soyadi ve ise giris tarihini bulun
select Ad, Soyad, IseGirisTarihi from Calisanlar 
where IseGirisTarihi = (select max(IseGirisTarihi) from Calisanlar);

-- 4. Yazilim departmaninda calisan personellerin ad, soyad ve maas bilgilerini listele
select Ad, Soyad, Maas from Calisanlar 
where DepartmanID = (select DepartmanID from Departmanlar where DepartmanAd = 'Yazilim');

-- 5. Kidemli Gelistirici unvanina sahip kisileri gosterin
select Ad, Soyad from Calisanlar 
where UnvanId = (select UnvanId from Unvanlar where UnvanAd = 'Kidemli Gelistirici');

-- 6. A binasinda yer alan departmanlardaki calisanlari listeleyin
select Ad, Soyad, DepartmanID from Calisanlar 
where DepartmanID in (
select DepartmanID from Departmanlar where Bina = 'A Binasi');

-- 7. Herhangi bir projede gorevlendirilmemis calisanlari bulun
select Ad, Soyad, CalisanID from Calisanlar 
where CalisanID not in (select distinct CalisanID from ProjeGorevlendirmeleri);

-- 8
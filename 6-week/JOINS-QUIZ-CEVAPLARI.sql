-- SORU 1 -- 
-- Her calisanin adini ve karsisindaki departman adini listeleyen sorguyu yaziniz
-- ( sadece departmani olanlar)

select c.AdSoyad, d.DepartmanAdi from Calisanlar c 
inner join Departmanlar d on c.DepartmanID = d.DepartmanID;

-- SORU 2 -- 
-- Tum departmanlari ve bu departmanlarda calisanlarin isimlerini listeleyin
-- ( Calisani olmayan departmanlar da gelsin)

select d.DepartmanAdi, c.AdSoyad from Departmanlar d 
left join Calisanlar c on d.DepartmanID = c.DepartmanID;

-- SORU 3 --
-- Tum calisanlarin departman adlariyla birlikte listeleyiniz
-- (Departmani olmayan calisanlar da NULL olarak gelsin)

select c.AdSoyad, d.DepartmanAdi from Calisanlar c
left join Departmanlar d on d.DepartmanID = c.DepartmanID;

-- SORU 4 -- 
-- Departmanlar ve Calisanlar tablolarinin kartezyen carpimini ( CROSS JOIN )
-- getiren sorguyu yaziniz
select * from Calisanlar 
cross join Departmanlar;


-- SORU 5 --
-- Departman adi 'Yazilim' olan calisanlarin adini ve maasini listeleyiniz
select c.AdSoyad, c.Maas, d.DepartmanAdi from Calisanlar c
left join Departmanlar d on d.DepartmanID = c.DepartmanID where d.DepartmanAdi = 'Yazýlým';


-- SORU 6 --
--Henuz hicbir calisani bulunmayan departmanlarin adlarini listeleyiniz
select c.AdSoyad, d.DepartmanAdi from Calisanlar c
right join Departmanlar d on d.DepartmanID = c.DepartmanID where c.AdSoyad is null;
-- The correct answer was the below --
select d.DepartmanAdi from Departmanlar d 
left join Calisanlar c on d.DepartmanID = c.DepartmanID
where c.CalisanID is null;


-- SORU 7 -- 
-- Henuz herhangi bir departmana atanmamis calisanlarin adlarini ve maaslarini listeleyiniz
select c.AdSoyad, c.Maas from Calisanlar c
left join Departmanlar d on d.DepartmanID = c.DepartmanID where d.DepartmanID is null;


-- SORU 8 --
-- Hangi departmanda kac calisan oldugunu departman adiyla birlikte listeleyiniz
-- (Calisani olmayan departmanlar 0 olarak gorunmelidir)
select d.DepartmanAdi, count(c.CalisanID) as CalisanSayisi
from Departmanlar d
left join Calisanlar c on d.DepartmanID = c.DepartmanID group by d.DepartmanAdi;

-- SORU 9 -- 
-- Departman bazinda ortalama maaslari, yuksekten dusuge dogru sirali sekilde listeleyiniz 
select d.DepartmanAdi, AVG(c.Maas) as OrtalamaMaas 
from Departmanlar d
left join Calisanlar c on d.DepartmanID = c.DepartmanID 
where c.Maas is not null 
group by d.DepartmanAdi 
order by OrtalamaMaas desc;


-- SORU 10 --
-- Eslesmeyen tum kayitlari ( hem calisani olmayan departmanlari hem de departmansiz calisanlari )
-- tek bir sorguda listeleyiniz
select 
d.DepartmanAdi,
c.AdSoyad
from Departmanlar d
full outer join Calisanlar c on d.DepartmanID = c.DepartmanID
where d.DepartmanID is null or c.CalisanID is null;

-- SORU 11 --
-- En az 4 calisani bulunan departmanlarin adlarini ve calisan sayilarini listeleyiniz
select d.DepartmanAdi, count(c.CalisanID) as CalisanSayisi
from Departmanlar d
left join Calisanlar c on d.DepartmanID = c.DepartmanID  group by d.DepartmanAdi having count(c.CalisanID) >= 4;

-- SORU 12 -- 
-- SINAV SORUSU IHTIMALI VAR
-- SINAV SORUSU IHTIMALI VAR
-- SINAV SORUSU IHTIMALI VAR
-- SINAV SORUSU IHTIMALI VAR
-- SINAV SORUSU IHTIMALI VAR
-- Kendi departmaninin ortalama maasindan daha yuksek maas alan calisanlarin adini, maasini
-- departmanini listeleyiniz
select c.AdSoyad, c.Maas, d.DepartmanAdi, deptOrt.OrtalamaMaas from Calisanlar c
inner join Departmanlar d on c.DepartmanID = d.DepartmanID 
inner join (
select DepartmanID, avg(Maas) as OrtalamaMaas
from Calisanlar 
where DepartmanID is not null
group by DepartmanID
) deptOrt on c.DepartmanID = deptOrt.DepartmanID
where c.Maas > deptOrt.OrtalamaMaas;


-- SORU 13 --
-- Her departmanin en yuksek maas alan calisanini (Ad, Departman) yaziniz
-- !!!!! idk if my answer is correct !!!!!
select c.AdSoyad, c.Maas, d.DepartmanAdi from Calisanlar c
inner join Departmanlar d on c.DepartmanID = d.DepartmanID 
inner join (
select DepartmanID, max(Maas) as MaxMaas
from Calisanlar 
where DepartmanID is not null
group by DepartmanID
) deptOrt on c.DepartmanID = deptOrt.DepartmanID
where c.Maas = MaxMaas;

-- SORU 14 --
-- Hicbir departmana atanmamis calisanlarin toplam maas yukunu
-- yazdiran sorguyu yaziniz
select sum(c.Maas) as DepartmansizToplamMaas 
from Calisanlar c 
left join Departmanlar d on c.DepartmanID = d.DepartmanID
where d.DepartmanID is null;

-- SORU 15 --
-- Left join kullanarak, her calisanin adini, departmanini ve
-- o departmanin butcesini (maaslar toplami) tek bir tabloda listeleyiniz
use joinler;

--- LEFT EXCLUDING JOIN
select d.DepartmanAdi from Departmanlar d 
left join Calisanlar c on d.DepartmanID = c.DepartmanID
where c.CalisanID is null;

--- SEMI JOIN
select d.DepartmanAdi from Departmanlar d
where exists (select 1 from Calisanlar c where c.DepartmanID = d.DepartmanID);

--- ANTI SEMI JOIN
select d.DepartmanAdi from Departmanlar d
where not exists ( select 1 from Calisanlar c where c.DepartmanID = d.DepartmanID);

--- FULL OUTER JOIN
select d.DepartmanAdi, c.AdSoyad from Departmanlar d
full outer join Calisanlar c



#suma po stavkama odgovara osnovici
select r.osnovica, s.iznos, r.iznos, r.*
from racun r inner join
(
	select racun_id, sum(cijena * kolicina) iznos , count(*) stavki from racun_stavka group by racun_id
) s on r.id = s.racun_id
where abs(r.osnovica  - s.iznos) > 0.01


#suma placanja odgovara placeno
select r.placeno, s.iznos, r.iznos, r.*
from racun r inner join
(
	select racun_id, sum(iznos) iznos , count(*)  from racun_placanje group by racun_id
) s on r.id = s.racun_id
where abs(r.placeno  - s.iznos) > 0.01


#raèuni koji nemaju stavke -- postoje neki u 1999-toj godini kod nektra
select * from racun
where id not in (select racun_id from racun_stavka ) and godina > 1999



delete from partner where id not in 
(
	select partner_id
	from 
	(
		select partner_id, count(*) broj from racun group by partner_id
		union
		select partner_id, count(*) broj from ulazni_racun group by partner_id
		union
		select partner_id, count(*) broj from ponuda group by partner_id
		union
		select partner_id, count(*) broj from izdatak group by partner_id
		union
		select partner_id, count(*) broj from primitak group by partner_id
	) p 
	group by partner_id
);

update partner set naziv = '?' where naziv = '';

update partner set naziv = ltrim(naziv);

--select naziv, ltrim(naziv) from partner order by naziv 
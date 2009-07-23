require 'dbi/dbi'
require 'fixture_manager.rb'

sql_racuni = " select 	
	  d.ID, d.godina, d.Broj, 
	  r.ID_Partner,
	  d.datum, datediff(d,d.Datum,r.Valuta),
	  rabat, pdv, iznos,
	  iznosplaceno,
	  d.napomena
	  --,ID_Porez - 1 tip_poreza		
  from 
	  dok_Racun r 
	  inner join dbo.dok_Dokument d on r.ID_Dokument = d.ID
  where 
	  d.ID_DokumentTip = 1
	"
sql_gotovinski_racuni = " select 	
	  d.ID, d.godina, d.Broj, 
	  r.ID_Partner,
	  d.datum, datediff(d,d.Datum,r.Valuta),
	  rabat, pdv, iznos,
	  d.napomena
	  --,ID_Porez - 1 tip_poreza		
  from 
	  dok_Racun r 
	  inner join dbo.dok_Dokument d on r.ID_Dokument = d.ID
  where 
	  d.ID_DokumentTip = 8
	"	

sql_ponude = "
 select 	
	  d.ID, d.godina, d.Broj, 
	  r.ID_Partner,
	  d.datum, datediff(d,d.Datum,r.Valuta),
	  rabat, pdv, iznos,
	  d.napomena	
  from 
	  dok_Racun r 
	  inner join dbo.dok_Dokument d on r.ID_Dokument = d.ID
  where 
	  d.ID_DokumentTip = 3
"	

sql_ulazni_racuni	=
  " select 	
	  d.ID, d.godina, d.Broj, 
	  r.ID_Partner, r.PartnerBroj,
	  d.datum, datediff(d,d.Datum,r.Valuta),
	  rabat, pdv, iznos,
	  iznosplaceno,
	  d.napomena,		
		case when ID_PredPorez in (1,2) then 0 else 1 end tip_predporeza,
		case when ID_PredPorez in (2,3) or d.ID_DokumentTip = 8 then 1 else 0 end tip_placanja		
  from 
	  dok_Racun r 
	  inner join dbo.dok_Dokument d on r.ID_Dokument = d.ID
  where 
	  d.ID_DokumentTip = 2
	"
	
	
sql_placanje = "
  select i.ID_Racun,case 
		    when d2.ID_DokumentTip = 1 then 'Racun'
		    when d2.ID_DokumentTip = 2 then 'UlazniRacun'
	    end, i.Iznos, d.Datum, d.Broj, d.Godina
  from dbo.dok_IzvodRacun i 
		inner join dok_Dokument d on i.ID_Izvod = d.Id
		inner join dok_Dokument d2 on i.ID_Racun = d2.Id
	"
	
sql_izdaci = "
  select 
	  d.ID id,
	  case 
		  when d.ID_DokumentTip = 6 then 'Primitak'
		  when d.ID_DokumentTip = 7 then 'Izdatak'
	  end type,
	  d.godina, d.Broj, 
	  d.Datum, 
	  Opis,
	  case when NaZiro > 0 then 0
	  when Ugotovini > 0 then 1
	  else 2 end,
	  NaZiro + UGotovini + UNaravi,
	  pdv
  from dok_PrimitakIzdatak i 
	  inner join dok_Dokument d on i.ID_Dokument = d.ID
  "

sql_racun_stavka = "
    select
      ID_Dokument, 
	    case 
		    when d.ID_DokumentTip = 1 then 'Racun'
		    when d.ID_DokumentTip = 2 then 'UlazniRacun'
		    when d.ID_DokumentTip = 3 then 'Ponuda'
			  when d.ID_DokumentTip = 8 then 'GotovinskiRacun'
	    end,
	    ID_Produkt, Kolicina, Cijena 
	  from dbo.dok_RacunStavka s
	    inner join dbo.dok_Dokument d on s.ID_Dokument = d.ID
		where ID_produkt != 2 --izbaci stavke ulazna roba  
  "    
  

db = DBI.connect('DBI:ADO:Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=Mali;User Id=sa;Password=;')
fm = FixtureManager.new

#partneri
q = FixtureManager.create_query(db, "select id,naziv,mjesto,adresa,tel,fax,poreznibroj,ziroracun,kontaktosoba, email from mp_Partner")
while r =  q.fetch do      
 fm.partner r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8]
end

#stavke
q = FixtureManager.create_query(db, "select id, naziv, jedinicamjere, cijena from dbo.mp_Produkt")
while r =  q.fetch do      
 fm.stavka r[0],r[1],r[2],r[3]
end

#racuni
q = FixtureManager.create_query(db, sql_racuni)
while r =  q.fetch do      
  fm.racun r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10]
end

#gotovinski_racuni
q = FixtureManager.create_query(db, sql_gotovinski_racuni)
while r =  q.fetch do      
  fm.gotovinski_racun r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9]
end

#ponuda
q = FixtureManager.create_query(db, sql_ponude)
while r =  q.fetch do      
  fm.ponuda r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9]
end

#ualzni_racuni
q = FixtureManager.create_query(db, sql_ulazni_racuni)
while r =  q.fetch do      
  fm.ulazni_racun r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12],r[13]
end

#racuni_stavke
q = FixtureManager.create_query(db, sql_racun_stavka)
while r =  q.fetch do      
  fm.racun_stavka r[0],r[1],r[2],r[3],r[4]
end

#racuni_placanje
q = FixtureManager.create_query(db, sql_placanje)
while r =  q.fetch do      
  fm.racun_placanje r[0],r[1],r[2],r[3],"izvod FINA-e #{r[4]}/#{r[5]}"
end

#izdaci
q = FixtureManager.create_query(db, sql_izdaci)
while r =  q.fetch do      
  fm.izdatak r[0],r[1],0,r[2],r[3],r[4],r[5],r[6],r[7],r[8]
end





fm.close
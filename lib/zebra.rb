require 'dbi/dbi'
require 'iconv'
require 'facets/core/float/round_at'

def add(fp, val)
  (val = escape(val)) if val.class == String
  fp.print val, ','  
end
def add2(fp, val)
  (val = escape(val)) if val.class == String
  fp.print val, "\n"  
end

def escape(str)
  str ? '"' + str.gsub('"', "'").gsub("\n", " ") + '"' : ""
end

def calc_pdv_postotak(iznos, pdv)  
  ((iznos/(iznos-pdv)-1)*100).round_at(2) rescue 0
end

def calc_popust_postotak(osnovica, popust)  
  if popust > 0
    return popust/osnovica * 100
  else
    return 0
  end
end

def create_query(query)
  q = @dbSource.prepare(query)  
  q.execute
  return q
end

def get_racun_id(id)
  @godina * 10000 + id
end

def get_ulazni_racun_id(id)
  @godina * 10000 + id + 100000000
end

def racun(type, id, godina, broj,
  partner_id, partner_broj,
  datum, dospjece, rok_placanja,    
  osnovica, popust, pdv, iznos,
  placeno, datum_placanja, broj_izvoda,
  napomena)
    
  add @fpRacun, type
  add @fpRacun, id
  add @fpRacun, godina
  add @fpRacun, broj
  
  add @fpRacun, partner_id
  add @fpRacun, partner_broj
  
  add @fpRacun, datum
  add @fpRacun, dospjece
  add @fpRacun, rok_placanja.to_i
  
  add @fpRacun, calc_popust_postotak(osnovica, popust)
  add @fpRacun, calc_pdv_postotak(iznos, pdv)
  
  add @fpRacun, osnovica
  add @fpRacun, popust
  add @fpRacun, pdv
  add @fpRacun, iznos
  
  add @fpRacun, placeno >= iznos ? 1 : 0
  add @fpRacun, placeno
  add2 @fpRacun, napomena
  
  if placeno > 0
    add @fpRacunPlacanje, id
    add @fpRacunPlacanje, placeno
    add @fpRacunPlacanje, "izvod ZAP-a broj #{broj_izvoda}"
    add2 @fpRacunPlacanje, datum_placanja
  end
  
end

@godina = 2005
@dbSource = DBI.connect("DBI:ADO:Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\\projects\\zebra\\vk\\98GOD\\BAZE\\z#{@godina}.mdb;User Id=admin;Password=;")
@stavke = Hash.new

@fpRacun = File.open("racun.csv", "w")
@fpRacunPlacanje = File.open("racun_placanje.csv", "w")
@fpRacun.print "type, id,godina,broj,  partner_id,partner_broj,  datum,dospjece,rok_placanja, popust_postotak,pdv_postotak ,osnovica,popust,pdv,iznos, placen,placeno,napomena\n" 
@fpRacunPlacanje.print "racun_id,iznos,dokument,datum\n" 

def partneri
  fp = File.open("partner.csv", "w")
  fp.print "id,naziv,mjesto,adresa,tel,fax,porezni_broj,ziro_racun,kontakt\n" 
  q = create_query("select * from partneri")
  while row =  q.fetch do      
    fp.print row[0], ','
    fp.print escape("#{row[1]} #{row[2]}"), ','
    fp.print escape(row[3]), ','
    fp.print escape(row[4]),','
    fp.print escape(row[5]),','
    fp.print escape(row[6]),','
    fp.print escape(row[10]),','
    fp.print escape(row[11]),','
    fp.print escape(row[7]),"\n"
  end
  fp.close
end

def get_key(opis, jmj)
  "#{opis.strip}==#{jmj.strip}".strip
end

def racuni 
  q = create_query('SELECT br_racun,sifra_kupca,"" AS partner_broj, datum,valuta,valuta-datum, vbp,rab,pdv,vsp, placeno_izn,izvod_dat,izvod_br, nap FROM faktura')
  while row = q.fetch do      
    racun(
      'Racun',#type
      get_racun_id(row[0]),#id      
      @godina,#godina
      
      row[0], #broj
      row[1].to_i, #partner_id
      row[2],  #partner_broj
      
      row[3], #datum
      row[4], #dospjece
      row[5], #rok_placanja
      
      row[6], #osnovica
      row[7], #popust
      row[8], #pdv
      row[9], #izos
      
      row[10],  #placeno
      row[11], #datum_placanja
      row[12], #broj izvoda
      
      row[13] #napomena
    )
  end      
end

def ulazni_racuni
  q = create_query("SELECT br_racun,sifra_dob,racun,  datum,valuta,valuta-datum,  uk_iznos,rabi,pdvO,vsp,  placeno_izn,izvod_dat,izvod_br, nap  from ul_faktura;")
  while row = q.fetch do     
    racun(
      'UlazniRacun',#type
      get_ulazni_racun_id(row[0]),#id
      @godina,#godina
      
      row[0], #broj
      row[1].to_i, #partner_id
      row[2],  #partner_broj
      
      row[3], #datum
      row[4], #dospjece
      row[5], #rok_placanja
      
      row[6], #osnovica
      row[7], #popust
      row[8], #pdv
      row[9], #izos
      
      row[10], #placeno
      row[11], #datum_placanja
      row[12], #broj izvoda
      
      row[13] #napomena
    )
  end
end

def racuni_stavke
  fp = File.open("racun_stavka.csv", "w")
  fp.print "racun_id,stavka_id,kolicina,cijena\n" 
  q = create_query("select * from prodroba order by br_racun desc")
  while row = q.fetch do
    stavka_id = get_stavka(row[1], row[2], row[5])    
    fp.print get_racun_id(row[0]), ','
    fp.print stavka_id, ','
    fp.print row[3], ','
    fp.print row[5] * (1 - (row[7] ? row[7] / 100 : 0) ), "\n"
  end
  fp.close
end

def ulazni_racuni_stavke
  fp = File.open("racun_stavka.csv", "a")  
  q = create_query("select br_racun, nazivrobe, jed_mjere, kolicina, cijenarobe from ul_roba order by br_racun desc")
  while row = q.fetch do
    stavka_id = get_stavka(row[1], row[2], row[4])
    fp.print get_ulazni_racun_id(row[0]), ','
    fp.print stavka_id, ','
    fp.print row[3], ','
    fp.print row[4], "\n"
  end
  fp.close
end

def get_stavka(opis, jmj, cijena)
  key = get_key(opis, jmj)
  stavka_id = @stavke[key] 
  if !stavka_id
    stavka_id = @stavka_id 
    @fpsStavka.print @stavka_id, ','
    @fpsStavka.print escape(opis), ','
    @fpsStavka.print escape(jmj),','
    @fpsStavka.print cijena,"\n"            
    @stavke[key] = @stavka_id 
    @stavka_id += 1 
  end
  stavka_id
end

@fpsStavka = File.open("stavka.csv", "w")
@fpsStavka.print "id,opis,jedinica_mjere,cijena\n" 
@stavka_id = 1
@stavke = Hash.new
  
partneri

racuni
ulazni_racuni

racuni_stavke
ulazni_racuni_stavke

@fpsStavka.close
@fpRacun.close
@fpRacunPlacanje.close
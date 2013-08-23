class FixtureManager

  def initialize
    @fp_partner = File.open("partner.csv", "w")
    @fp_partner.print "id,naziv,mjesto,adresa,tel,fax,porezni_broj,ziro_racun,kontakt\n"

    @fp_stavka = File.open("stavka.csv", "w")
    @fp_stavka.print "id,opis,jedinica_mjere,cijena\n"

    @fp_racun = File.open("racun.csv", "w")
    @fp_racun.print "id,godina,broj,  partner_id, datum,rok_placanja, popust_postotak,pdv_postotak ,osnovica,popust,pdv,iznos, placen,placeno,napomena\n"

    @fp_gotovinski_racun = File.open("gotovinski_racun.csv", "w")
    @fp_gotovinski_racun.print "id,godina,broj,  partner_id, datum,rok_placanja, popust_postotak,pdv_postotak ,osnovica,popust,pdv,iznos, napomena\n"

    @fp_ponuda = File.open("ponuda.csv", "w")
    @fp_ponuda.print "id,godina,broj,  partner_id, datum,rok_placanja, popust_postotak,pdv_postotak ,osnovica,popust,pdv,iznos, napomena\n"

    @fp_ulazni_racun = File.open("ulazni_racun.csv", "w")
    @fp_ulazni_racun.print "id,godina,broj,  partner_id,partner_broj,  datum,rok_placanja, popust_postotak,pdv_postotak ,osnovica,popust,pdv,iznos, placen,placeno,napomena, tip_predporeza,tip_placanja\n"

    @fp_racun_placanje = File.open("racun_placanje.csv", "w")
    @fp_racun_placanje.print "racun_id,racun_type,iznos,dokument,datum\n"

    @fp_racun_stavka = File.open("racun_stavka.csv", "w")
    @fp_racun_stavka.print "racun_id,racun_type, stavka_id,kolicina,cijena\n"

    @fp_izdatak = File.open("izdatak.csv", "w")
    @fp_izdatak.print "id,type,partner_id,godina,broj,datum,opis,tip_uplate,iznos,pdv\n"

  end

  def racun(id, godina, broj,
    partner_id,
    datum, rok_placanja,
    popust, pdv, iznos,
    placeno,
    napomena)

    iznos = to_f(iznos)
    popust = to_f(popust)
    pdv = to_f(pdv)
    placeno = to_f(placeno)
    osnovica = iznos - pdv + popust

    add @fp_racun, id
    add @fp_racun, godina
    add @fp_racun, broj

    add @fp_racun, partner_id

    add @fp_racun, datum
    add @fp_racun, rok_placanja.to_i

    add @fp_racun, calc_popust_postotak(osnovica, popust)
    add @fp_racun, calc_pdv_postotak(iznos, pdv)

    add @fp_racun, osnovica
    add @fp_racun, popust
    add @fp_racun, pdv
    add @fp_racun, iznos

    add @fp_racun, placeno >= iznos ? 1 : 0
    add @fp_racun, placeno
    add2 @fp_racun, napomena

  end

  def gotovinski_racun(id, godina, broj,
    partner_id,
    datum, rok_placanja,
    popust, pdv, iznos,
    napomena)

    iznos = to_f(iznos)
    popust = to_f(popust)
    pdv = to_f(pdv)
    osnovica = iznos - pdv + popust

    add @fp_gotovinski_racun, id
    add @fp_gotovinski_racun, godina
    add @fp_gotovinski_racun, broj

    add @fp_gotovinski_racun, partner_id

    add @fp_gotovinski_racun, datum
    add @fp_gotovinski_racun, rok_placanja.to_i

    add @fp_gotovinski_racun, calc_popust_postotak(osnovica, popust)
    add @fp_gotovinski_racun, calc_pdv_postotak(iznos, pdv)

    add @fp_gotovinski_racun, osnovica
    add @fp_gotovinski_racun, popust
    add @fp_gotovinski_racun, pdv
    add @fp_gotovinski_racun, iznos

    add2 @fp_gotovinski_racun, napomena
  end

   def ponuda(id, godina, broj,
    partner_id,
    datum, rok_placanja,
    popust, pdv, iznos,
    napomena)

    iznos = to_f(iznos)
    popust = to_f(popust)
    pdv = to_f(pdv)
    osnovica = iznos - pdv + popust

    add @fp_ponuda, id
    add @fp_ponuda, godina
    add @fp_ponuda, broj

    add @fp_ponuda, partner_id

    add @fp_ponuda, datum
    add @fp_ponuda, rok_placanja.to_i

    add @fp_ponuda, calc_popust_postotak(osnovica, popust)
    add @fp_ponuda, calc_pdv_postotak(iznos, pdv)

    add @fp_ponuda, osnovica
    add @fp_ponuda, popust
    add @fp_ponuda, pdv
    add @fp_ponuda, iznos

    add2 @fp_ponuda, napomena
  end

  def ulazni_racun(id, godina, broj,
    partner_id, partner_broj,
    datum, rok_placanja,
    popust, pdv, iznos,
    placeno,
    napomena,
    tip_predporeza,tip_placanja)

    iznos = to_f(iznos)
    popust = to_f(popust)
    pdv = to_f(pdv)
    placeno = to_f(placeno)
    osnovica = iznos - pdv + popust

    add @fp_ulazni_racun, id
    add @fp_ulazni_racun, godina
    add @fp_ulazni_racun, broj

    add @fp_ulazni_racun, partner_id
    add @fp_ulazni_racun, partner_broj

    add @fp_ulazni_racun, datum
    add @fp_ulazni_racun, rok_placanja.to_i

    add @fp_ulazni_racun, calc_popust_postotak(osnovica, popust)
    add @fp_ulazni_racun, calc_pdv_postotak(iznos, pdv)

    add @fp_ulazni_racun, osnovica
    add @fp_ulazni_racun, popust
    add @fp_ulazni_racun, pdv
    add @fp_ulazni_racun, iznos

    add @fp_ulazni_racun, placeno >= iznos ? 1 : 0
    add @fp_ulazni_racun, placeno
    add @fp_ulazni_racun, napomena

    add @fp_ulazni_racun, tip_predporeza
    add2 @fp_ulazni_racun, tip_placanja
  end

  def racun_placanje(racun_id,racun_type,iznos,datum,dokument)
    add @fp_racun_placanje, racun_id
    add @fp_racun_placanje, racun_type
    add @fp_racun_placanje, to_f(iznos)
    add @fp_racun_placanje, dokument
    add2 @fp_racun_placanje, datum
  end

  def racun_stavka(racun_id,racun_type,stavka_id,kolicina,cijena)
    add @fp_racun_stavka, racun_id
    add @fp_racun_stavka, racun_type
    add @fp_racun_stavka, stavka_id
    add @fp_racun_stavka, to_f(kolicina)
    add2 @fp_racun_stavka, to_f(cijena)
  end

  def partner(id,naziv,mjesto,adresa,tel,fax,porezni_broj,ziro_racun,kontakt)
    add @fp_partner, id
    add @fp_partner, naziv
    add @fp_partner, mjesto
    add @fp_partner, adresa
    add @fp_partner, tel
    add @fp_partner, fax
    add @fp_partner, porezni_broj
    add @fp_partner, ziro_racun
    add2 @fp_partner, kontakt
  end

  def stavka(id, opis, jmj, cijena)
    add @fp_stavka, id
    add @fp_stavka, opis
    add @fp_stavka, jmj
    add2 @fp_stavka, to_f(cijena)
  end

  def izdatak(id,type,partner_id,godina,broj,datum,opis,tip_uplate,iznos,pdv)
    add @fp_izdatak, id
    add @fp_izdatak, type
    add @fp_izdatak, partner_id
    add @fp_izdatak, godina
    add @fp_izdatak, broj
    add @fp_izdatak, datum
    add @fp_izdatak, opis
    add @fp_izdatak, tip_uplate
    add @fp_izdatak, to_f(iznos)
    add2 @fp_izdatak, to_f(pdv)
  end

  def close
    @fp_partner.close
    @fp_stavka.close
    @fp_racun.close

    @fp_gotovinski_racun.close
    @fp_ponuda.close
    @fp_ulazni_racun.close

    @fp_racun_placanje.close
    @fp_racun_stavka.close
    @fp_izdatak.close
  end

  def self.create_query(db, query)
    q = db.prepare(query)
    q.execute
    return q
  end

  def add(fp, val)
    fp.print to_csv_str(val), ','
  end
  def add2(fp, val)
    fp.print to_csv_str(val), "\n"
  end
  def to_csv_str(val)
    (val = escape(val)) if val.class == String
    (val = "null") if val == nil
    val
  end
  def escape(str)
    str ? '"' + str.gsub('"', "'").gsub("\n", " ") + '"' : ""
  end
  def to_f(val)
    if val.class == String
      val.gsub(',', ".") .to_f
    else
      val
    end
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

end

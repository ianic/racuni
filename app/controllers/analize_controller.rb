# encoding: utf-8

class AnalizeController < ApplicationController

  def najbolji_kupci
    @title = "Najbolji Kupci"
    get_partneri("iznos desc", "user_id = #{@user.id}")
  end

  def najveci_duznici
    @title = "Najveći Dužnici"
    get_partneri("dug desc", "user_id = #{@user.id} and dug > 0")
  end

  def stavke_izlaz
    @title = "Stavke Izlaz"
    get_stavke(Racun)
  end

  def stavke_ulaz
    @title = "Stavke Ulaz"
    get_stavke(UlazniRacun)
  end

  private

  def get_stavke(racun_type)
    @stavke = Stavka.find_by_sql("
      select s.id, s.opis, s.jedinica_mjere, sum(rs.cijena * rs.kolicina) iznos, sum(rs.kolicina) kolicina, avg(rs.cijena) cijena, count(*) broj_racuna
      from stavka s
        inner join racun_stavka rs on rs.stavka_id = s.id
        inner join #{racun_type.table_name} r on r.id = rs.racun_id and racun_type = '#{racun_type.to_s}'
      where
        #{racun_filter_params('r')}
      group by s.id, s.opis, s.jedinica_mjere
      order by 4 desc
      limit 100"
    )
  end

  def get_partneri(order, conditions = nil)
    racun_conditions = racun_filter_params
    racun_conditions = racun_conditions ? "where #{racun_conditions}"  : "" 
    
    @partneri = Partner.find_by_sql("select * from partner
                inner join
      (
              select partner_id,
                sum(iznos) iznos,
                sum(placeno) placeno,
                sum(iznos - placeno) dug,
                count(*) broj_racuna,
                count(*) - sum(placen) broj_neplacenih_racuna
              from racun r
              #{racun_conditions}
              group by partner_id
      ) r on r.partner_id = id                            
      where #{conditions}
      order by #{order} 
      limit 100
                "
    )
  end

end

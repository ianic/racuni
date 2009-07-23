class ViewPartnerStavka < ActiveRecord::Migration
  def self.up
    
    execute "
      create view partner_stavka_ids 
      as
      select rs.stavka_id, count(*) broj_racuna, max(rs.id) zadnji_rs_id,  r.partner_id
      from racun_stavka rs 	
        inner join racun r on r.id = rs.racun_id and rs.racun_type = 'Racun'
      group by rs.stavka_id,  r.partner_id
      union
      select rs.stavka_id, count(*) broj_racuna, max(rs.id) zadnji_rs_id,  r.partner_id
      from racun_stavka rs 	
        inner join ulazni_racun r on r.id = rs.racun_id and rs.racun_type = 'UlazniRacun'
      group by rs.stavka_id,  r.partner_id
    "
    
    execute "
      create view partner_stavka
      as
      select s.id, ps.partner_id, ps.stavka_id, s.opis, s.jedinica_mjere, rs.cijena, ps.broj_racuna, s.user_id
      from
      racun_stavka rs inner join 
      partner_stavka_ids ps on rs.id = ps.zadnji_rs_id
      inner join stavka s on s.id = ps.stavka_id
    "
          
  end

  def self.down
    execute "drop view partner_stavka"
    execute "drop view partner_stavka_ids"
  end
end

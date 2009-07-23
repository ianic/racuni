class FixUlazniGotovinski < ActiveRecord::Migration
  def self.up
    execute "insert into ulazni_racun_placanje(ulazni_racun_id, datum, iznos, tip_uplate, dokument)
      select id, datum, iznos, 1, '' from ulazni_racun u
      where tip_placanja = 1 and not exists (select id from ulazni_racun_placanje where ulazni_racun_id = u.id)"
      
  end

  def self.down
  end
end

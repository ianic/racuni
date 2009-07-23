class UlazniGotovinskiPlacanje < ActiveRecord::Migration
  def self.up
      
    execute "
        insert into ulazni_racun_placanje(ulazni_racun_id, datum, iznos, tip_uplate, dokument)
        select id, datum, iznos, 1, '' from ulazni_racun where tip_placanja = 1"
        
  end
 
  def self.down
  
    execute "delete from ulazni_racun_placanje where tip_uplate = 1"
    
  end
end

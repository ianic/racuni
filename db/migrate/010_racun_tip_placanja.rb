class RacunTipPlacanja < ActiveRecord::Migration
  def self.up
    add_column :racun, :tip_placanja, :integer, :null => false, :default => 0
    
    execute "insert into racun (id, partner_id, godina, broj, datum, rok_placanja, pdv_kategorija, osnovica, popust_postotak, popust,  pdv_postotak, pdv, iznos, napomena, tip_placanja)
       select 10000 + id, partner_id, godina, broj, datum, rok_placanja, pdv_kategorija, osnovica, popust_postotak, popust,  pdv_postotak, pdv, iznos, napomena, 1 from gotovinski_racun"

    execute "update racun_stavka set 
	      racun_id = racun_id + 10000,
	      racun_type = 'Racun'
      where racun_type = 'GotovinskiRacun'"

    execute "insert into racun_placanje(racun_id, datum, iznos, tip_uplate, dokument)
      select id, datum, iznos, 1, '' from racun where tip_placanja = 1"

    execute "update racun set placen = 1, placeno = iznos where tip_placanja = 1"
    
   end
  def self.down    
    execute "delete from racun where tip_placanja = 1"
    
    execute "update racun_stavka set 
	      racun_id = racun_id - 10000,
	      racun_type = 'GotovinskiRacun'
      where racun_id > 10000"
    
    remove_column :racun, :tip_placanja 
        
  end
end
   
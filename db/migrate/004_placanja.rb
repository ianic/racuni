class Placanja < ActiveRecord::Migration
  def self.up
    create_table :ulazni_racun_placanje do |t|
      t.column :ulazni_racun_id,    :integer, :null => false
      t.column :dokument, :string,  :null => false
      t.column :datum, :date,       :null => false
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false
    end		
    execute "insert into ulazni_racun_placanje(id, ulazni_racun_id,  dokument, datum, iznos)
             select id, racun_id, dokument, datum, iznos from racun_placanje where racun_type = 'UlazniRacun'"
    
    execute "delete from racun_placanje where racun_type = 'UlazniRacun'"
    remove_column :racun_placanje, :racun_type    
  end
  
  def self.down    
    add_column :racun_placanje, :racun_type, :string, :default => "Racun"
    execute "insert into racun_placanje (id, racun_id, dokument, datum, iznos, racun_type)
             select id, ulazni_racun_id, dokument, datum, iznos, 'UlazniRacun' from ulazni_racun_placanje"
    drop_table :ulazni_racun_placanje    
  end
end
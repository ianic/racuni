class PlacanjeTipUplate < ActiveRecord::Migration
  def self.up
    add_column :racun_placanje, :tip_uplate, :integer, :null => false, :default => 0
    add_column :ulazni_racun_placanje, :tip_uplate, :integer, :null => false, :default => 0
  end
  
  def self.down    
    remove_column :racun_placanje, :tip_uplate  
    remove_column :ulazni_racun_placanje, :tip_uplate
  end
end
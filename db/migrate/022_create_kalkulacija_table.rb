class CreateKalkulacijaTable < ActiveRecord::Migration
  def self.up
    create_table :kalkulacija do |t|   
      t.column :partner_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false
      t.column :datum, :date, :null => false
      t.column :dokument, :string      
    end
    
    create_table :kalkulacija_stavka do |t|
      t.column :stavka_id, :integer
      t.column :kolicina, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :cijena, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :vrijednost, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :popust_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :fakturna_cijena, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :fakturna_vrijednost, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
            
      t.column :trosak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :nabavna_cijena, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :nabavna_vrijednost, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :marza_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :marza, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :cijena_bez_poreza, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :vrijednost_bez_poreza, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :porez_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :porez, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :cijena_s_porezom, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :vrijednost_s_porezom, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0      
    end
  end

  def self.down
    drop_table :kalkulacija
    drop_table :kalkulacija_stavka
  end
end

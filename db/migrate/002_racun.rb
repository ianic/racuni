class Racun < ActiveRecord::Migration
  def self.up
		
    create_table :stavka do |t|			
      t.column :opis, :string
      t.column :jedinica_mjere, :string			
      t.column :cijena, :decimal, :precision => 18, :scale => 4      
    end
    
    create_table :racun do |t|
      t.column :partner_id, :integer, :null => false
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false

      t.column :datum, :date, :null => false
      t.column :rok_placanja, :integer, :null => false, :default => 15
      t.column :pdv_kategorija, :string, :null => false, :default => 'II.2'
      

      t.column :osnovica, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :pdv_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 22
      t.column :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :placeno, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :placen, :boolean, :null => false, :default => 0
      
      t.column :napomena, :text     
    end
    
    create_table :gotovinski_racun do |t|
      t.column :partner_id, :integer, :null => false
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false

      t.column :datum, :date, :null => false
      t.column :rok_placanja, :integer, :null => false, :default => 15
      t.column :pdv_kategorija, :string, :null => false, :default => 'II.2'

      t.column :osnovica, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :pdv_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 22
      t.column :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
           
      t.column :napomena, :text  
    end        

    
    create_table :ulazni_racun do |t|
      t.column :partner_id, :integer, :null => false
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false
      t.column :partner_broj, :string, :null => false, :default => ''

      t.column :datum, :date, :null => false
      t.column :rok_placanja, :integer, :null => false, :default => 15      

      t.column :osnovica, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :pdv_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 22
      t.column :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :ostali_troskovi, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :placeno, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :placen, :boolean, :null => false, :default => 0
      
      t.column :tip_predporeza, :integer, :null => false, :default => 0
      t.column :tip_placanja, :integer, :null => false, :default => 0
      t.column :tip_knjizenja, :integer, :null => false, :default => 0
      t.column :pdv_kategorija, :string, :null => false, :default => 'III.2'
      
      t.column :napomena, :text    
    end
    
    create_table :ponuda do |t|
      t.column :partner_id, :integer, :null => false
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false

      t.column :datum, :date, :null => false
      t.column :rok_placanja, :integer, :null => false, :default => 3

      t.column :osnovica, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :popust, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :pdv_postotak, :decimal, :precision => 18, :scale => 4, :null => false, :default => 22
      t.column :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
      t.column :napomena, :text     
    end
		
    create_table :racun_stavka do |t|
      t.column :racun_id, :integer, :null => false
      t.column :racun_type, :string, :null => false
      t.column :stavka_id, :integer
      t.column :cijena, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :kolicina, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
    end
		
    create_table :racun_placanje do |t|
      t.column :racun_id, :integer, :null => false
      t.column :racun_type, :string, :null => false
      t.column :dokument, :string, :null => false
      t.column :datum, :date, :null => false
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false
    end			
  end

  def self.down    
    drop_table :racun_placanje
    drop_table :racun_stavka
    drop_table :racun
    drop_table :ulazni_racun
    drop_table :gotovinski_racun
    drop_table :ponuda
    drop_table :stavka
  end
end

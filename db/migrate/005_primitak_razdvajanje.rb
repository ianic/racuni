class PrimitakRazdvajanje < ActiveRecord::Migration
  def self.up
    create_table :primitak do |t|		
      t.column :partner_id, :integer
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false
      t.column :datum, :date, :null => false
      t.column :opis, :string, :null => false
      
      # 0 - na žiro
      # 1 - u gotovini
      # 2 - u naravi
      t.column :tip_uplate, :integer, :null => false, :default => 0
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      
    end
    
    execute "insert into primitak(id, partner_id, godina, broj, datum, opis, tip_uplate, iznos)
      select id, partner_id, godina, broj, datum, opis, tip_uplate, iznos  from izdatak where type = 'Primitak'"
      
    execute "delete from izdatak where type = 'Primitak'"
    
    remove_column :izdatak, :pdv
    remove_column :izdatak, :type
    remove_column :izdatak, :broj_temeljnice
  end

 def self.down        
    add_column :izdatak, :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
    add_column :izdatak, :type, :string, :null => false, :default => 'Izdatak'
    add_column :izdatak, :broj_temeljnice, :string
    execute "insert into izdatak (id, partner_id, godina, broj, datum, opis, tip_uplate, iznos, type )
             select id, partner_id, godina, broj, datum, opis, tip_uplate, iznos , 'Primitak' from primitak"
    drop_table :primitak
  end
end
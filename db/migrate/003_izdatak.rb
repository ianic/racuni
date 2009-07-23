class Izdatak < ActiveRecord::Migration
  def self.up
    create_table :izdatak do |t|		
      t.column :type, :string, :null => false, :default => 'Izdatak'
      t.column :partner_id, :integer
      t.column :godina, :integer, :null => false
      t.column :broj, :integer, :null => false
      t.column :datum, :date, :null => false
      
      t.column :broj_temeljnice, :string
      t.column :opis, :string, :null => false
      
      # 0 - na žiro
      # 1 - u gotovini
      # 2 - u naravi
      t.column :tip_uplate, :integer, :null => false, :default => 0
      
      t.column :iznos, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0
      t.column :pdv, :decimal, :precision => 18, :scale => 4, :null => false, :default => 0      
    end
  end

 def self.down    
    drop_table :izdatak
  end
end
class UserTablica < ActiveRecord::Migration
  def self.up
    create_table :user do |t|
      t.column :naziv, :string, :null => false, :default => ''
      t.column :password, :string, :null => false, :default => ''      
      t.column :zadnji_izvod, :string, :null => false, :default => ''
    end
    
    execute "insert into user(id) values (1)"
  end
 
  def self.down
    drop_table :user
  end
end

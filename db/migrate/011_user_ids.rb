class UserIds < ActiveRecord::Migration

  def self.up
    
    add_column :partner,            :user_id, :integer, :null => false, :default => -1
    
    add_column :racun,              :user_id, :integer, :null => false, :default => -1
    add_column :ulazni_racun,       :user_id, :integer, :null => false, :default => -1
    add_column :ponuda,             :user_id, :integer, :null => false, :default => -1
    
    add_column :stavka,             :user_id, :integer, :null => false, :default => -1
    add_column :izdatak,            :user_id, :integer, :null => false, :default => -1
    add_column :primitak,           :user_id, :integer, :null => false, :default => -1
    
    execute "update partner set user_id = 1"
    
    execute "update racun set user_id = 1"       
    execute "update ponuda set user_id = 1"
    execute "update ulazni_racun set user_id = 1"
    
    execute "update stavka set user_id = 1"
    execute "update izdatak set user_id = 1"
    execute "update primitak set user_id = 1"
    
  end

 def self.down    
    
    remove_column :racun,              :user_id
    remove_column :ulazni_racun,       :user_id
    remove_column :ponuda,             :user_id
    
    remove_column :partner,            :user_id
    remove_column :stavka,             :user_id
    
    remove_column :izdatak,            :user_id
    remove_column :primitak,           :user_id
    
  end
  
end
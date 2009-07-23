class CreatedAtUpdatedAt < ActiveRecord::Migration
  def self.up
    add_column :racun_placanje, :created_at, :timestamp
    
    add_column :ulazni_racun_placanje, :created_at, :timestamp
    
    add_column :racun, :created_at, :timestamp
    add_column :racun, :updated_at, :timestamp
    
    add_column :ulazni_racun, :created_at, :timestamp
    add_column :ulazni_racun, :updated_at, :timestamp
    
    add_column :ponuda, :created_at, :timestamp
    add_column :ponuda, :updated_at, :timestamp
    
    add_column :gotovinski_racun, :created_at, :timestamp
    add_column :gotovinski_racun, :updated_at, :timestamp
    
    add_column :izdatak, :created_at, :timestamp
    add_column :izdatak, :updated_at, :timestamp    
    
    add_column :primitak, :created_at, :timestamp
    add_column :primitak, :updated_at, :timestamp
    
    add_column :partner, :created_at, :timestamp
    add_column :partner, :updated_at, :timestamp
    
    add_column :stavka, :created_at, :timestamp
    add_column :stavka, :updated_at, :timestamp
  end
  
  def self.down    
    remove_column :racun_placanje, :created_at  
    
    remove_column :ulazni_racun_placanje, :created_at  
    
    remove_column :racun, :created_at  
    remove_column :racun, :updated_at
    
    remove_column :ulazni_racun, :created_at  
    remove_column :ulazni_racun, :updated_at
    
    remove_column :ponuda, :created_at  
    remove_column :ponuda, :updated_at
    
    remove_column :gotovinski_racun, :created_at  
    remove_column :gotovinski_racun, :updated_at
    
    remove_column :izdatak, :created_at  
    remove_column :izdatak, :updated_at  
    
    remove_column :primitak, :created_at  
    remove_column :primitak, :updated_at  
    
    remove_column :partner, :created_at  
    remove_column :partner, :updated_at    
    
    remove_column :stavka, :created_at  
    remove_column :stavka, :updated_at
  end
end
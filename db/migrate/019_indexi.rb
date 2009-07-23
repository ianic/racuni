class Indexi < ActiveRecord::Migration
  def self.up      
    add_index :partner, :user_id
    add_index :ponuda, :user_id
    add_index :racun, :user_id
    add_index :primitak, :user_id
    add_index :izdatak, :user_id
    add_index :ulazni_racun, :user_id
    add_index :stavka, :user_id
        
    add_index :ponuda, :partner_id
    add_index :racun, :partner_id
    add_index :primitak, :partner_id
    add_index :izdatak, :partner_id
    add_index :ulazni_racun, :partner_id
    
    add_index :ponuda, :godina
    add_index :racun, :godina
    add_index :primitak, :godina
    add_index :izdatak, :godina
    add_index :ulazni_racun, :godina
    
    add_index :ponuda, :broj
    add_index :racun, :broj
    add_index :primitak, :broj
    add_index :izdatak, :broj
    add_index :ulazni_racun, :broj
                
    add_index :racun_stavka, :racun_id
    add_index :racun_stavka, :racun_type
    add_index :racun_stavka, :stavka_id    
    
    add_index :racun_placanje, :racun_id 
    add_index :ulazni_racun_placanje, :ulazni_racun_id 

    add_index :partner, :naziv
    add_index :stavka, :opis    
  end

  def self.down
    remove_index :partner, :user_id
    remove_index :ponuda, :user_id
    remove_index :racun, :user_id
    remove_index :primitak, :user_id
    remove_index :izdatak, :user_id
    remove_index :ulazni_racun, :user_id
    remove_index :stavka, :user_id

    remove_index :ponuda, :partner_id
    remove_index :racun, :partner_id
    remove_index :primitak, :partner_id
    remove_index :izdatak, :partner_id
    remove_index :ulazni_racun, :partner_id

    remove_index :ponuda, :godina
    remove_index :racun, :godina
    remove_index :primitak, :godina
    remove_index :izdatak, :godina
    remove_index :ulazni_racun, :godina

    remove_index :ponuda, :broj
    remove_index :racun, :broj
    remove_index :primitak, :broj
    remove_index :izdatak, :broj
    remove_index :ulazni_racun, :broj
        
    remove_index :racun_stavka, :racun_id
    remove_index :racun_stavka, :racun_type
    remove_index :racun_stavka, :stavka_id    

    remove_index :racun_placanje, :racun_id 
    remove_index :ulazni_racun_placanje, :ulazni_racun_id 

    remove_index :partner, :naziv
    remove_index :stavka, :opis 
  end
end

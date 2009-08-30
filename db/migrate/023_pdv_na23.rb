class PdvNa23 < ActiveRecord::Migration
  def self.up  
    execute "alter table racun alter pdv_postotak drop default;"
    execute "alter table racun alter pdv_postotak set default 23;"
    
    execute "alter table ulazni_racun alter pdv_postotak drop default;"
    execute "alter table ulazni_racun alter pdv_postotak set default 23;"
    
    execute "alter table gotovinski_racun alter pdv_postotak drop default;"
    execute "alter table gotovinski_racun alter pdv_postotak set default 23;"
    
    execute "alter table ponuda alter pdv_postotak drop default;"
    execute "alter table ponuda alter pdv_postotak set default 23;"


    execute "alter table racun modify napomena text null;"
    execute "alter table ulazni_racun modify napomena text null;"
    execute "alter table gotovinski_racun modify napomena text null;"    
    execute "alter table ponuda modify napomena text null;"
    
  end

  def self.down
  end
end

class PdvNa25 < ActiveRecord::Migration
  def self.up  
    execute "alter table racun alter pdv_postotak drop default;"
    execute "alter table racun alter pdv_postotak set default 25;"
    
    execute "alter table ulazni_racun alter pdv_postotak drop default;"
    execute "alter table ulazni_racun alter pdv_postotak set default 25;"
    
    execute "alter table gotovinski_racun alter pdv_postotak drop default;"
    execute "alter table gotovinski_racun alter pdv_postotak set default 25;"
    
    execute "alter table ponuda alter pdv_postotak drop default;"
    execute "alter table ponuda alter pdv_postotak set default 25;"
  end

  def self.down
  end
end

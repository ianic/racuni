class UserRacunHeaderFooter < ActiveRecord::Migration
  def self.up
    add_column :user, :racun_header, :text
    add_column :user, :racun_footer, :text 
            
    nektar = User.find(1)    
    
    nektar.racun_header = "
<div class='naziv'>NEKTAR pčelarski obrt</div> 
<div>Kralja Zvonimira 12, 32221 Nuštar</div> 
<div>ured: Žugci 5b, 10431 Sveta Nedjelja</div> 
<div> 
  <span class='note'>JMBG:</span> 
  0112972302824
  <span class='note'>OIB:</span> 
  90955732444
</div> 
<div> 
  <span class='note'>matični broj obrta:</span> 
  92388086
</div> 
<div> 
  <span class='note'>žiro račun:</span> 
  2340009-1160108280
</div>"

  nektar.racun_footer = "
tel: 01/3385 474,
fax: 01/3385 473,
gsm: 091 253 82 60,
e-mail:nektar@nektar.hr
web:www.nektar.hr"

  nektar.save

  end

  def self.down
    remove_column :user, :racun_header
    remove_column :user, :racun_footer
  end
end

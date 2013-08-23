# encoding: utf-8

class TestPodaci

  def initialize(user_id)
    @user = User.find(user_id)
    @izvod_broj = 1
    @start_date = Date.today - 100
    self
  end
  
  def user
    @user = User.new 
    no = User.maximum("id") + 1
    @user.naziv = "test_#{no}"
    @user.password = @user.naziv 
    @user.save
  end
  
  def partneri    
    (0..9).each do |idx| 
      %w(Alfa Beta Gama Delta Epsilon Zeta Eta Teta Jota Kapa Lambda Mi Ni Ksi Omikron Pi Ro Sigma Tau Ipsilon Fi Hi Psi Omega).each do |n|
        @user.partneri.create(:naziv => "#{n} #{idx}", 
          :adresa => "adresa",
          :mjesto => "mjesto i poštanski broj",
          :tel => "tel",
          :fax => "fax",
          :porezni_broj => "porezni broj",
          :ziro_racun => "žiro račun",
          :kontakt => "kontakt osoba",
          :email => "email adresa")
      end
    end
  end
  
  def racuni 
    d = @start_date
    while (d < Date.today)  
      r = @user.racuni.build  
      upisi_racun(r, d)
      upisi_stavke(r)
      upisi_placanje(r)
      d += 1
    end
  end
  
  def ponude 
    d = @start_date
    while (d < Date.today)   
      r = @user.ponude.build 
      upisi_racun(r, d)
      upisi_stavke(r)
      d += 7
    end
  end
  
  def ulazni_racuni 
    d = @start_date
    while (d < Date.today)    
      r = @user.ulazni_racuni.build
      upisi_racun(r, d)
      upisi_stavke(r)
      upisi_placanje(r)
      d += 2
    end
  end
  
  def upisi_racun(r, d)
    r.partner_id = rand_partner.id
    r.datum = d
    r.save
  end
  
  def upisi_stavke(r)
    (-1..rand(5)).each do
      stavka = rand_stavka
      r.stavke.create(:stavka_id => stavka.id, :cijena => stavka.cijena, :kolicina => rand(20))
    end
    r.izracunaj_iznose
    r.save
  end
  
  def upisi_placanje(r)
    return if r.datum + 15 >= Date.today      
    if r.iznos > 1000
      r.placanja.create(:dokument => "izvod FINA-e broj #{@izvod_broj}", :iznos => 1000, :datum => r.datum + 15)
      if r.datum + 30 < Date.today 
        r.placanja.create(:dokument => "izvod FINA-e broj #{@izvod_broj}", :iznos => r.iznos - 1000, :datum => r.datum + 30)
      end
    else
      r.placanja.create(:dokument => "izvod FINA-e broj #{@izvod_broj}", :iznos => r.iznos, :datum => r.datum + 15)
    end
    r.save
    @izvod_broj += 1
  end
  
  def rand_partner
    @user.partneri[rand(10)]
  end
  
  def rand_stavka
    @user.stavke[rand(@user.stavke.size)]
  end
  
  def stavke 
    (0..9).each do |idx| 
      @user.stavke.create(:opis => "#{idx} Lorem ipsum dolor sit amet, consectetuer adipiscing elit...", 
        :jedinica_mjere => "kom",
        :cijena => rand(100))
    end
  end
  
  def kreiraj
    partneri
    stavke
    racuni
    ulazni_racuni
    ponude
  end
  
  def brisi
    User.connection.execute "delete from partner where user_id = #{@user.id}"
    User.connection.execute "delete from stavka where user_id = #{@user.id}"
    @user.racuni.each{|r| r.destroy }
    @user.ulazni_racuni.each{|r| r.destroy }
    @user.ponude.each{|r| r.destroy }
  end
  
end
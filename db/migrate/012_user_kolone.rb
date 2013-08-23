# encoding: utf-8

class UserKolone < ActiveRecord::Migration

  def self.up
    
    add_column :user, :username, :string, :default => ""    
    add_column :user, :adresa, :string, :default => ""
    add_column :user, :mjesto, :string, :default => ""
    add_column :user, :porezni_broj, :string, :default => ""
    add_column :user, :mbo, :string, :default => ""
    add_column :user, :ziro_racun, :string, :default => ""
    
    add_column :user, :racun_footer_1, :string, :default => ""
    add_column :user, :racun_footer_2, :string, :default => ""
    add_column :user, :racun_footer_3, :string, :default => ""
    
    
    execute "update user set username = naziv"
    
    @user = User.find(1)
    @user.naziv = "NEKTAR pčelarski obrt"
    @user.mjesto = "Kralja Zvonimira 12, 32221 Nuštar"
    @user.adresa = "Žugci 5b, 10431 Sveta Nedjelja, Novaki"
    
    @user.porezni_broj = "0112972302824"
    @user.mbo = "92388086"
    @user.ziro_racun = "2340009-1160108280"
    
    @user.racun_footer_1 = "NEKTAR pčelarski obrt i proizvodnja alkoholnih pića, Kralja Zvonimira 12 32221 Nuštar, Žugci 5B 10431 Sveta Nedjelja Novaki"
    @user.racun_footer_2 = "telefon: 01/33 85 472, 032/38 67 02 fax: 01/33 85 473 gsm: 091/25 38 260"
    @user.racun_footer_3 = "JMBG: 0112972302824, MBO: 92388086, ŽIRO RAČUN: 2340009-1160108280"
    
    @user.save
    
  end

 def self.down    
    
    remove_column :user, :username
    remove_column :user, :adresa
    remove_column :user, :mjesto
    remove_column :user, :porezni_broj
    remove_column :user, :mbo
    remove_column :user, :ziro_racun
    
    remove_column :user, :racun_footer_1
    remove_column :user, :racun_footer_2
    remove_column :user, :racun_footer_3
    
  end
  
end
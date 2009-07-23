class Partner < ActiveRecord::Migration
  def self.up
    create_table :partner do |t|
      t.column :naziv, :string 

      t.column :adresa, :string
      t.column :mjesto, :string

      t.column :tel, :string
      t.column :fax, :string 

      t.column :porezni_broj, :string
      t.column :ziro_racun, :string

      t.column	:kontakt, :string
      t.column	:email, :string
    end
  end
 
  def self.down
    drop_table :partner
  end
end

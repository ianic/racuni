class PartnerMjestoTroska < ActiveRecord::Migration
  def self.up
    add_column :partner, :mjesto_troska, :string
  end

  def self.down
    remove_column :partner, :mjesto_troska
  end
end

class PartnerOib < ActiveRecord::Migration
  def self.up
    add_column :partner, :oib, :string
  end

  def self.down                       
    remove_column :partner, :oib
  end
end

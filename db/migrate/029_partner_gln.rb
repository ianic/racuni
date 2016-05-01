class PartnerGln < ActiveRecord::Migration
  def self.up
    add_column :partner, :gln, :string
  end

  def self.down
    remove_column :partner, :gln
  end
end

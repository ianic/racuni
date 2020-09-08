class Lot < ActiveRecord::Migration
  def self.up
    add_column :racun_stavka, :lot, :string
  end

  def self.down
    remove_column :racun_stavka, :lot
  end
end

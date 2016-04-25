class RacunBrojNarudzbe < ActiveRecord::Migration
  def self.up
    add_column :racun, :broj_narudzbe, :string
  end

  def self.down
    remove_column :racun, :broj_narudzbe
  end
end

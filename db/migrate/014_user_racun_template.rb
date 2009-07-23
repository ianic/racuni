class UserRacunTemplate < ActiveRecord::Migration
  def self.up
    add_column :user, :racun_template, :string, :default => "nektar"
   end

  def self.down
    remove_column :user, :racun_template
  end
end

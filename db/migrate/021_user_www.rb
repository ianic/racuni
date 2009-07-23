class UserWww < ActiveRecord::Migration
  def self.up
    add_column :user, :www, :string
  end

  def self.down
    remove_column :user, :www
  end
end

class UserGodinaOd < ActiveRecord::Migration
  def self.up
    add_column :user, :godina_od, :integer, :default => (Date.today.year-1)
    execute "update user u set godina_od = (select min(godina) from racun where user_id = u.id) where id in (select distinct user_id from racun)"
  end

  def self.down
    remove_column :user, :godina_od
  end
end

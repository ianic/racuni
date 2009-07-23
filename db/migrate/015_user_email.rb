class UserEmail < ActiveRecord::Migration
  def self.up    
    add_column :user, :tel, :string
    add_column :user, :fax, :string
    add_column :user, :gsm, :string
    add_column :user, :email, :string
   end

  def self.down
    remove_column :user, :tel
    remove_column :user, :fax
    remove_column :user, :gsm
    remove_column :user, :email
  end
end

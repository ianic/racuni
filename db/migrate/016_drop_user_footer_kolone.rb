class DropUserFooterKolone < ActiveRecord::Migration

  def self.up
    remove_column :user, :racun_footer_1
    remove_column :user, :racun_footer_2
    remove_column :user, :racun_footer_3
  end

 def self.down        
    add_column :user, :racun_footer_1, :string, :default => ""
    add_column :user, :racun_footer_2, :string, :default => ""
    add_column :user, :racun_footer_3, :string, :default => ""
  end
  
end
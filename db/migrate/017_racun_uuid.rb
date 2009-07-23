require 'uuidtools'

class RacunUuid < ActiveRecord::Migration
  class Racun< ActiveRecord::Base; end
  class Ponuda< ActiveRecord::Base; end
  
  def self.up
    add_column :racun, :uuid, :string
    add_column :ponuda, :uuid, :string

    Racun.find(:all).each{ |r| r.update_attribute('uuid', UUID.random_create.to_s)}
    Ponuda.find(:all).each{ |r| r.update_attribute('uuid', UUID.random_create.to_s)}
  end

  def self.down
    remove_column :racun, :uuid
    remove_column :ponuda, :uuid
  end
end

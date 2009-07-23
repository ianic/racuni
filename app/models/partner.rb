class Partner < ActiveRecord::Base

  belongs_to :user
  validates_length_of :naziv, :minimum => 1
  
  has_many :racuni
  has_many :ulazni_racuni
  has_many :ponude
  has_many :izdaci
  has_many :primici
  
  #has_many :stavke, :finder_sql => 'select * from partner_stavka where partner_id = #{id}'  
  
  def slovo
		naziv.match(/^./).to_s.upcase
  end
  
  def dokumenti
    racuni + ulazni_racuni + ponude + izdaci + primici
  end
  
end

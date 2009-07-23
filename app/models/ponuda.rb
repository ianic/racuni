class Ponuda < ActiveRecord::Base		  
  include RacunCommon
  
  belongs_to :user
  belongs_to :partner
  has_many :stavke,   :class_name => 'RacunStavka',   :dependent => :destroy, :order => 'id',   :as => :racun
  
  validates_presence_of :partner_id
  validates_inclusion_of :popust_postotak, :in=>0..100
  validates_inclusion_of :pdv_postotak, :in=>0..100

end

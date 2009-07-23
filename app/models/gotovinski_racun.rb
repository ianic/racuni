class GotovinskiRacun < ActiveRecord::Base
  include RacunCommon
  
  belongs_to :partner
  has_many :stavke,   :class_name => 'RacunStavka',   :dependent => :destroy, :order => 'id',   :as => :racun
  
  validates_presence_of :partner_id
  validates_inclusion_of :popust_postotak, :in => 0..100
  validates_inclusion_of :pdv_postotak, :in => 0..100
  
  def kpi
    Primitak.new(:opis => "IR Gotovinski #{broj_dokumenta}",
      :broj_temeljnice => broj_dokumenta,
      :datum => datum,
      :tip_uplate => 1,
      :iznos => iznos,
      :pdv => pdv)
  end
  
  #zbog kira
  def racun
    self
  end
  
end

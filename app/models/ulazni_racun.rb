class UlazniRacun < ActiveRecord::Base
  include RacunCommon

  belongs_to :user
  belongs_to :partner
  has_many :stavke, :class_name => 'RacunStavka', :dependent => :destroy, :order => 'id', :as => :racun
  has_many :placanja, :class_name => 'UlazniRacunPlacanje',
    :dependent => :destroy, :order => 'datum',
    :after_add => :update_placeno, :after_remove => :update_placeno

  validates_presence_of  :partner_id
  validates_inclusion_of :popust_postotak, :in => 0..100
  validates_inclusion_of :pdv_postotak, :in => 0..100

  def pdv_moze_se_odbiti
    tip_predporeza == 0 ? pdv : 0
  end

  def pdv_nemoze_se_odbiti
    tip_predporeza == 1 ? pdv : 0
  end

  def kpi
    if tip_knjizenja < 2
      Izdatak.new(:opis => "UR #{broj_dokumenta}",
        :broj_temeljnice => partner_broj,
        :datum => datum,
        :tip_uplate => 1,
        :iznos => tip_knjizenja == 0 ? iznos : 0,
        :pdv => pdv)
    end
  end

end

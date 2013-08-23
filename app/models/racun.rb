# encoding: utf-8

class Racun < ActiveRecord::Base
  include RacunCommon

  belongs_to :user
  belongs_to :partner
  has_many :stavke,   :class_name => 'RacunStavka',   :dependent => :destroy, :order => 'id',   :as => :racun
  has_many :placanja, :class_name => 'RacunPlacanje',
    :dependent => :destroy, :order => 'datum',
    :after_add => :update_placeno, :after_remove => :update_placeno

  validates_presence_of :partner_id
  validates_inclusion_of :popust_postotak, :in => 0..100
  validates_inclusion_of :pdv_postotak, :in => 0..100

  TIP_PLACANJA = [
                  ["bezgotovinsko", 0],
                  ["gotovinsko", 1]
  ]

  TIP_PREDPOREZA = [
                    ["PDV može se odbiti", 0],
                    ["PDV ne može se odbiti", 1]
  ]

  TIP_KNJIZENJA = [
                   ["Izdatak (svi redovni računi)", 0],
                   ["Samo PDV u KPI (uvoz...)", 1],
                   ["Ne ide u KPI (dugotrajna imovina...)", 2]
  ]

  KATEGORIJA_POREZA = [
    "I.1.", "I.2.1", "I.2.2", "I.2.3", "I.3",
    "II.1", "II.2", "II.3", "II.4"  ]

  KATEGORIJA_PREDPOREZA = [
    "III.1", "III.2", "III.3", "III.4", "III.5"  ]

  def slijedeci_broj
    zadnji = self.class.maximum(:broj, :conditions => "godina = #{self.godina} and tip_placanja = #{self.tip_placanja} and user_id = #{self.user_id}")
        zadnji ? zadnji.to_i + 1 : 1
  end

end

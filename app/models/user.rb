class User < ActiveRecord::Base
  validates_length_of :naziv, :minimum => 1

  has_many :partneri

  has_many :racuni
  has_many :ulazni_racuni
  has_many :ponude

  has_many :stavke

  has_many :izdaci
  has_many :primici

  has_many :placanja, :through => :racuni, :order => "datum, id desc"

  has_many :ulazni_placanja, :through => :ulazni_racuni, :source => :placanja, :order => "datum, id desc"

  def stavka(opis, jedinica_mjere, cijena)
    opis.strip!
    jedinica_mjere.strip!
    stavka = stavke.find_by_opis_and_jedinica_mjere(opis, jedinica_mjere) 
    if stavka
      stavka.update_attribute(:cijena, cijena)
    else
      stavka = stavke.create(:opis => opis, :jedinica_mjere => jedinica_mjere, :cijena => cijena)
    end
    stavka
  end

end

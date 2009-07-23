require 'facets/core/float/round_at'

class RacunStavka < ActiveRecord::Base
  belongs_to :racun, :polymorphic => true
  belongs_to :stavka
  
  validates_numericality_of :kolicina
  validates_numericality_of :cijena
  validates_exclusion_of :kolicina, :in => 0..0
  
  def iznos
    (kolicina.to_f * cijena.to_f).round_at(2)
  end
  
  def opis
    stavka ? stavka.opis : "[odaberite stavku]"
  end
  
  def jedinica_mjere
    stavka ? stavka.jedinica_mjere : "kom"
  end

end



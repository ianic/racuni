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

  def ima_sifru?
    stavka.opis.include?('#') rescue false
  end

  def sifra
    stavka.opis.split('#')[1].strip if ima_sifru?
  rescue
    nil
  end

  def opis_bez_sifre
    ima_sifru? ? stavka.opis.split('#')[0].strip : opis
  end

end

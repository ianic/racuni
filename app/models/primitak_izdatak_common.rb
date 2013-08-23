module PrimitakIzdatakCommon
  include Dokument

  extend ActiveSupport::Concern

  included do
    before_save :before_save
    after_initialize :after_initialize
  end

  def primitak?
    return true if self.class == Primitak
  end

  def u_gotovini
    iznos  if tip_uplate == 1
  end

  def na_ziro
    iznos  if tip_uplate == 0
  end

  def u_naravi
    iznos  if tip_uplate == 2
  end

  def ukupno
    iznos - pdv if iznos
  end

  def izvod_dokument
    self
  end

  def izvod_opis
    opis
  end

  def pdv=(value)
    @pdv = value
  end

  def pdv
    @pdv || 0
  end

  def broj_temeljnice=(value)
    @broj_temeljnice = value
  end

  def broj_temeljnice
    @broj_temeljnice || broj_dokumenta
  end

end

class UlazniRacunPlacanje < ActiveRecord::Base
  include PlacanjeCommon
  belongs_to :ulazni_racun

  def racun
    self.ulazni_racun
  end

  def kpi
    if racun.tip_knjizenja < 2
      Izdatak.new(:opis => "UR #{racun.broj_dokumenta}, #{dokument}",
        :broj_temeljnice => racun.partner_broj,
        :datum => datum,
        :tip_uplate => tip_uplate,
        :iznos => racun.tip_knjizenja == 0 ? iznos : nil,
        :pdv => pdv)
    end
  end

end

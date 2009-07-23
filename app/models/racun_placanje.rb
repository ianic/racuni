class RacunPlacanje < ActiveRecord::Base
  include PlacanjeCommon
  belongs_to :racun

  def kpi
    Primitak.new(
      :opis => racun.tip_placanja == 1 ? "IR Gotovinski #{racun.broj_dokumenta}" : "IR #{racun.broj_dokumenta}, #{dokument}",
      :broj_temeljnice => racun.broj_dokumenta,
      :datum => datum,
      :tip_uplate => tip_uplate,
      :iznos => iznos,
      :pdv => pdv)
  end

end

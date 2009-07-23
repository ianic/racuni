module DictionaryHelper

  def naziv_dokumenta(c)
    if c.class == Racun
      tip = c.gotovinski? ? "Gotovinski Račun" : "Izlazni Račun"
    else
      tip = tip_dokumenta c.class
    end
    "#{tip} #{c.broj_dokumenta}"
  end

  def tip_dokumenta(c)
    return "Račun"               if c == Racun
    return "Ulazni Račun"        if c == UlazniRacun
    return "Gotovinski Račun"    if c == GotovinskiRacun
    return "Ponuda"              if c == Ponuda
    c.to_s
  end

  def naziv_partnera(c)
    return "Dobavljač"  if c == UlazniRacun
    return "Uplatitelj" if c == Primitak
    return "Primatelj"  if c == Izdatak
    "Kupac"
  end

  def racuni_naziv(c)
    return "Računi"               if c == Racun
    return "Ulazni Računi"        if c == UlazniRacun
    return "Gotovinski Računi"    if c == GotovinskiRacun
    return "Ponude"               if c == Ponuda
 end

end

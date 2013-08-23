# -*- coding: utf-8 -*-
module RacunHelper

  def partner_naziv(racun)
    naziv_partnera(racun.class)
  end

  def racun_broj(racun)
    render :partial => "racun/table_col_broj", :locals => { :racun => racun }
  end

  def div_iznos(value)
    render_div_iznos value, '', 'Iznos'
  end

  def div_placeni_iznos(value)
    render_div_iznos value, 'iznos_placeno', 'Plaćeni iznos'
  end

  def div_neplaceni_iznos(value, kasni)
    if kasni
      render_div_iznos value, 'iznos_dospjelo', 'Iznos za naplatu - DOSPJELO'
    else
      render_div_iznos value, 'iznos_nije_dospjelo', 'Iznos za naplatu - NIJE DOSPJELO'
    end
  end

  def div_neplaceni_iznos2(value)
    render_div_iznos value, 'iznos_dospjelo', 'Iznos za naplatu'
  end

  def render_div_iznos(value, css_class, tooltip)
    return "" if value.to_f < 0.01 and value.to_f > -0.01
    "<div class='#{css_class}' title='#{tooltip}'>#{m(value)}</div>".html_safe
  end

  #funkcija ShowRacunPopup iz racun/_popup_js.rhtml će zamjeniti
  #  - 1234 sa id-jem računa
  #  - 5678 sa id-jem partnera
  #  - broj_racuna sa brojem dokumenta
  def popup_links_izlazni
    links = Array.new
    links << link_to("Izmjeni", :action => "edit", :id => 1234)
    links << link_to("Ispiši", :action => "view", :id => 1234)
    links << "<a href='/9999'>Vanjski link</a>".html_safe
    links << nil
    links << link_to("Svi računi kupca", :action => "pregled", :partner_id => 5678)
    links << link_to("Neplaćeni računi kupca", :action => "pregled", :partner_id => 5678, :godina => '...', :placanje => 2)
    links << nil
    links << link_to("Novi račun", :action => "new")
    links << link_to("Novi račun kupca", :action => "new", :partner_id => 5678)
    links << link_to("Novi gotovinski račun kupca", :action => "new_gotovinski", :partner_id => 5678)
    links << link_to("Kopiraj račun broj_racuna u novi", {:action => "copy", :id => 1234}, :confirm => "Kopiranje računa?")
    links
  end

  def popup_links_ulazni
    links = Array.new
    links << link_to("Izmjeni", :action => "edit", :id => 1234)
    links << nil
    links << link_to("Svi računi dobavljača", :action => "pregled", :partner_id => 5678)
    links << link_to("Neplaćeni računi dobavljača", :action => "pregled", :partner_id => 5678, :godina => '...', :placanje => 2)
    links << nil
    links << link_to("Novi račun", :action => "new")
    links << link_to("Novi račun dobavljača", :action => "new", :partner_id => 5678)
    links << link_to("Kopiraj račun broj_racuna u novi", {:action => "copy", :id => 1234}, :confirm => "Kopiranje računa?")
    links
  end

  def popup_links_ponuda
    links = Array.new
    links << link_to("Izmjeni", :action => "edit", :id => 1234)
    links << link_to("Ispiši", :action => "view", :id => 1234)
    links << "<a href='/9999'>Vanjski link</a>".html_safe
    links << nil
    links << link_to("Sve ponude kupca", :action => "pregled", :partner_id => 5678)
    links << link_to("Svi računi kupca", :controller => "racun", :action => "pregled", :partner_id => 5678)
    links << link_to("Neplaćeni računi kupca", :controller => "racun", :action => "pregled", :partner_id => 5678, :godina => '...', :placanje => 2)
    links << nil
    links << link_to("Nova ponuda", :action => "new")
    links << link_to("Nova ponuda kupca", :action => "new", :partner_id => 5678)
    links << link_to("Kopiraj ponudu broj_racuna u novi račun", {:action => "copy_u_racun", :id => 1234}, :confirm => "Kopiranje u račun?")
    links
  end

  def ima_placanja?(racun = nil)
    return (@model_class == UlazniRacun || @model_class == Racun) if  racun == nil
    if racun.class == UlazniRacun || racun.class == Racun
      return racun.tip_placanja == 0
    end
    false
  end

end

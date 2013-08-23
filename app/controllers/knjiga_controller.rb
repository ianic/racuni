# encoding: utf-8

class KnjigaController < ApplicationController

  def read_params
    @godina = (params[:godina] || Date.today.year).to_i
  end
  
  def kira
    @title = "Knjiga Izlaznih Računa #{@godina} godina"
  	@racuni = placanja
  	@sume = sumiraj(@racuni, ['iznos', 'bez_poreza', 'pdv'])
  	(export_excel_xml("knjiga/kira_export") and return) if csv?
  end
  
  def kura
    @title = "Knjiga Ulaznih Računa #{@godina} godina"    
    @placanja = ulazni_placanja
  	@sume = sumiraj(@placanja, ['bez_poreza', 'iznos', 'porezna_osnovica', 'pdv', 'pdv_moze_se_odbiti', 'pdv_nemoze_se_odbiti'])
  	(export_excel_xml("knjiga/kura_export") and return) if csv?
  end
  
  def placanja
    @user.placanja.find(:all, :conditions => ["year(racun_placanje.datum) = ?", @godina])
  end
  
  def ulazni_placanja
    @user.ulazni_placanja.find(:all, :conditions => ["year(ulazni_racun_placanje.datum) = ?", @godina])
  end
  
  def kpi
    @title = "Knjiga Primitaka i Izdataka #{@godina} godina"
    
    #ulazni i izlazni računi
    @kpi =  placanja.map{ |p| p.kpi }
    @kpi += ulazni_placanja.map{ |p| p.kpi }
    #primici i izdaci  
    @kpi += @user.izdaci.find(:all, :conditions => ["godina = ?", @godina])
    @kpi += @user.primici.find(:all, :conditions => ["godina = ?", @godina])
    
    @kpi = @kpi.compact.sort{|a,b| a.datum <=> b.datum}
    
    (export_excel_xml("knjiga/kpi_export") and return) if csv?
  end
  
  def pdv
    @title = "PDV obrazac"
    
    racuni = @user.placanja.find(:all, :conditions => godina_mjesec("racun_placanje"))
    @racuni_iznosi = sumiraj_po_kategoriji_poreza(racuni)  
    
    ulazni_racuni = @user.ulazni_placanja.find(:all, :conditions => godina_mjesec("ulazni_racun_placanje")) 
    @ulazni_racuni_iznosi = sumiraj_po_kategoriji_poreza(ulazni_racuni)  
  end
  
  private
  
  def godina_mjesec(prefix)
    c = FindConditionsHelper.new
    c.godina = @godina 
    c.mjesec = @mjesec
    c.where.gsub("datum", "#{prefix}.datum")
  end
  
  def sumiraj_po_kategoriji_poreza(racuni)
    iznosi = Hash.new
    racuni.each do |racun|
	    oznake = racun.pdv_kategorija.split('.')
	    (0..(oznake.size-1)).each do |idx|
		    key = oznake[0..idx].join('.')
		    if iznosi.include?(key)
			    iznosi[key][:iznos] += racun.bez_poreza
			    iznosi[key][:pdv] += racun.pdv
		    else
			    iznosi[key] = {:iznos => racun.bez_poreza, :pdv => racun.pdv}
		    end
	    end	
    end
    iznosi
  end
  
  def sumiraj(collection, colum_names)
    sume = Hash.new
    colum_names.each{|name| sume[name] = 0.0 }
    collection.each do|item|
      colum_names.each{|name| sume[name] += item.send(name)}
    end
    sume
  end
end

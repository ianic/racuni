module RacunPregled

  def pregled
    conditions = racun_filter_params
    @title = @title || racuni_naziv(@model_class)   
  	@racuni_pages, @racuni = paginate( 
  		:racuni, 
  		:class_name => @model_class.to_s,    
  		:order => 'datum desc, broj desc', 
  		:conditions => conditions,
  		:per_page => csv? ? 2147483647 : @per_page
  		)
  	@sume = Racun.connection.select_one("select sum(osnovica) osnovica, 
  	  sum(popust) popust, 
  	  sum(pdv) pdv, 
  	  sum(iznos) iznos, " +
      (@model_class != Ponuda ? "sum(placeno) placeno, sum(iznos - placeno) neplaceno," : "") +
  	  "count(*) broj 
  	  from #{@model_class.table_name}" + 
  	  (conditions ? " where #{conditions}" : "")
      )
    
    (export and return) if csv?   
  end
  
  def pregled_stavki  
    @title = @title || "#{racuni_naziv(@model_class)} - stavke" 
    
    racun_conditions = racun_filter_params   
    @stavka = params["stavka"]
    
    conditions = "racun_type = '#{@model_class}'" +
  		  ( racun_conditions ? " and racun_id in (select id from #{@model_class.table_name} where #{racun_conditions})" : "" ) +
  		  ( @stavka ? " and stavka_id in (select id from stavka where opis like '%#{@stavka.strip}%')" : "")
    
    @sume = Racun.connection.select_one("select count(*) broj, 
      sum(kolicina) kolicina,
      avg(cijena) cijena,
      sum(kolicina * cijena) iznos 
      from racun_stavka 
      where #{conditions}")
    
    @stavke_pages, @stavke = paginate( 
  		:stavke,  
  		:class_name => "RacunStavka",    
  		:order => 'racun_id desc', 
  		:conditions => conditions,
  		:per_page => csv? ? 2147483647 : @per_page,
  		:include => [:stavka]
  		)
      
      if csv?   
        export_table(%w(BROJ DATUM KUPAC OPIS KOLICINA CIJENA IZNOS),
          @stavke.map{ |stavka| [
            stavka.racun.broj, 
            stavka.racun.datum,
            stavka.racun.partner.naziv,              
            stavka.opis, 
            stavka.kolicina, 
            stavka.cijena,            
            stavka.iznos] })
        return
      else
        render :template => "racun/pregled_stavki"
      end
  end
  
  private
 
  def export
    export_table(
      %w(BROJ KUPAC DATUM DOSPJEĆE OSNOVICA POPUST PDV IZNOS),
      @racuni.map{ |racun| [
          racun.broj, 
          racun.partner.naziv, 
          racun.datum, 
          racun.dospjece, 
          racun.osnovica, 
          racun.popust,
          racun.pdv, 
          racun.iznos] }
      ) 
  end
end


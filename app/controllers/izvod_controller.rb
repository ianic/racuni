class IzvodController < ApplicationController

  def index
    @title = "Uplate i Isplate"
    
    @godina = Date.today.year
    @mjesec = Date.today.month.to_s
    
		uplate_isplate_po_danima      
  end
  
  def dani      
    uplate_isplate_po_danima
    render :update do |page|
      page.replace "dani", :partial => 'dani'
		  page.visual_effect :highlight, "dani"
    end   
  end
  
  def uplate_isplate
    @datum = parse_date
    uplate_isplate_na_dan
    render :update do |page|
      page.replace_html "uplate_isplate", :partial => 'uplate_isplate'
		  page.visual_effect :highlight, "uplate_isplate"
    end   
  end
  
  private                          
  
  def parse_date       
    #zato sto params[:datum].to_date nije prolazio na Ruby 1.8.6 greska: can't modify frozen string
    parts = params[:datum].split("-")
    Date.new(parts[0].to_i, parts[1].to_i, parts[2].to_i)
  rescue 
    nil
  end
  
  def uplate_isplate_na_dan
    c = {"datum" => @datum, "tip_uplate" => 0}
    @uplate = 
      @user.placanja.find(:all, :conditions =>  c)  +
      @user.primici.find(:all, :conditions => c)
     
    @isplate =  
      @user.ulazni_placanja.find(:all, :conditions => c ) +
      @user.izdaci.find(:all, :conditions => c)  
      
  end
  
  def uplate_isplate_po_danima
    c = FindConditionsHelper.new
    c.int "godina", @godina 
    c.mjesec = @mjesec 
    
		@dani = User.connection.select_all("
		  select datum, godina, DATE_FORMAT(datum, '%d.%m') dan, YEAR(datum) year, month(datum) month, day(datum) day 
      from
      (
          select rp.datum, year(rp.datum) godina 
          from racun_placanje rp 
          inner join racun r on r.id = rp.racun_id
          where r.user_id = #{@user.id} and tip_uplate = 0
          group by datum
	      union 
          select rp.datum, year(rp.datum) godina 
          from ulazni_racun_placanje rp 
          inner join ulazni_racun r on r.id = rp.ulazni_racun_id
          where r.user_id = #{@user.id} and tip_uplate = 0
          group by datum
        union 
          select datum, godina from izdatak where user_id = #{@user.id} and tip_uplate = 0 group by datum
        union  
          select datum, godina from primitak where user_id = #{@user.id} and tip_uplate = 0 group by datum
      ) t
      where #{c.where} 
      group by datum
      order by datum desc")
  end
  
end
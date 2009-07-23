class RacunPregledController < ApplicationController
  before_filter :read_params
  helper :racun

  def read_params
    @type = params[:type] || 'Racun'
  end
 
  def filter
    @godina = (params[:godina] || Date.today.year).to_i
    (@partner = Partner.find(params[:partner_id]) if params[:partner_id].to_i > 0 ) if params[:partner_id]
    @placanje = params[:placanje].to_i 
    @mjesec = params[:mjesec] || ""
    @per_page = (params[:per_page] || 20).to_i 
    
    add_condition("partner_id = #{@partner.id}") if @partner
    add_condition("godina = #{@godina}")  if @godina > 0
    add_condition("type = '#{@type}'")
    add_condition(placanje_to_where(@placanje)) if @placanje > 0
    add_condition("month(datum) in (#{@mjesec})") if @mjesec.size > 0
    
    @title = "#{dict(@type, true)}"
  	@racuni_pages, @racuni = paginate( 
  		:racuni, 
  		:class_name => @type,    
  		:order => 'datum desc, broj desc', 
  		:conditions => @conditions,
  		:per_page => @per_page
  		)
  	
  	@sume = Racun.connection.select_one("select sum(osnovica) osnovica, sum(popust) popust, sum(pdv) pdv, sum(iznos) iznos, count(*) broj from racun where #{@conditions}")
  	@params = { :type => @type, :godina => @godina, :partner_id => @partner, :placanje => @placanje, :mjesec => @mjesec, :per_page => @per_page }
  	
  end
  
  def add_condition(expression)
    if !@conditions
      @conditions = expression
    else
      @conditions += " and #{expression}" 
    end
  end
  
  def placanje_to_where(key)
    return "placen = 0 and dospjece < CURDATE()"  if key == 1
    return "placen = 0"  if key == 2
    return "placen = 1"  if key == 3
    ""  
  end
  
  def mjesec_to_where(key)
    return if key == "..."
    key.gsub("-","..")  if key.include("-")
  end
  
  def report
    @models = Racun.find(:all)
    report = StringIO.new
    CSV::Writer.generate(report, ';') do |csv|
      csv << %w(Title Total)
      @models.each do |model|
        csv << [model.datum, model.iznos]
      end
    end

    report.rewind
    send_data(report.read,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :filename => 'report.csv')
  end
    
end

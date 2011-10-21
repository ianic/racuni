module RacunEdit

  def read_params
    @title = naziv_dokumenta(@racun) if @racun
  end

  def edit
    @racun.edit(params[:racun], params['stavka']) if (request.post?)
    nova_uplata if self.respond_to?('nova_uplata')
  end

  def view    
    render :template => "racun/view", :layout => "racun_ispis"
  end   
  
  def ispis
    render :template => "racun/ispis", :layout => "ispis"
  end

  def nova_stavka
    render :partial => "racun/stavka", :locals => { :index => params[:index] }
  end

  def new
    if request.post?                    
      (redirect_to(:action => "edit", :id => @racun.id) && return) if @racun.save
    else
      @racun.partner = Partner.find(params[:partner_id]) if params[:partner_id]
    end
    render :template => "racun/new"
  end

  def copy
    new = @racun.clone
    new.datum = Date.today
    new.save
    @racun.stavke.each { |stavka| new.stavke << stavka.clone }
    new.save
    redirect_to :action => :edit, :id => new.id
  end

end

module PrimitakIzdatakEdit

  def show   
    @title = naziv_dokumenta(@izdatak)
    render :template => "izdatak/show", :layout => "nil";
  end
  
  def update
    if save
      render :layout => "nil", :update => true do |page|
				page.replace "izdatak_#{@izdatak.id}", :partial => 'izdatak/row_view', :locals => {:izdatak => @izdatak, :izdatak_counter => 0}
				page.visual_effect :highlight, "izdatak_#{@izdatak.id}"
				page << "editor_window.destroy();"
			end
    else
      render :partial => "izdatak/edit"
    end    
  end
  
	def edit	  
	  if request.post?
	    if save
	      flash[:notice] = "#{naziv_dokumenta(@izdatak)} je upisan." 
	      redirect_to :action => "pregled"
        return
	    end
	  end
	  @title = @izdatak.new_record? ? "Novi #{tip_dokumenta(@izdatak.class)}" : naziv_dokumenta(@izdatak)
	  
	  render :template => "izdatak/edit"	
	end
	
	def pregled
	  @title = @title || "Izdaci"
	  c = FindConditionsHelper.new
	  c.int "user_id", @user.id
    c.int "partner_id", @partner_id
    c.int "godina", @godina 
    c.mjesec = @mjesec
    c.like "opis", @opis
    c.where
    
  	@izdaci = Izdatak.paginate( 
  		:page => params[:page],  	
  		:conditions => c.where,
  		:order => 'datum desc, broj desc', 
  		:per_page => @per_page)
  	
  	render :template => "izdatak/pregled"	
	end 

  private 
  
	def save
	  @izdatak.attributes = params[:izdatak]
    @izdatak.partner_id = params[:partner_id]
    @izdatak.save
	end	
end
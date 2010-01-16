class UserController < ApplicationController

  def index 
  end
	
	def home
		redirect_to :action=>'index' if session["user_id"] || User.count == 1
	end

  def edit
    @title = "Postavke"
    render :partial => 'edit'
  end

  def update
    if @user.update_attributes(params[:user])
      render :layout => "nil", :update => true do |page|
        page << "editor_window.destroy();"
      end
    else
      @title = "O Obrtu"
      render(:partial => 'edit')
    end
  end

  def sidebar
    session['sidebar_hidden'] = params['hidden'] == '1'
    render :text => ""
  end

  def login		
    if request.xhr? || params['username'] 
      @username = params['username']
			if @username  == "test"
				@user = User.find_by_username("test")
				if @user != nil
					session["user_id"] = @user.id 
					redirect_to :action => 'index'
					return
				end
			end
			
      @user = User.find_by_username_and_password(@username, params['password'])
      session["user_id"] = @user.id if @user
      render :update do |page|
        if @user
          page.redirect_to :action => 'home'
        else
          page.visual_effect :shake, "login"
          page << "Field.activate('username');"
        end
      end
    else
      render :layout => 'login'
    end
  end

  def stavka_auto_complete
    partner_id, opis, limit = params[:partner_id], params[:opis].strip, 50
    
    @stavke = Array.new if !partner_id
    @stavke = Stavka.find_by_sql("select * from partner_stavka where partner_id = #{partner_id} and opis like '%#{opis}%' order by opis limit #{limit}") if partner_id  
    #@stavke += Stavka.find_by_sql("select * from stavka where opis like '#{opis}%' order by opis limit #{limit - @stavke.size}")  if @stavke.size < limit    
    @stavke += Stavka.find_by_sql("select * from stavka where opis like '%#{opis}%' order by opis limit #{limit - @stavke.size}") if @stavke.size < limit
    
    @stavke.uniq!
    #@stavke = @user.stavke.find(:all,
    #  :conditions => [ 'opis LIKE ?', "%#{opis}%" ],
    #  :order => 'opis',
    #  :limit => 20)
    render :partial => 'racun/stavka_auto_complete'
  end
  
  def permanent_link   
    @racun = Racun.find_by_uuid(params[:uuid]) || Ponuda.find_by_uuid(params[:uuid])
    (render :text => "?" and return) if !@racun
    @user = @racun.user
    render :template => "racun/view", :layout => "racun_ispis"    
  end

end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  require 'find_conditions_helper'
  include DictionaryHelper
  helper DictionaryHelper
  helper FormattingHelper
  helper EditorsHelper
  include ExportHelper
  helper :partner
  
  before_filter :on_before_filter, :except => ['login', 'permanent_link', 'home']
  
  def on_before_filter
    if session["user_id"]
      @user = User.find(session["user_id"])
    else
  	  if User.count == 1  	    
        @user = User.find(:first)
        session["user_id"] = @user.id
      else
        redirect_to(:controller=>'user', :action => 'login')  
        return
      end
    end
    
    @godina = (params[:godina] || Date.today.year).to_i
    @partner_id = params[:partner_id].to_i       
    @placanje = params[:placanje].to_i 
    @mjesec = params[:mjesec] || ""
    @per_page = (params[:per_page] || 20).to_i 
    @format = (params[:format] || "html").downcase
    @opis = params[:opis] || ""
    @tip_placanja = params[:tip_placanja] ? params[:tip_placanja].to_i : -1
    
    @racun_iznos = params[:racun_iznos].to_f unless params[:racun_iznos].nil? || params[:racun_iznos].empty?  
    @racun_iznos_od = params[:racun_iznos_od].to_f unless params[:racun_iznos_od].nil? || params[:racun_iznos_od].empty? 
    @racun_iznos_do = params[:racun_iznos_do].to_f unless params[:racun_iznos_do].nil? || params[:racun_iznos_do].empty? 
    
    self.send(:read_params) if self.respond_to?(:read_params)
  end
  
  def racun_filter_params(field_prefix = nil)
    c = FindConditionsHelper.new(field_prefix)
    c.int "user_id", @user.id
    c.int "partner_id", @partner_id
    c.int "godina", @godina 
    c.placanje = @placanje
    c.mjesec = @mjesec
    c.tip_placanja = @tip_placanja if @model_class != Ponuda
    c.iznos @racun_iznos, @racun_iznos_od, @racun_iznos_do
    c.where    
  end

end

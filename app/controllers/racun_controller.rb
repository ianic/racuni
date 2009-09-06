class RacunController < ApplicationController
  include RacunEdit
  include RacunPregled
  include RacunEditPlacanje
  helper :racun_placanje

  def read_params
    @racun = @user.racuni.find(params[:id]) if params[:id]
    @model_class = Racun
    super
  end

  def new
    @racun =  @user.racuni.build(params[:racun])  
    @racun.rok_placanja = @user.racuni.find(:first, :conditions => "partner_id = #{@racun.partner_id}", :order => "id desc").rok_placanja rescue 15
    @title = @title || "Novi Izlazni Račun"
    super
  end

  def new_gotovinski
    @title = "Novi Gotovinski Račun"
    params[:racun] = Hash.new if !params[:racun]
    params[:racun].merge!({:tip_placanja => 1})
    new
  end

end

# encoding: utf-8

class UlazniRacunController < ApplicationController
	include RacunEdit
	include RacunPregled
	include RacunEditPlacanje
  helper :racun		
  helper :racun_placanje	

  def read_params
    @racun = @user.ulazni_racuni.find(params[:id]) if params[:id]
    @model_class = UlazniRacun
    super
  end
  
  def new
    @racun =  @user.ulazni_racuni.build(params[:racun])
    @title = "Novi Ulazni Račun"
    super
  end
  
end
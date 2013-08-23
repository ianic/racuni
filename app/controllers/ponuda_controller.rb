class PonudaController < ApplicationController
  include RacunEdit
  include RacunPregled
  helper :racun

  def read_params
    @racun = @user.ponude.find(params[:id]) if params[:id]
    @model_class = Ponuda
    super
  end

  def new
    @title = "Nova Ponuda"
    @racun =  @user.ponude.build(params[:racun])
    super
  end

  def copy_u_racun
    new = @user.racuni.build(
                             :partner_id => @racun.partner_id,
                             :osnovica => @racun.osnovica,
                             :popust_postotak => @racun.popust_postotak,
                             :popust => @racun.popust,
                             :pdv_postotak => @racun.pdv_postotak,
                             :pdv => @racun.pdv,
                             :iznos => @racun.iznos
                             )
    new.save
    @racun.stavke.each do |stavka|
      new.stavke << stavka.clone
    end
    new.save
    redirect_to :controller => "racun", :action => :edit, :id => new.id
  end

end

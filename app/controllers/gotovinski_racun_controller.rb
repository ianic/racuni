class GotovinskiRacunController < ApplicationController
	include RacunEdit
	include RacunPregled
	helper :racun
	
  def model_class
    GotovinskiRacun
  end
  
end

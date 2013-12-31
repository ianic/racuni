class PrimitakController < ApplicationController
  include PrimitakIzdatakEdit
  
  def pregled
	  @title = "Primici"
	  super
	end
	
	def edit
	  (@izdatak = @user.primici.build) if !@izdatak
	  super
	end
	  
  def read_params
    (@izdatak = @user.primici.find(params[:id])) if params[:id]
    @model_class = Primitak
  end
	
end

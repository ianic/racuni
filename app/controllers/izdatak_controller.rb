class IzdatakController < ApplicationController
  include PrimitakIzdatakEdit

  def edit
    (@izdatak = @user.izdaci.build) if !@izdatak
    super
  end

  def read_params
    (@izdatak = @user.izdaci.find(params[:id])) if params[:id]
    @model_class = Izdatak
  end
  
end

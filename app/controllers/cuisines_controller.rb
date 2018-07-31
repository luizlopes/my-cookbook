class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    cuisine_param = params.require(:cuisine).permit(:name)
    @cuisine = Cuisine.new cuisine_param
    if @cuisine.save
      redirect_to cuisine_path(@cuisine.id)
    else
      render :new
    end
  end
end

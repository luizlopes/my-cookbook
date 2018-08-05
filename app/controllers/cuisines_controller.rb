class CuisinesController < ApplicationController
  before_action :find_cuisine, only: %i[show edit update]

  def show; end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to cuisine_path(@cuisine.id)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @cuisine.update(cuisine_params)
      flash[:notice] = 'Cozinha alterada com sucesso'
      redirect_to @cuisine
    else
      flash[:alert] = 'Erro ao alterar a cozinha'
      render :edit
    end
  end

  private

  def find_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end

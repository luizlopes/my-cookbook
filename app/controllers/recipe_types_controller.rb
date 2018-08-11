class RecipeTypesController < ApplicationController
  before_action :find_recipe_type, only: %i[show edit update]
  before_action :authenticate_admin!, only: %i[new edit]

  def show; end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to recipe_type_path(@recipe_type.id)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @recipe_type.update(recipe_type_params)
      redirect_to @recipe_type, notice: 'Tipo de receita alterado com sucesso'
    else
      flash[:alert] = 'Erro ao alterar o tipo de receita'
      render :edit
    end
  end

  private

  def find_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end

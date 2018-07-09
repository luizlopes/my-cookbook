class RecipeTypesController < ApplicationController

  def show
    recipe_type_param = params[:id]
    @recipe_type = RecipeType.find(recipe_type_param)
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    recipe_type_params = params.require(:recipe_type).permit(:name)
    @recipe_type = RecipeType.new recipe_type_params
    if @recipe_type.save
      redirect_to recipe_type_path(@recipe_type.id)
    else
      render :new
    end

  end
end
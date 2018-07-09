class RecipeTypesController < ApplicationController

  def show
    recipe_type_param = params[:id]
    @recipe_type = RecipeType.find(recipe_type_param)
  end
end
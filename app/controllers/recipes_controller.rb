class RecipesController < ApplicationController
  
  def show
    @recipe = find_recipe_by_id_param
  end

  def new
    @recipe = Recipe.new
    load_recipes_associations
  end

  def create
    @recipe = Recipe.new recipe_params
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
    else
      load_recipes_associations
      flash[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    @recipe = find_recipe_by_id_param
    load_recipes_associations
  end

  def update
    @recipe = Recipe.find recipe_id_param
    if @recipe.update recipe_params
      redirect_to recipe_path(@recipe.id)
    else
      load_recipes_associations
      flash[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def find_recipe_by_id_param
    Recipe.find recipe_id_param
  end

  def load_recipes_associations
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def recipe_id_param
    params[:id]
  end

end
class HomeController < ApplicationController

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def search
    param_title = params[:title]
    @recipes = Recipe.where("title = :title", title: param_title)

    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all

    render :index
  end
end
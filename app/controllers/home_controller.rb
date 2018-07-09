class HomeController < ApplicationController

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def search
    param_title = params[:title]
    
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all

    if param_title.blank?
      @recipes = Recipe.all
    else
      @recipes = Recipe.where("title LIKE :title", title: "%#{param_title}%")
    end

    render :index
  end
end
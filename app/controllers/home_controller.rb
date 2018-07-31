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

    @recipes = if param_title.blank?
                 Recipe.all
               else
                 Recipe.where('title LIKE :title', title: "%#{param_title}%")
               end
    render :index
  end
end

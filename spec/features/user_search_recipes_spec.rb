require 'rails_helper'

feature 'User search recipes' do
  scenario 'successfully' do
    # preparando dados
    recipe_type = RecipeType.create(name: 'Sopa')
    cuisine_colombiana = Cuisine.create(name: 'Colombiana')
    recipe = Recipe.create(title: 'Sopa de grão de bico',
                          cook_time: 90,
                          cuisine: cuisine_colombiana,
                          recipe_type: recipe_type,
                          difficulty: 'Fácil',
                          ingredients: 'grao de bico e cebola',
                          cook_method: 'ferva a agua com tudo dentro e coma')

    visit root_path
    fill_in 'Buscar por', with: 'Sopa de grão de bico'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end
end
require 'rails_helper'

feature 'User search recipes' do
  scenario 'successfully' do
    # preparando dados
    recipe_type_sopa = RecipeType.create(name: 'Sopa')
    cuisine_colombiana = Cuisine.create(name: 'Colombiana')
    recipe_sopa_grao = Recipe.create(title: 'Sopa de grão de bico',
                          cook_time: 90,
                          cuisine: cuisine_colombiana,
                          recipe_type: recipe_type_sopa,
                          difficulty: 'Fácil',
                          ingredients: 'grao de bico e cebola',
                          cook_method: 'ferva a agua com tudo dentro e coma')

    visit root_path
    fill_in 'Buscar por', with: 'Sopa de grão de bico'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe_sopa_grao.title)
    expect(page).to have_css('li', text: recipe_sopa_grao.recipe_type.name)
    expect(page).to have_css('li', text: recipe_sopa_grao.cuisine.name)
    expect(page).to have_css('li', text: recipe_sopa_grao.difficulty)
    expect(page).to have_css('li', text: "#{recipe_sopa_grao.cook_time} minutos")
  end

  scenario 'and view all recipes' do
    # preparando dados
    recipe_type_sopa = RecipeType.create(name: 'Sopa')
    recipe_type_pao = RecipeType.create(name: 'Pao')

    cuisine_colombiana = Cuisine.create(name: 'Colombiana')
    cuisine_italiana = Cuisine.create(name: 'Italiana')

    recipe_sopa_grao = Recipe.create(title: 'Sopa de grão de bico',
                          cook_time: 90,
                          cuisine: cuisine_colombiana,
                          recipe_type: recipe_type_sopa,
                          difficulty: 'Fácil',
                          ingredients: 'grao de bico e cebola',
                          cook_method: 'ferva a agua com tudo dentro e coma')

    recipe_pao_calabresa = Recipe.create(title: 'Pao de calabresa',
                          cook_time: 50,
                          cuisine: cuisine_italiana,
                          recipe_type: recipe_type_pao,
                          difficulty: 'Difícil',
                          ingredients: 'farinha, ovos, oleo, calabresa moida',
                          cook_method: 'bata tudo no liquidificador e coloque para assar')

    visit root_path
    fill_in 'Buscar por', with: ''
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe_sopa_grao.title)
    expect(page).to have_css('h1', text: recipe_pao_calabresa.title)
  end
end
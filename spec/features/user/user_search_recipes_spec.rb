require 'rails_helper'

feature 'User search recipes' do

  before do
    # preparando dados
    user_chef = User.create(email: 'chef@masterchef.com', password: '123456')

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
                          cook_method: 'ferva a agua com tudo dentro e coma',
                          user: user_chef)

    recipe_pao_calabresa = Recipe.create(title: 'Pao de calabresa',
                          cook_time: 50,
                          cuisine: cuisine_italiana,
                          recipe_type: recipe_type_pao,
                          difficulty: 'Difícil',
                          ingredients: 'farinha, ovos, oleo, calabresa moida',
                          cook_method: 'bata tudo no liquidificador e coloque para assar',
                          user: user_chef)

    recipe_sopa_calabresa = Recipe.create(title: 'Sopa de calabresa',
                          cook_time: 70,
                          cuisine: cuisine_italiana,
                          recipe_type: recipe_type_sopa,
                          difficulty: 'Médio',
                          ingredients: 'cebola e calabresa moida',
                          cook_method: 'ferva a agua com tudo dentro e coma',
                          user: user_chef)
  end

  scenario 'successfully' do
    visit root_path
    fill_in 'Buscar por', with: 'Sopa de grão de bico'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Sopa de grão de bico')
    expect(page).to have_css('li', text: 'Sopa')
    expect(page).to have_css('li', text: 'Colombiana')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: "90 minutos")
  end

  scenario 'and view all recipes' do
    visit root_path
    fill_in 'Buscar por', with: ''
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Sopa de grão de bico')
    expect(page).to have_css('h1', text: 'Pao de calabresa')
  end

  scenario 'and view no recipes' do
    visit root_path
    fill_in 'Buscar por', with: 'Receita que não existe'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma receita encontrada')
  end

  scenario 'and view recipes with same first word' do
    visit root_path
    fill_in 'Buscar por', with: 'Sopa'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Sopa de grão de bico')
    expect(page).to have_css('h1', text: 'Sopa de calabresa')
  end

  scenario 'and view recipes with same anywhere word' do
    visit root_path
    fill_in 'Buscar por', with: 'calabresa'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Pao de calabresa')
    expect(page).to have_css('h1', text: 'Sopa de calabresa')
  end

  scenario 'and view recipes with same word with differents cases' do
    visit root_path
    fill_in 'Buscar por', with: 'CALABRESA'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Pao de calabresa')
    expect(page).to have_css('h1', text: 'Sopa de calabresa')
  end
end
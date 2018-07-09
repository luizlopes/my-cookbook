require 'rails_helper'

feature 'User edit a recipe' do

  before do
    # preparando dados
    recipe_type = RecipeType.create(name: 'Sopa')
    cuisine_colombiana = Cuisine.create(name: 'Colombiana')
    cuisine_chilena = Cuisine.create(name: 'Chilena')
    recipe = Recipe.create(title: 'Sopa de grão de bico',
                          cook_time: 90,
                          cuisine: cuisine_colombiana,
                          recipe_type: recipe_type,
                          difficulty: 'Fácil',
                          ingredients: 'grao de bico e cebola',
                          cook_method: 'ferva a agua com tudo dentro e coma')
    
    # navegando
    visit root_path
    click_on 'Sopa de grão de bico'
    click_on 'Editar'
  end

  scenario 'successfully' do
    # navegando
    fill_in 'Dificuldade', with: 'Não tão fácil'
    fill_in 'Tempo de Preparo', with: '120'
    select 'Chilena', from: 'Cozinha'
    click_on 'Enviar'
    
    # validando 
    expect(page).to have_css('h1', text: 'Sopa de grão de bico')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sopa')
    expect(page).to have_css('p', text: 'Chilena')
    expect(page).to have_css('p', text: 'Não tão fácil')
    expect(page).to have_css('p', text: "120 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'grao de bico e cebola')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'ferva a agua com tudo dentro e coma')
  end

  scenario 'and must fill Tempo de Preparo' do
    # navegando
    fill_in 'Tempo de Preparo', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
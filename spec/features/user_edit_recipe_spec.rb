require 'rails_helper'

feature 'User edit a recipe' do

  before do 
    # preparando dados
    @user_chef = User.create(email: 'chef@masterchef.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sopa')
    cuisine_colombiana = Cuisine.create(name: 'Colombiana')
    cuisine_chilena = Cuisine.create(name: 'Chilena')
    @recipe = Recipe.create(title: 'Sopa de grão de bico',
                          cook_time: 90,
                          cuisine: cuisine_colombiana,
                          recipe_type: recipe_type,
                          difficulty: 'Fácil',
                          ingredients: 'grao de bico e cebola',
                          cook_method: 'ferva a agua com tudo dentro e coma',
                          user: @user_chef)
  end

  scenario 'successfully' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'

    click_on 'Editar'

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
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    fill_in 'Tempo de Preparo', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must fill Título' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    fill_in 'Título', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must fill Dificuldade' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    fill_in 'Dificuldade', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must fill Ingredientes' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    fill_in 'Ingredientes', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must fill Como Preparar' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    # validando
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and back to recipe details' do
    # navegando
    visit root_path
    login_with @user_chef
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'
    
    click_on 'Cancelar'

    expect(page).to have_css('h1', text: 'Sopa de grão de bico')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sopa')
    expect(page).to have_css('p', text: 'Colombiana')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "90 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'grao de bico e cebola')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'ferva a agua com tudo dentro e coma')
  end

  scenario 'and must make login before edit' do
    # navegando
    visit root_path
    click_on 'Sopa de grão de bico'
    
    click_on 'Editar'

    # validando
    expect(page).to have_content('Você precisa estar logado para enviar uma receita')
  end

  private 

  def login_with(user)
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
  end
end
require 'rails_helper'

feature 'User list your recipes' do
  scenario 'successfully' do
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)

    guilherme = User.create(email: 'guilherme@cookbook.com', password: 'cookbook123')
    macarrao_gravata = create(:recipe, title: "Macarrão gravata", user: guilherme, recipe_type: recipe_type, cuisine: cuisine) 

    luiz = User.create(email: 'luiz@cookbook.com', password: 'cookbook123')
    macarrao_bolina = create(:recipe, title: "Macarrão bolinha", user: luiz, recipe_type: recipe_type, cuisine: cuisine)
    macarrao_parafuso = create(:recipe, title: "Macarrão parafuso", user: luiz, recipe_type: recipe_type, cuisine: cuisine)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: luiz.email
    fill_in 'Senha', with: luiz.password
    click_on 'Entrar'

    click_on 'Minhas receitas'

    expect(page).to have_css('h2', text: 'Minhas receitas')
    expect(page).to have_css('h3', text: macarrao_bolina.title)
    expect(page).to have_css('h3', text: macarrao_parafuso.title)
    expect(page).to have_link('Editar', href: edit_recipe_path(macarrao_bolina))
    expect(page).to have_link('Editar', href: edit_recipe_path(macarrao_parafuso))
    expect(page).to have_link('Apagar', href: recipe_path(macarrao_bolina))
    expect(page).to have_link('Apagar', href: recipe_path(macarrao_parafuso))
    expect(page).to_not have_content(macarrao_gravata.title)
  end

  scenario 'and has no one recipe' do
    luiz = User.create(email: 'luiz@cookbook.com', password: 'cookbook123')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: luiz.email
    fill_in 'Senha', with: luiz.password
    click_on 'Entrar'

    click_on 'Minhas receitas'

    expect(page).to have_css('h3', text: 'Você ainda não possui receitas')
  end
end
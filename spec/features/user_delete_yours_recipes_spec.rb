require 'rails_helper'

feature 'User delete yours recipes' do

  scenario 'sucessfully' do
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)

    luiz = User.create(email: 'luiz@cookbook.com', password: 'cookbook123')
    macarrao_bolina = create(:recipe, title: "Macarrão bolinha", user: luiz, recipe_type: recipe_type, cuisine: cuisine)
    macarrao_parafuso = create(:recipe, title: "Macarrão parafuso", user: luiz, recipe_type: recipe_type, cuisine: cuisine)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: luiz.email
    fill_in 'Senha', with: luiz.password
    click_on 'Entrar'

    click_on 'Minhas receitas'
    first(:link, 'Apagar').click

    expect(page).to have_content('Receita apagada com sucesso')
    expect(page).to_not have_content(macarrao_bolina.title)
    expect(page).to have_css('h3', text: macarrao_parafuso.title)
  end

end
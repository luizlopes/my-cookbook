require 'rails_helper'

feature 'Admin edit a recipe' do
  scenario 'sucessfully' do
    joao = User.create(email: 'joao@user.com', password: '123123',
                       admin: false)
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)

    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    macarrao = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                               user: joao)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on macarrao.title
    click_on 'Editar'
    fill_in 'Dificuldade', with: 'média'
    fill_in 'Tempo de Preparo', with: '60'
    click_on 'Enviar'

    expect(page).to have_content(macarrao.title)
    expect(page).to have_content('média')
    expect(page).to have_content('60')
  end
end

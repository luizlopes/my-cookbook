require 'rails_helper'

feature 'Admin edit a cuisine' do
  scenario 'successfully' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Peruana')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Brasileira'
    click_on 'Editar'

    fill_in 'Nome', with: 'Brasileirissima'
    click_on 'Enviar'

    expect(page).to have_content('Cozinha alterada com sucesso')
    expect(page).to have_css('h1', text: 'Brasileirissima')
  end

  scenario 'and left blank field' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Peruana')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Brasileira'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Erro ao alterar a cozinha')
    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and must be logged as admin' do
    brasileira = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Peruana')

    visit edit_cuisine_path(brasileira)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end

  scenario 'and must be logged as admin' do
    brasileira = Cuisine.create(name: 'Brasileira')
    joao = User.create(email: 'joao@admin.com', password: '123123')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: joao.email
    fill_in 'Senha', with: joao.password
    click_on 'Entrar'

    visit edit_cuisine_path(brasileira)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end
end

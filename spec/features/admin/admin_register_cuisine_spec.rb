require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo'\
                                 ' de cozinha')
  end

  scenario 'and must fill in name' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar cozinha'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and must be logged as admin' do
    visit new_cuisine_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end

  scenario 'and must be logged as admin' do
    joao = User.create(email: 'joao@admin.com', password: '123123')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: joao.email
    fill_in 'Senha', with: joao.password
    click_on 'Entrar'

    visit new_cuisine_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end

  scenario 'and must be unique' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    Cuisine.create(name: 'Peruana')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar cozinha'

    fill_in 'Nome', with: 'peruana'
    click_on 'Enviar'

    expect(page).to have_content('Cozinha já existe')
  end
end

require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar tipo de receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo')
  end

  scenario 'and must fill in name' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar tipo de receita'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'and must be logged as admin' do
    visit new_recipe_type_path

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

    visit new_recipe_type_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end

  scenario 'and must be unique' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Adicionar tipo de receita'

    fill_in 'Nome', with: 'sobremesa'
    click_on 'Enviar'

    expect(page).to have_content('Tipo de receita já existe')
  end
end

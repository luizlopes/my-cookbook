require 'rails_helper'

feature 'Admin edit a recipe type' do
  scenario 'successfully' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    RecipeType.create(name: 'Salada')
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Salada'
    click_on 'Editar'

    fill_in 'Nome', with: 'Saladas'
    click_on 'Enviar'

    expect(page).to have_content('Tipo de receita alterado com sucesso')
    expect(page).to have_css('h1', text: 'Saladas')
  end

  scenario 'and left blank field' do
    admin = User.create(email: 'admin@admin.com', password: '123123',
                        admin: true)
    RecipeType.create(name: 'Salada')
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    click_on 'Salada'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Erro ao alterar o tipo de receita')
    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'and must be logged as admin' do
    salada = RecipeType.create(name: 'Salada')

    visit edit_recipe_type_path(salada)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end

  scenario 'and must be logged as admin' do
    salada = RecipeType.create(name: 'Salada')
    joao = User.create(email: 'joao@admin.com', password: '123123')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: joao.email
    fill_in 'Senha', with: joao.password
    click_on 'Entrar'

    visit edit_recipe_type_path(salada)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Usuário sem permissão')
  end
end

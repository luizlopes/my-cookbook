require 'rails_helper'

feature 'user sign in' do
  scenario 'from home page' do
    luiz = User.create(email: 'luiz@cookbook.com', password: 'cookbook123') #create(:user) 

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: luiz.email
    fill_in 'Senha', with: luiz.password
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Olá #{luiz.email}")
    expect(page).to have_link("Minhas receitas")
    expect(page).to_not have_content('Entrar')
  end

  scenario 'and logout' do
    luiz = User.create(email: 'luiz@cookbook.com', password: 'cookbook123') #create(:user) 

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: luiz.email
    fill_in 'Senha', with: luiz.password
    click_on 'Entrar'

    click_on 'Sair'
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Entrar')
    expect(page).to_not have_link('Minhas receitas')
  end
end

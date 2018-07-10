require 'rails_helper'

feature 'user sign in' do
  scenario 'from home page' do
    user = User.create(email: 'luiz@cookbook.com', password: 'cookbook123') #create(:user) 

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Olá #{user.email}")
  end

  scenario 'and logout' do
    user = User.create(email: 'luiz@cookbook.com', password: 'cookbook123') #create(:user) 

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Sair'
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Entrar")
  end
end
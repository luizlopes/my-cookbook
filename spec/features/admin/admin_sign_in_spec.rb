require 'rails_helper'

feature 'Admin sign in' do 
  scenario 'successfully' do
    admin = User.create(email: 'admin@admin.com', password: '123123', admin: true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    expect(page).to have_content('Administrador')
    expect(page).to_not have_content(admin.email)
  end
end

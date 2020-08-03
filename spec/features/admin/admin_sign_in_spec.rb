require 'rails_helper'

feature 'Admin can sign in' do

  given(:user) { create(:user, :admin) }

  background { visit admin_user_requests_path }

  scenario 'Registered admin tries to sign in' do
    # visit login page
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Work_With_Application'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@user.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to  have_no_content 'Список заявок'
  end
end

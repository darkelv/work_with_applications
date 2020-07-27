require 'rails_helper'

feature 'User can delete request' do

  scenario 'delete request' do
    user_request = create(:user_request)
    visit user_request_path(user_request)

    within '.card-footer' do
      click_on 'Удалить'
    end

    expect(page).not_to have_content user_request.title
    expect(page).not_to have_content user_request.body
  end
end

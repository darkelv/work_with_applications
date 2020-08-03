require 'rails_helper'

feature 'User can delete request' do
  given(:user) { create (:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'delete request' do
      user_request = create(:user_request)
      visit user_request_path(user_request)

      within '.card-footer' do
        click_on 'Удалить'
      end

      expect(page).to_not have_content user_request.title
      expect(page).to_not have_content user_request.body
    end
  end

  describe "Unauthenticated" do
    scenario "tries to delete user request" do
      user_request = create(:user_request)
      visit user_request_path(user_request)

      expect(page).to_not have_content 'Удалить'
      expect(page).to have_content 'Log in'
    end
  end
end

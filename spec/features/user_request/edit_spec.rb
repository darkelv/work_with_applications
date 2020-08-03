require 'rails_helper'

feature 'User can update request' do
  given(:user) { create (:user) }
  given!(:user_request) { create(:user_request, user: user) }

  describe "Authenticate" do
    describe 'Edit request' do
      background do
        sign_in(user)
        visit user_request_path(user_request)
        click_on 'Редактировать'
      end

      scenario 'valid' do
        fill_in 'Заголовок', with: 'У меня ольшие проблемы'
        fill_in 'Обращение', with: 'Срочно все мне почините'

        click_on 'Отправить'

        expect(page).to_not have_button 'Отправить'

        expect(page).to_not have_content user_request.title
        expect(page).to_not have_content user_request.body
        expect(page).to have_content 'У меня ольшие проблемы'
        expect(page).to have_content 'Срочно все мне почините'
      end

      scenario 'delete request files' do
        user_request_with_files = create(:user_request, :with_files)
        visit user_request_path(user_request_with_files)
        within ".attachments" do
          expect(page).to have_button "Удалить"

          within ".form-inline#attachment-#{user_request_with_files.files.first.id}" do
            click_on "Удалить"
          end

          expect(page).not_to have_css(".form-inline#attachment-#{user_request_with_files.files.first.id}")

          within ".form-inline#attachment-#{user_request_with_files.files.last.id}" do
            expect(page).to have_button "Удалить"
          end

          within ".form-inline#attachment-#{user_request_with_files.files.last.id}" do
            click_on "Удалить"
          end

          expect(page).not_to have_css(".form-inline#attachment-#{user_request_with_files.files.last.id}")

          expect(page).to_not have_button "Удалить"
        end
      end
    end
  end

  describe "Unauthenticated" do
    scenario "tries to edit user request" do
      user_request = create(:user_request)
      visit user_request_path(user_request)

      expect(page).to_not have_content 'Редактировать'
      expect(page).to have_content 'Log in'
    end
  end
end

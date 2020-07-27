require 'rails_helper'

feature 'User can create request' do

  describe 'Create request' do

    background do
      visit user_requests_path
      click_on 'Создать'
    end

    scenario 'valid' do
      fill_in 'Заголовок', with: 'У меня ольшие проблемы'
      fill_in 'Обращение', with: 'Срочно все мне почините'

      click_on 'Отправить'

      expect(page).to have_content 'У меня ольшие проблемы'
      expect(page).to have_content 'Срочно все мне почините'
    end

    scenario 'invalid' do
      fill_in 'Обращение', with: 'Срочно все мне почините'

      click_on 'Отправить'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'with attached file' do
      fill_in 'Заголовок', with: 'У меня ольшие проблемы'
      fill_in 'Обращение', with: 'Срочно все мне почините'
      attach_file 'user_request[files][]', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

      click_on 'Отправить'

      expect(page).to have_content 'У меня ольшие проблемы'
      expect(page).to have_content 'Срочно все мне почините'
      expect(page).to have_link "spec_helper.rb"
    end
  end
end

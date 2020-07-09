FactoryBot.define do
  factory :user_request do
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end

    trait :with_files do
      after :create do |question|
        file_path1 = Rails.root.join('app', 'assets', 'images', 'first_image.jpg')
        file_path2 = Rails.root.join('app', 'assets', 'images', 'second_image.jpg')
        file1 = fixture_file_upload(file_path1, 'image/jpeg')
        file2 = fixture_file_upload(file_path2, 'image/jpeg')
        question.files.attach(file1, file2)
      end
    end
  end
end

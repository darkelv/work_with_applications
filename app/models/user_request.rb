class UserRequest < ApplicationRecord

  has_many_attached :files

  validates :title, :body, presence: true
end

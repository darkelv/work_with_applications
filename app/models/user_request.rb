class UserRequest < ApplicationRecord

  belongs_to :user

  has_many_attached :files

  validates :title, :body, presence: true

  scope :ordered, -> {order(created_at: :desc)}
end

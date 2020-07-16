class User < ApplicationRecord

  VALID_EMAIL_FORMAT = /.+@.+\..+/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_requests, dependent: :destroy

  validates :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_FORMAT, message: "Неверный формат почта" }
end

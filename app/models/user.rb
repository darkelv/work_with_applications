class User < ApplicationRecord

  VALID_EMAIL_FORMAT = /.+@.+\..+/i

  ROLES = { user: 0, admin: 1, implementer: 2, moderator: 3, accountant: 4 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_requests, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_FORMAT, message: "Неверный формат почта" }

  enum role: ROLES

  scope :ordered, -> {order(created_at: :desc)}

  def employee?
    admin? or implementer? or moderator? or accountant?
  end
end

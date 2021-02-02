class AddReferance < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_requests, :user, null: false, foreign_key: true
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Association' do
    it { should have_many(:user_requests).dependent(:destroy) }
  end

  describe 'Validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should allow_value("email@addresse.test").for(:email) }
    it { should_not allow_value("foo").for(:email) }
  end
end

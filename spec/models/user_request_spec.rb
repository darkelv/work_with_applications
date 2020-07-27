require 'rails_helper'

RSpec.describe UserRequest, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end

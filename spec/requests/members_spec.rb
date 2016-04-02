require 'rails_helper'

RSpec.describe 'Members', type: :request do
  before :each do
    sign_in_as_a_valid_user
  end
  describe 'GET /members' do
    it 'works! (now write some real specs)' do
      get members_path
      expect(response.status).to be(200)
    end
  end
end

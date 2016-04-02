require 'rails_helper'

RSpec.describe 'People', type: :request do
  before :each do
    sign_in_as_a_valid_user
  end
  describe 'GET /people' do
    it 'works! (now write some real specs)' do
      get people_path
      expect(response.status).to be(200)
    end
  end
end

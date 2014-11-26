require 'rails_helper'

describe "Boats", :type => :request do
  before :each do
    sign_in_as_a_valid_user
  end
  describe "GET /boats" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get boats_path
      expect(response.status).to be(200)
    end
  end
end

require 'rails_helper'

RSpec.describe "Privileges", :type => :request do
  describe "GET /privileges" do
    it "works! (now write some real specs)" do
      get privileges_path
      expect(response).to have_http_status(200)
    end
  end
end

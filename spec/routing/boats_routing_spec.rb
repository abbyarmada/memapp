require "rails_helper"

describe BoatsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/boats")).to route_to("boats#index")
    end

    it "routes to #new" do
      expect(get("/boats/new")).to route_to("boats#new")
    end

    it "routes to #show" do
      expect(get("/boats/1")).to route_to("boats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/boats/1/edit")).to route_to("boats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/boats")).to route_to("boats#create")
    end

    it "routes to #update" do
      expect(put("/boats/1")).to route_to("boats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/boats/1")).to route_to("boats#destroy", :id => "1")
    end

  end
end

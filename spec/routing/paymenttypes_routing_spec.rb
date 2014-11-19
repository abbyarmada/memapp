require "rails_helper"

describe PaymenttypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/paymenttypes")).to route_to("paymenttypes#index")
    end

    it "routes to #new" do
      expect(get("/paymenttypes/new")).to route_to("paymenttypes#new")
    end

    it "routes to #show" do
      expect(get("/paymenttypes/1")).to route_to("paymenttypes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/paymenttypes/1/edit")).to route_to("paymenttypes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/paymenttypes")).to route_to("paymenttypes#create")
    end

    it "routes to #update" do
      expect(put("/paymenttypes/1")).to route_to("paymenttypes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/paymenttypes/1")).to route_to("paymenttypes#destroy", :id => "1")
    end

  end
end

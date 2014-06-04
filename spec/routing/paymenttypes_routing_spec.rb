require "spec_helper"

describe PaymenttypesController do
  describe "routing" do

    it "routes to #index" do
      get("/paymenttypes").should route_to("paymenttypes#index")
    end

    it "routes to #new" do
      get("/paymenttypes/new").should route_to("paymenttypes#new")
    end

    it "routes to #show" do
      get("/paymenttypes/1").should route_to("paymenttypes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paymenttypes/1/edit").should route_to("paymenttypes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paymenttypes").should route_to("paymenttypes#create")
    end

    it "routes to #update" do
      put("/paymenttypes/1").should route_to("paymenttypes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paymenttypes/1").should route_to("paymenttypes#destroy", :id => "1")
    end

  end
end

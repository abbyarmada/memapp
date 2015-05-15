require "rails_helper"

RSpec.describe RenewalsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/renewals").to route_to("renewals#index")
    end

    it "routes to #new" do
      expect(:get => "/renewals/new").to route_to("renewals#new")
    end

    it "routes to #show" do
      expect(:get => "/renewals/1").to route_to("renewals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/renewals/1/edit").to route_to("renewals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/renewals").to route_to("renewals#create")
    end

    it "routes to #update" do
      expect(:put => "/renewals/1").to route_to("renewals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/renewals/1").to route_to("renewals#destroy", :id => "1")
    end

  end
end

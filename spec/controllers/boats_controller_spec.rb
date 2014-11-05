require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BoatsController do
  before :each do
    login_user 
  end

  # This should return the minimal set of attributes required to create a valid
  # Boat. As you add validations to Boat, be sure to
  # adjust the attributes here as well.
  #let(:valid_attributes) { { "member_id" => "1", "boat_type" => "Dinghy" } }
  let (:valid_attributes) { boat = FactoryGirl.create :boat }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BoatsController. Be sure to keep this updated too.
  let(:valid_session) { {"warden.user.user.key" => session["warden.user.user.key"]} }
 
  


#  describe "GET index" do
#    it "assigns all boats as @boats" do
#      boat = create(:boat) 
#      get :index, {}
#      assigns(:boats).should eq([boat])
#    end
#  end

#  describe "GET show" do
#    it "assigns the requested boat as @boat" do
#      boat = create(:boat)
#      get :show, {:id => boat.to_param}
#      assigns(:boat).should eq(boat)
#    end
#  end

  describe "GET new" do
    it "assigns a new boat as @boat" do
      get :new, {}, valid_session
      assigns(:boat).should be_a_new(Boat)
    end
  end

  describe "GET edit" do
    it "assigns the requested boat as @boat" do
      boat = create(:boat)
      get :edit, {:id => boat.to_param}
      assigns(:boat).should eq(boat)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Boat" do
        expect {
          person = create(:person)
          member = create(:member)
          boat = create(:boat)
        }.to change(Boat, :count).by(1)
      end

      it "assigns a newly created boat as @boat" do
        person = build(:person)
        member = build(:member)
        boat = create(:boat)
        boat.should be_a(Boat)
        boat.should be_persisted
      end

 #     it "redirects to the created boat" do
 #       person = create(:person)
 #       member = create(:member)
 #       boat = create(:boat)
 #       response.should redirect_to person_path(boat.member.main_member)+'#tabs-5'
 #     end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved boat as @boat" do
        # Trigger the behavior that occurs when invalid params are submitted
        Boat.any_instance.stub(:save).and_return(false)
        post :create, {:boat => { "member_id" => "invalid value" }}
        assigns(:boat).should be_a_new(Boat)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Boat.any_instance.stub(:save).and_return(false)
        post :create, {:boat => { "member_id" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested boat" do
       person = create(:person)
       member = create(:member)
       boat = create(:boat)

        # Assuming there are no other boats in the database, this
        # specifies that the Boat created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Boat.any_instance.should_receive(:update_attributes).with({ "member_id" => "1" })
        put :update, {:id => boat.to_param, :boat => { "member_id" => "1" }}
      end

      it "assigns the requested boat as @boat" do
        person = create(:person)
        member = create(:member)
        boat = create(:boat)
        put :update , {:id => boat.id } 
        assigns(:boat).should eq(boat)
      end

      it "redirects to the boat" do
        person = create(:person)
        member = create(:member)
        boat = create(:boat)
        put :update, {:id => boat.id }
        response.should redirect_to person_path(person.id)+'#tabs-5'
      end
    end

    describe "with invalid params" do
      it "assigns the boat as @boat" do
        person = create(:person)
        member = create(:member)
        boat = create(:boat)
        # Trigger the behavior that occurs when invalid params are submitted
        Boat.any_instance.stub(:save).and_return(false)
        put :update, {:id => boat.to_param, :boat => { "member_id" => "invalid value" }}
        assigns(:boat).should eq(boat)
      end

      it "re-renders the 'edit' template" do
        boat = create(:boat)
        # Trigger the behavior that occurs when invalid params are submitted
        Boat.any_instance.stub(:save).and_return(false)
        put :update, {:id => boat.to_param, :boat => { "member_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested boat" do
      person = create(:person)
      member = create(:member)
      boat = create(:boat)
      expect {
        delete :destroy, {:id => boat.to_param}
      }.to change(Boat, :count).by(-1)
    end

    it "redirects to the person  page" do
      person = create(:person)
      member = create(:member)
      boat = create(:boat)
      delete :destroy, {:id => boat.to_param}
       response.should redirect_to person_path(person.id)+'#tabs-5'
    end
  end

end

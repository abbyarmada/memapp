require 'rails_helper'

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
  login_user
  # This should return the minimal set of attributes required to create a valid
  # Boat. As you add validations to Boat, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) { { "member_id" => "1", "boat_type" => "Dinghy" } }
  let (:valid_attributes) { attributes_for(:boat) }
  let (:valid_boat_member_attributes) do
    attributes_for(:boat)
    attributes_for(:member)
  end
  let (:invalid_boat_member_attributes) do
    attributes_for(:boat, boat_type: 'Inflatable')
    attributes_for(:member)
  end
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BoatsController. Be sure to keep this updated too.
  let(:valid_session) { { 'warden.user.user.key' => session['warden.user.user.key'] } }
  # let(:valid_session) {}
  #  before(:each) do
  # member = create(:member, :people => [  create(:person) ] )
  # boat = create(:boat , :member => member )
  # end

  #  describe "GET index" do
  #    it "assigns all boats as @boats" do
  #      skip "getting active record relation..."
  #      boat = Boat.create! valid_attributes
  #      get :index, {}, valid_session
  #      expect(assigns(:boats)).to eq([boat])
  #    end
  #  end

  describe 'GET new' do
    it 'assigns a new boat as @boat' do
      get :new, {}, valid_session
      expect(assigns(:boat)).to be_a_new(Boat)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested boat as @boat' do
      boat = create(:boat)
      get :edit, id: boat.to_param
      expect(assigns(:boat)).to eq(boat)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Boat' do
        expect do
          member = create(:member, people: [create(:person)])
          create(:boat, member: member)
        end.to change(Boat, :count).by(1)
      end

      it 'assigns a newly created boat as @boat' do
        member = create(:member, people: [create(:person)])
        post :create, { boat: build(:boat, member: member).attributes }, valid_session
        expect(assigns(:boat)).to be_a(Boat)
        expect(assigns(:boat)).to be_persisted
      end

      it 'redirects to the created boat' do
        member = create(:member, people: [create(:person)])
        post :create, { boat: build(:boat, member: member).attributes }, valid_session
        expect(response).to redirect_to person_path(assigns(:boat).owner) + '#tabs-5'
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved boat as @boat' do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Boat).to receive(:save).and_return(false)
        member = create(:member, people: [create(:person)])
        post :create, { boat: build(:boat, member_id: 'invalid value', member: member).attributes }, valid_session
        # post :create, {:boat => { "member_id" => "invalid value" }}
        expect(assigns(:boat)).to be_a_new(Boat)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Boat).to receive(:save).and_return(false)
        # post :create, {:boat => { "member_id" => "invalid value" }}
        member = create(:member, people: [create(:person)])
        post :create, { boat: build(:boat, member_id: 'invalid value', member: member).attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested boat' do
        member = create(:member, people: [create(:person)])
        boat = create(:boat, member: member)
        # Assuming there are no other boats in the database, this
        # specifies that the Boat created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Boat).to receive(:update).with('boat_name' => 'Ship')
        put :update, id: boat.to_param, boat: { 'boat_name' => 'Ship' }
      end
      it 'assigns the requested boat as @boat' do
        member = create(:member, people: [create(:person)])
        boat = create(:boat, member: member)
        put :update, id: boat.to_param, boat: valid_boat_member_attributes
        expect(assigns(:boat)).to eq(boat)
      end

      it 'redirects to the list boats page on the person view path' do
        member = create(:member, people: [create(:person)])
        boat = create(:boat, member: member)
        put :update, id: boat.to_param, boat: valid_boat_member_attributes
        expect(response).to redirect_to person_path(assigns(:boat).owner) + '#tabs-5'
      end
    end
    describe 'with invalid params' do
      it 'assigns the boat as @boat' do
        member = create(:member, people: [create(:person)])
        boat = create(:boat, member: member)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Boat).to receive(:save).and_return(false)
        put :update, id: boat.to_param, boat: invalid_boat_member_attributes
        expect(assigns(:boat)).to eq(boat)
      end
      it "re-renders the 'edit' template" do
        member = create(:member, people: [create(:person)])
        boat = create(:boat, member: member)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Boat).to receive(:save).and_return(false)
        put :update, { id: boat.to_param, boat: invalid_boat_member_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'DELETE destroy' do
    it 'destroys the requested boat' do
      member = create(:member, people: [create(:person)])
      boat = create(:boat, member: member)
      expect do
        delete :destroy, id: boat.to_param
      end.to change(Boat, :count).by(-1)
    end
    it 'redirects to the person  page' do
      member = create(:member, people: [create(:person)])
      boat = create(:boat, member: member)
      # boat = create(:boat_with_member_and_main_person)
      # expect(response).to eq(200) #redirect_to person_path(boat.owner) + '#tabs-5'
      delete :destroy, { id: boat.to_param }, valid_session
      expect(response).to redirect_to(person_path(boat.owner) + '#tabs-5')
    end
  end
end

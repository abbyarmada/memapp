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

RSpec.describe PeopleController, type: :controller do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # Person. As you add validations to Person, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:person)
  end

  let(:invalid_attributes) do
    attributes_for(:person, first_name: nil)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeopleController. Be sure to keep this updated too.
  # let(:valid_session) { {} }
  let(:valid_session) { { 'warden.user.user.key' => session['warden.user.user.key'] } }

  describe 'GET index' do
    # skip("skip")
    it 'assigns all people as @people' do
      skip 'broken!'
      allow(@people).to receive_messages(will_paginate: true)
      @member = create(:member)
      @person = create(:person, member: @member)
      get :index, {}, valid_session
      expect(assigns(:people)).to eq([@person])
    end
  end

  describe 'GET show' do
    it 'assigns the requested person as @person' do
      member = create(:member)
      person = create(:person, member: member)
      get :show, { id: person.to_param }, valid_session
      expect(assigns(:person)).to eq(person)
    end
  end

  describe 'GET new' do
    it 'assigns a new person as @person' do
      get :new, {}, valid_session
      expect(assigns(:person)).to be_a_new(Person)
    end
  end
  describe 'GET edit' do
    it 'assigns the requested person as @person' do
      member = create(:member)
      person = create(:person, member: member)
      get :edit, { id: person.to_param }, valid_session
      expect(assigns(:person)).to eq(person)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Person' do
        expect do
          post :create, { person: valid_attributes }, valid_session
        end.to change(Person, :count).by(1)
      end

      it 'assigns a newly created person as @person' do
        post :create, { person: valid_attributes }, valid_session
        expect(assigns(:person)).to be_a(Person)
        expect(assigns(:person)).to be_persisted
      end

      it 'redirects to the created person' do
        post :create, { person: valid_attributes }, valid_session
        expect(response).to redirect_to(person_url(assigns(:person)) + '#tabs-3')
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved person as @person' do
        post :create, { person: invalid_attributes }, valid_session
        expect(assigns(:person)).to be_a_new(Person)
      end

      it "re-renders the 'new' template" do
        post :create, { person: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        attributes_for(:person, status: 'ch')
      end

      it 'updates the requested person' do
        member = create(:member)
        create(:person, member: member)
        person = create(:person, status: 'p', member: member)
        put :update, { id: person.to_param, person: new_attributes }, valid_session
        person.reload
        expect(assigns(:person).status).to eq('ch')
        # skip("Add assertions for updated state")
      end

      it 'assigns the requested person as @person' do
        member = create(:member)
        person = create(:person, member: member)
        put :update, { id: person.to_param, person: valid_attributes }, valid_session
        expect(assigns(:person)).to eq(person)
      end

      it 'redirects to the person' do
        member = create(:member)
        person = create(:person, member: member)
        put :update, { id: person.to_param, person: valid_attributes }, valid_session
        expect(response).to redirect_to(person_url + '#tabs-3')
      end
    end

    describe 'with invalid params' do
      it 'assigns the person as @person' do
        person = Person.create! valid_attributes
        put :update, { id: person.to_param, person: invalid_attributes }, valid_session
        expect(assigns(:person)).to eq(person)
      end

      it "re-renders the 'edit' template" do
        member = create(:member)
        person = create(:person, member: member)
        put :update, { id: person.to_param, person: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested person' do
      member = create(:member)
      create(:person, member: member)
      person = create(:person, status: 'p', member: member)
      expect do
        delete :destroy, { id: person.to_param }, valid_session
      end.to change(Person, :count).by(-1)
    end

    it 'redirects to the people list' do
      member = create(:member)
      person = create(:person, member: member)
      otherperson = create(:person, status: 'p', member: member)
      delete :destroy, { id: otherperson.to_param }, valid_session
      expect(response).to redirect_to(person_url(person) + '#tabs-3')
    end
  end
end

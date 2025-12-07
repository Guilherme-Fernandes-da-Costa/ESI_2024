# spec/controllers/lists_controller_spec.rb
require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all lists as @lists" do
      list = create(:list)
      get :index
      expect(assigns(:lists)).to eq([list])
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new list as @list" do
      get :new
      expect(assigns(:list)).to be_a_new(List)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { { name: "Lista de Compras" } }
      let(:user) { create(:user) }

      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "creates a new List" do
        expect {
          post :create, params: { list: valid_attributes }
        }.to change(List, :count).by(1)
      end

      it "assigns the current user as owner" do
        post :create, params: { list: valid_attributes }
        expect(assigns(:list).owner).to eq(user)
      end

      it "redirects to the created list" do
        post :create, params: { list: valid_attributes }
        expect(response).to redirect_to(List.last)
      end

      it "sets a success notice" do
        post :create, params: { list: valid_attributes }
        expect(flash[:notice]).to eq('Lista criada com sucesso.')
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { name: "" } }

      it "does not create a new List" do
        expect {
          post :create, params: { list: invalid_attributes }
        }.not_to change(List, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { list: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #reset" do
    let(:list) { create(:list) }
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "when user is the owner" do
      before do
        list.update(owner: user)
        create_list(:item, 3, list: list)
      end

      it "resets the list (destroys all items)" do
        expect {
          post :reset, params: { id: list.id }
        }.to change(list.items, :count).from(3).to(0)
      end

      it "redirects to the list" do
        post :reset, params: { id: list.id }
        expect(response).to redirect_to(list)
      end

      it "sets a success notice" do
        post :reset, params: { id: list.id }
        expect(flash[:notice]).to eq('Lista reiniciada com sucesso.')
      end
    end

    context "when user is not the owner" do
      let(:other_user) { create(:user) }

      before do
        list.update(owner: other_user)
        create_list(:item, 3, list: list)
      end

      it "does not reset the list" do
        expect {
          post :reset, params: { id: list.id }
        }.not_to change(list.items, :count)
      end

      it "returns forbidden status" do
        post :reset, params: { id: list.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
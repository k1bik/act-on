require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:location) { create(:location) }

  describe "GET #index" do
    it "renders the index template" do
      get :index, params: { location_id: location.id }

      expect(response).to be_ok
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new, params: { location_id: location.id }

      expect(response).to be_ok
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    subject(:create_request) do
      post :create, params: { location_id: location.id, product: { name: "Test Product", price: 100 } }
    end

    it "creates a new product" do
      expect { create_request }.to change { location.products.count }.by(1)
    end

    it "redirects to the index page" do
      create_request
      expect(response).to redirect_to(location_products_path(location))
    end
  end

  describe "GET #show" do
    let(:product) { create(:product, location:) }

    it "renders the show template" do
      get :show, params: { location_id: location.id, id: product.id }

      expect(response).to be_ok
      expect(response).to render_template(:show)
    end
  end
end

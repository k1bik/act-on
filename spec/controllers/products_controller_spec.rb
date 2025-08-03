require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:location) { create(:location) }
  let(:product) { create(:product, location:) }

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
      post :create, params: { location_id: location.id, product: { name: "Test Product", price: 100 } }, as: :turbo_stream
    end

    it "creates a new product" do
      expect { create_request }.to change { location.products.count }.by(1)
      expect(response).to be_ok
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: { location_id: location.id, id: product.id }

      expect(response).to be_ok
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH #update_name" do
    subject do
      patch(
        :update_name,
        params: { location_id: location.id, id: product.id, product: { name: "New Name" } },
        as: :turbo_stream
      )
    end

    let(:product) { create(:product, location:, name: "Old Name") }

    it "updates the product name" do
      expect { subject }.to change { product.reload.name }.from("Old Name").to("New Name")
      expect(response).to be_ok
    end
  end

  describe "PATCH #update_price" do
    subject do
      patch(
        :update_price,
        params: { location_id: location.id, id: product.id, product: { price: 200 } },
        as: :turbo_stream
      )
    end

    let(:product) { create(:product, location:, price: 100) }

    it "updates the product price" do
      expect { subject }.to change { product.reload.price }.from(100).to(200)
      expect(response).to be_ok
    end
  end

  describe "PATCH #update_description" do
    subject do
      patch(
        :update_description,
        params: { location_id: location.id, id: product.id, product: { description: "New Description" } },
        as: :turbo_stream
      )
    end

    let(:product) { create(:product, location:, description: "Old Description") }

    it "updates the product description" do
      expect { subject }.to change { product.reload.description }.from("Old Description").to("New Description")
      expect(response).to be_ok
    end
  end

  describe "GET #edit_name" do
    subject { get :edit_name, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the edit_name template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_edit_product_name_form")
    end
  end

  describe "GET #edit_price" do
    subject { get :edit_price, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the edit_price template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_edit_product_price_form")
    end
  end

  describe "GET #edit_description" do
    subject { get :edit_description, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the edit_description template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_edit_product_description_form")
    end
  end

  describe "GET #cancel_editing_name" do
    subject { get :cancel_editing_name, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the product_name template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_product_name")
    end
  end

  describe "GET #cancel_editing_price" do
    subject { get :cancel_editing_price, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the product_price template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_product_price")
    end
  end

  describe "GET #cancel_editing_description" do
    subject { get :cancel_editing_description, params: { location_id: location.id, id: product.id }, as: :turbo_stream }

    it "renders the product_description template" do
      subject
      expect(response).to be_ok
      expect(response).to render_template("products/_product_description")
    end
  end
end

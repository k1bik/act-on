require "rails_helper"

RSpec.describe LocationsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new

      expect(response).to be_ok
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    let(:location) { create(:location) }

    it "renders the edit template" do
      get :edit, params: { id: location.id }

      expect(response).to be_ok
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    subject { patch :update, params: { id: location.id, location: { address: "xyz" } }, as: :turbo_stream }

    let(:location) { create(:location, address: "abc") }

    it "updates the location and renders the edit template" do
      expect { subject }.to change { location.reload.address }.from("abc").to("xyz")
      expect(response).to be_ok
      expect(flash[:notice]).to eq("Адрес успешно обновлен!")
    end

    context "when the location is invalid" do
      subject { patch :update, params: { id: location.id, location: { address: "" } } }

      it "does not update the location and renders the edit template" do
        expect { subject }.not_to change { location.reload.address }
        expect(response).to be_ok
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "POST #create" do
    subject { post :create, params: }

    let(:params) { { location: { address: "xyz" } } }

    it "creates a new location" do
      expect { subject }.to change { Location.count }.by(1)

      expect(response).to be_redirect
      expect(response).to redirect_to(location_products_path(Location.last))
      expect(flash[:notice]).to eq("Location created successfully")
    end

    context "when the location is invalid" do
      let(:params) { { location: { address: "" } } }

      it "does not create a new location and renders the new template" do
        expect { subject }.not_to change { Location.count }

        expect(response).to be_ok
        expect(response).to render_template(:new)
      end
    end
  end
end

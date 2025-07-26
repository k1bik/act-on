require "rails_helper"

RSpec.describe LocationsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new

      expect(response).to be_ok
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    subject { post :create, params: }

    let(:params) { { location: { address: "xyz" } } }

    it "creates a new location" do
      expect { subject }.to change { Location.count }.by(1)

      expect(response).to be_redirect
      expect(response).to redirect_to(root_path)
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

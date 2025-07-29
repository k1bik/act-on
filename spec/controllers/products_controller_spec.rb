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
end

require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let(:location) { create(:location) }
  let(:order) { create(:order, location:) }

  describe "GET #index" do
    it "renders the index template" do
      get :index, params: { location_id: location.id }

      expect(response).to be_ok
      expect(response).to render_template(:index)
    end
  end
end

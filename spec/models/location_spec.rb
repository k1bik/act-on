require "rails_helper"

RSpec.describe Location, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:products) }
  end

  describe "validations" do
    subject { build(:location) }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_uniqueness_of(:address).case_insensitive }
    it { is_expected.to validate_length_of(:address).is_at_most(255) }
  end

  context "when is the location being archived" do
    let(:location) { create(:location) }
    let(:product) { create(:product, location:) }

    it "should archive all products" do
      expect(location).to be_undiscarded
      expect(product).to be_undiscarded

      expect { location.discard }.to change { location.discarded? }.from(false).to(true)
        .and change { product.reload.discarded? }.from(false).to(true)
    end
  end
end

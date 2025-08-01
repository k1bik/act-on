require "rails_helper"

RSpec.describe Product, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:location) }
  end

  describe "validations" do
    let(:location) { create(:location) }

    subject { build(:product, location:) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:location_id) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0).is_less_than(1_000_000) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
  end
end

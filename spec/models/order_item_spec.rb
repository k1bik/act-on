require "rails_helper"

RSpec.describe OrderItem, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }

    it "should not allow products from different locations" do
      location1 = create(:location)
      location2 = create(:location)
      order = create(:order, location: location1)
      product = create(:product, location: location2)
      order_item = build(:order_item, order:, product:)

      expect(order_item).to be_invalid
      expect(order_item.errors[:base]).to include("Product must be from the same location as the order")
    end

    it "should not allow products to be discarded on create" do
      location = create(:location)
      product = create(:product, location:, discarded_at: 1.day.ago)
      order_item = build(:order_item, product:)

      expect(order_item).to be_invalid
      expect(order_item.errors[:base]).to include("Product is not available")
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end

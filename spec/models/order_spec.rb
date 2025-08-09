require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:location) }
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:products).through(:order_items) }
  end

  describe "validations" do
    let(:location) { create(:location) }

    subject { build(:order, location:) }

    it { is_expected.to validate_presence_of(:due_date) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_uniqueness_of(:number).case_insensitive }
  end
end

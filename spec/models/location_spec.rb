# typed: false

require "rails_helper"

RSpec.describe Location, type: :model do
  describe "validations" do
    subject { build(:location) }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_uniqueness_of(:address).case_insensitive }
  end
end

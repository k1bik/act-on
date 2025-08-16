require "rails_helper"

RSpec.describe TelegramUser, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:location).optional }
  end

  describe "validations" do
    subject { build(:telegram_user) }

    it { is_expected.to validate_presence_of(:chat_id) }
    it { is_expected.to validate_uniqueness_of(:chat_id) }
    it { is_expected.to validate_presence_of(:first_name) }
  end
end

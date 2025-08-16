# typed: strict

class TelegramUser < ApplicationRecord
  belongs_to :location, optional: true

  validates :chat_id, presence: true, uniqueness: true
  validates :first_name, presence: true
end

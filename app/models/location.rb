# typed: strict

class Location < ApplicationRecord
  include Discard::Model

  T.unsafe(self).after_discard do |location|
    location.products.discard_all
  end

  has_many :products
  has_many :orders

  validates :address,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 }
end

# typed: strict

class Location < ApplicationRecord
  include Discard::Model

  T.unsafe(self).after_discard do |location|
    location.products.discard_all
  end

  has_many :products

  validates :address, presence: true, uniqueness: { case_sensitive: false }
end

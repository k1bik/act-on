# typed: strict

class Product < ApplicationRecord
  include Discard::Model

  belongs_to :location

  validates :name, presence: true, uniqueness: { scope: :location_id }
  validates :price, presence: true, numericality: { greater_than: 0 }
end

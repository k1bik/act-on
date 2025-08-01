# typed: strict

class Product < ApplicationRecord
  include Discard::Model

  belongs_to :location

  validates :name, presence: true, uniqueness: { scope: :location_id }, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
end

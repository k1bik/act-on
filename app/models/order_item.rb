# typed: strict

class OrderItem < ApplicationRecord
  extend T::Sig

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :order_and_product_same_location
  validate :product_is_available, on: :create

  private

  sig { void }
  def order_and_product_same_location
    if order && product && T.must(order).location_id != T.must(product).location_id
      errors.add(:base, "Product must be from the same location as the order")
    end
  end

  sig { void }
  def product_is_available
    if product && T.must(product).discarded?
      errors.add(:base, "Product is not available")
    end
  end
end

# typed: strict

class OrderItem < ApplicationRecord
  extend T::Sig

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  validate :order_and_product_same_location, if: ->(item) { item.order.present? && item.product.present? }
  validate :product_is_available, if: ->(item) { item.product.present? }, on: :create

  private

  sig { void }
  def order_and_product_same_location
    if T.must(order).location_id != T.must(product).location_id
      errors.add(:base, "Product must be from the same location as the order")
    end
  end

  sig { void }
  def product_is_available
    return if T.must(product).undiscarded?

    errors.add(:base, "Product is not available")
  end
end

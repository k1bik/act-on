# typed: strict

module ViewComponents
  class ProductCard < ViewComponent::Base
    extend T::Sig

    sig do
      params(
        location_id: Integer,
        product_id: Integer,
        product_name: String,
        price: Numeric,
        description: T.nilable(String)
      ).void
    end
    def initialize(location_id:, product_id:, product_name:, price:, description:)
      @location_id = location_id
      @product_id = product_id
      @product_name = product_name
      @price = price
      @description = description
    end
  end
end

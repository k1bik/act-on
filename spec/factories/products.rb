FactoryBot.define do
  factory :product do
    sequence(:name) { "Product #{it}" }
    price { 100 }
    description { "Product description" }
  end
end

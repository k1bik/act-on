FactoryBot.define do
  factory :location do
    sequence(:address) { "xyz#{it}" }
  end
end

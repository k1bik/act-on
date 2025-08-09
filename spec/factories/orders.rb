FactoryBot.define do
  factory :order do
    sequence(:number) { "Order-#{it}" }
    due_date { DateTime.current + 30.minutes }
  end
end

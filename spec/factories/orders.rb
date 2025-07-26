FactoryBot.define do
  factory :order do
    due_date { DateTime.current + 30.minutes }
  end
end

FactoryBot.define do
  factory :telegram_user do
    sequence(:chat_id) { "Chat #{it}" }
    first_name { "First Name" }
    last_name { "Last Name" }
    username { "Username" }
  end
end

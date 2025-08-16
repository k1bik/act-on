# typed: strict

module Structs
  class TelegramUserStruct < T::Struct
    const :chat_id, String
    const :first_name, String
    const :last_name, T.nilable(String)
    const :username, T.nilable(String)
  end
end

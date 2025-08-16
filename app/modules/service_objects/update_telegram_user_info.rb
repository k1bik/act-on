# typed: strict

module ServiceObjects
  class UpdateTelegramUserInfo
    extend T::Sig

    sig { params(user: TelegramUser, user_struct: Structs::TelegramUserStruct).void }
    def call(user, user_struct)
      return unless user_info_changed?(user, user_struct)

      user.update!(user_struct.serialize)
    end

    private

    sig { params(user: TelegramUser, user_struct: Structs::TelegramUserStruct).returns(T::Boolean) }
    def user_info_changed?(user, user_struct)
      user_struct.serialize.any? do |key, value|
        user.public_send(key) != value
      end
    end
  end
end

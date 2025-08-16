# typed: strict

class TelegramController < Telegram::Bot::UpdatesController
  extend T::Sig
  include Telegram::Bot::UpdatesController::CallbackQueryContext
  include Telegram::Bot::UpdatesController::MessageContext

  sig { void }
  def start!
    user = TelegramUser.find_or_initialize_by(chat_id: current_user_struct.chat_id)

    if user.new_record?
      user.assign_attributes(current_user_struct.serialize)

      user.save!
    else
      ServiceObjects::UpdateTelegramUserInfo.new.call(user, current_user_struct)
    end

    respond_with :message,
      text: "Hello, #{user.first_name}!",
      reply_markup: {
        inline_keyboard: Location.pluck(:address, :id).map do |address, id|
          [ { text: address, callback_data: "location_selection:#{id}" } ]
        end
      }
  end

  sig { void }
  def collect_order!
    ServiceObjects::UpdateTelegramUserInfo.new.call(current_user, current_user_struct)

    if (location = current_user.location).blank?
      change_location!
    else
      session[:order_items] = []
      respond_with :message,
        text: "Please select a product",
        reply_markup: {
          inline_keyboard: location.products.pluck(:name, :id).map do |name, id|
            [ { text: name, callback_data: "product_selection:#{id}" } ]
          end
        }
    end
  end

  sig { void }
  def change_location!
    ServiceObjects::UpdateTelegramUserInfo.new.call(current_user, current_user_struct)

    respond_with :message,
      text: "Please select a location",
      reply_markup: {
        inline_keyboard: Location.pluck(:address, :id).map do |address, id|
          [ { text: address, callback_data: "location_selection:#{id}" } ]
        end
      }
  end

  sig { params(product_id: String, args: T.untyped).void }
  def product_selection_callback_query(product_id, *args)
    ServiceObjects::UpdateTelegramUserInfo.new.call(current_user, current_user_struct)

    product = T.must(current_user.location).products.find_by(id: product_id)

    if product.present?
      session[:order_items] ||= []
      session[:order_items] << product_id

      respond_with :message,
        text: "Вы добавили в ваш заказ #{product.name}, #{session[:order_items]}",
        reply_markup: {
          inline_keyboard: [
            [ { text: "Оформить заказ", callback_data: "order_confirmation:1" } ]
          ]
        }
    end
  end

  sig { params(args: T.untyped).void }
  def order_confirmation_callback_query(*args)
    ServiceObjects::UpdateTelegramUserInfo.new.call(current_user, current_user_struct)
    location = T.must(current_user.location)
    products_by_name = location.products.pluck(:id, :name).to_h.stringify_keys

    q = session[:order_items].tally.map do |product_id, quantity|
      products_by_name[product_id] + " x #{quantity}"
    end

    respond_with :message, text: q
  end

  sig { params(location_id: String, args: T.untyped).void }
  def location_selection_callback_query(location_id, *args)
    ServiceObjects::UpdateTelegramUserInfo.new.call(current_user, current_user_struct)

    unless current_user.location_id == location_id
      current_user.update!(location_id:)
    end

    respond_with :message, text: "Location updated"
  end

  private

  sig { returns(TelegramUser) }
  def current_user
    TelegramUser.find_by!(chat_id: chat["id"])
  end

  sig { returns(Structs::TelegramUserStruct) }
  def current_user_struct
    Structs::TelegramUserStruct.new(
      chat_id: chat["id"].to_s,
      first_name: from["first_name"],
      last_name: from["last_name"],
      username: from["username"]
    )
  end
end

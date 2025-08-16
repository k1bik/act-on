if Rails.env.test?
  require "telegram/bot/client_stub"
  Telegram::Bot::ClientStub.stub_all!

  Telegram.bots[:default] = Telegram::Bot::Client.new("test_token")
else
  Telegram.bots[:default] = Telegram::Bot::Client.new(ENV["TELEGRAM_BOT_TOKEN"])
end

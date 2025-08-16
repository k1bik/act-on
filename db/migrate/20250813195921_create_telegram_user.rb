class CreateTelegramUser < ActiveRecord::Migration[8.0]
  def change
    create_table :telegram_users do |t|
      t.references :location, null: true, foreign_key: true
      t.string :chat_id, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name, null: true
      t.string :username, null: true
      t.timestamps
    end
  end
end

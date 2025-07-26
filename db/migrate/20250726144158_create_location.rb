class CreateLocation < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :address, null: false
      t.datetime :discarded_at, index: true
      t.timestamps

      t.index :address, unique: true
    end
  end
end

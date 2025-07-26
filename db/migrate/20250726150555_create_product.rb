class CreateProduct < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :location, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.text :description
      t.datetime :discarded_at, index: true
      t.timestamps

      t.index [:location_id, :name], unique: true
    end
  end
end

class CreateOrder < ActiveRecord::Migration[8.0]
  def change
    create_enum :order_status, [ "created", "in_progress", "awaiting_pickup", "completed" ]

    create_table :orders do |t|
      t.references :location, null: false, foreign_key: true
      t.enum :status, enum_type: :order_status, null: false, default: "created"
      t.datetime :due_date, null: false
      t.timestamps
    end
  end
end

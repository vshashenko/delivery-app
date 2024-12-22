class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.string :pickup_address,   null: false
      t.string :delivery_address, null: false
      t.float :weight,            null: false
      t.float :distance,          null: false
      t.datetime :scheduled_time, null: false
      t.decimal :cost,            null: false
      t.string :driver_name

      t.timestamps
    end
  end
end

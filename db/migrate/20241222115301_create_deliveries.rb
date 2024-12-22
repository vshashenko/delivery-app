class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.string :pickup_address
      t.string :delivery_address
      t.float :weight
      t.float :distance
      t.datetime :scheduled_time
      t.decimal :cost
      t.string :driver_name

      t.timestamps
    end
  end
end

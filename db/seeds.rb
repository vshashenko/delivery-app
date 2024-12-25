# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Delivery.create(
  pickup_address: '123 Main St',
  delivery_address: '456 Oak St',
  weight: 5.5,
  distance: 10,
  scheduled_time: '2024-12-30 14:00:00',
  cost: 100.50,
  driver_name: 'John Doe'
)

Delivery.create(
  pickup_address: '789 Elm St',
  delivery_address: '101 Pine St',
  weight: 3.2,
  distance: 7,
  scheduled_time: '2024-12-30 15:30:00',
  cost: 50.25,
  driver_name: 'Jane Smith'
)

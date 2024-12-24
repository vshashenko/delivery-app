class Delivery < ApplicationRecord
    # TODO validations?
    # validates :driver_name, presence: false
    # address >= 3
    # if html form sends empty string for driver, is it null here?
  validates :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, :cost, presence: true
  validates :cost, numericality: { greater_than: 0 }
end

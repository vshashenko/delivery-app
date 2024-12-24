class Delivery < ApplicationRecord
  before_validation :convert_empty_attrs_to_nil

  # Make sure to keep equal to client-side validations
  validates :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, :cost, presence: true
  validates :weight, :distance, :cost, numericality: { greater_than: 0 }
  validates :pickup_address, :delivery_address, length: { minimum: 3, maximum: 255 }
  validates :driver_name, length: { minimum: 1, maximum: 255 }, allow_nil: true
  # TODO validate scheduled_time not in the past?

  private

  def convert_empty_attrs_to_nil
    self.driver_name = nil if self.driver_name.blank?
  end
end

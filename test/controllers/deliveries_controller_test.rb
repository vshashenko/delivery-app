require "test_helper"

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::NumberHelper

  setup do
    @delivery = deliveries(:two)
  end

  test "should get index" do
    get deliveries_url
    # puts @response.body
    assert_response :success
    assert_select "h2", "Deliveries"
    assert_select "div#deliveries > div:nth-child(9)", @delivery.pickup_address
    assert_select "div#deliveries > div:nth-child(10)", @delivery.delivery_address
    assert_select "div#deliveries > div:nth-child(11)", @delivery.weight.to_s
    assert_select "div#deliveries > div:nth-child(12)", @delivery.distance.to_s
    assert_select "div#deliveries > div:nth-child(13)", @delivery.scheduled_time.strftime("%B %d, %Y %H:%M")
    assert_select "div#deliveries > div:nth-child(14)", number_to_currency(@delivery.cost)
    assert_select "div#deliveries > div:nth-child(15)", @delivery.driver_name
  end

  test "should get new" do
    get deliveries_new_path
    assert_response :success
    assert_select "h2", "New delivery"
    # TODO assert other html content
  end

  test "should create delivery" do
    assert_difference("Delivery.count") do
      post deliveries_url, params: { delivery: { pickup_address: "123 Main St", delivery_address: "456 Elm St", weight: 5.0, distance: 10.0, scheduled_time: Time.now + 1.day, cost: 20.0, driver_name: "John Doe" } }
    end

    assert_redirected_to deliveries_path
  end

  test "should show total cost" do
    get deliveries_total_cost_path
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "29.98", json["total_cost"]
  end

  test "should not create delivery with invalid params" do
    post deliveries_url, params: { delivery: { pickup_address: "", delivery_address: "", weight: 0, distance: 0, scheduled_time: nil, cost: 0 } }
    assert_response :unprocessable_entity
  end

  # TODO add more test cases
end

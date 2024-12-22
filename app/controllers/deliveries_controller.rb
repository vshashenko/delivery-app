class DeliveriesController < ApplicationController
  def index
    # render plain: "hello"

    page = params[:page] || 1

    # deliveries = Delivery.all
    deliveries = Delivery.page(page).per(10)
    
    meta = {
      current_page: deliveries.current_page,
      total_pages: deliveries.total_pages,
      total_count: deliveries.total_count
    }

    render json: { deliveries: deliveries, meta: meta }
  end

  def total_cost
    total = Delivery.sum(:cost)
    render json: { total_cost: total }
  end
end

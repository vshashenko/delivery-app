class DeliveriesController < ApplicationController
  def index
    # puts "pickup_address=", params[:pickup_address]
    # puts "driver_name=", params[:driver_name]

    itemsPerPage = 10
    page = params[:page] || 1

    query = Delivery.select("*, SUM(cost) OVER () AS total_cost")
    if params[:pickup_address].present?
      query = query.where("LOWER(pickup_address) LIKE ?", "%#{params[:pickup_address].downcase}%")
    end
    if params[:delivery_address].present?
      query = query.where("LOWER(delivery_address) LIKE ?", "%#{params[:delivery_address].downcase}%")
    end
    if params[:weight].present?
      query = query.where("weight=?", params[:weight])
    end
    if params[:distance].present?
      query = query.where("distance=?", params[:distance])
    end
    if params[:cost].present?
      query = query.where("cost=?", params[:cost])
    end
    if params[:driver_name].present?
      query = query.where("LOWER(driver_name) LIKE ?", "%#{params[:driver_name].downcase}%")
    end

    @deliveries = query.page(page).per(itemsPerPage)

    # TODO causes additional sql query
    @total_cost = @deliveries.first&.[](:total_cost) || 0

    # @deliveries = Delivery.all
    # @deliveries = Delivery.page(page).per(itemsPerPage)
  end

  # Unused, but it's in the assignment
  # We calculate the total cost while getting the items, not needing a separate call
  def total_cost
    total = Delivery.sum(:cost).round(2)
    render json: { total_cost: total }
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(validated_delivery_params)

    if @delivery.save
      # render json: delivery, status: :created
      redirect_to deliveries_path, notice: "Delivery was successfully created."
    else
      # render json: { errors: delivery.errors.full_messages }, status: :unprocessable_entity
      # puts @delivery.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def validated_delivery_params
    # TODO add require for inner fields, remove from permit
    # TODO test missing/overspec fields after ui ready
    params.require(:delivery).permit(
      :pickup_address,
      :delivery_address,
      :weight,
      :distance,
      :scheduled_time,
      :cost,
      :driver_name
    )
  end
end

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    result = restaurant_service.get_all_data

    @data = result[:data]
    @errors = result[:errors]

    render 'restaurants/index', status: result[:status]
  end

  def show
    @data = @restaurant

    render 'restaurants/show', status: :ok
  end

  def create
    result = restaurant_service.create(restaurant_params)

    @data = result[:data]
    @errors = result[:errors]

    render 'restaurants/show', status: result[:status]
  end

  def update
    result = restaurant_service.update(@restaurant, restaurant_params)

    @data = result[:data]
    @errors = result[:errors]

    render 'restaurants/show', status: result[:status]
  end

  def destroy
    result = restaurant_service.destroy(@restaurant)

    render json: { message: result[:message] }, status: result[:status]
  end

  private

  def restaurant_service
    @restaurant_service ||= RestaurantService.new
  end

  def set_restaurant
    @restaurant = restaurant_service.find(params[:id])
    render json: { error: 'Restaurant not found' }, status: :not_found unless @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end

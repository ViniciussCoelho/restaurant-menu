class Restaurants::MenusController < ApplicationController
  before_action :set_menu, only: %i[show update destroy]

  def index
    result = menu_service.get_all_data(params[:restaurant_id])

    @data = result[:data]
    @errors = result[:errors]

    render '/menus/index', status: result[:status]
  end

  def show
    @data = @menu

    render '/menus/show', status: :ok
  end

  def create
    result = menu_service.create(menu_params)

    @data = result[:data]
    @errors = result[:errors]

    render '/menus/show', status: result[:status]
  end

  def update
    result = menu_service.update(@menu, menu_params)

    @data = result[:data]
    @errors = result[:errors]

    render '/menus/show', status: result[:status]
  end

  def destroy
    result = menu_service.destroy(@menu)

    render json: { message: result[:message] }, status: result[:status]
  end

  private

  def menu_service
    @menu_service ||= MenuService.new
  end

  def restaurant_service
    @restaurant_service ||= RestaurantService.new
  end

  def set_menu
    @menu = menu_service.find(params[:id])

    return render json: { error: 'Menu not found' }, status: :not_found unless @menu

    if @menu&.restaurant_id != params[:restaurant_id].to_i
      return render json: { error: 'Menu does not belong to the restaurant' }, status: :not_found
    end
  end

  def menu_params
    params.require(:menu).permit(:name).merge(restaurant_id: params[:restaurant_id])
  end
end

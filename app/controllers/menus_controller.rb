class MenusController < ApplicationController
  before_action :set_menu, only: %i[show update destroy]

  def index
    result = menu_service.get_all_data
    render json: result[:data], status: result[:status]
  end

  def show
    render json: @menu
  end

  def create
    result = menu_service.create(menu_params)

    render json: result[:data], status: result[:status]
  end

  def update
    result = menu_service.update(@menu, menu_params)

    render json: result[:data], status: result[:status]
  end

  def destroy
    result = menu_service.destroy(@menu)

    render json: { message: result[:message] }, status: result[:status]
  end

  private

  def menu_service
    @menu_service ||= MenuService.new
  end

  def set_menu
    @menu = menu_service.find(params[:id])
    render json: { error: 'Menu not found' }, status: :not_found unless @menu
  end

  def menu_params
    params.require(:menu).permit(:name)
  end
end

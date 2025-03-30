class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[show update destroy]

  def index
    result = menu_item_service.get_all_data

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_items/index', status: result[:status]
  end

  def show
    @data = @menu_item
    render 'menu_items/show', status: :ok
  end

  def create
    result = menu_item_service.create(menu_item_params)

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_items/show', status: result[:status]
  end

  def update
    result = menu_item_service.update(@menu_item, menu_item_params)

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_items/show', status: result[:status]
  end

  def destroy
    result = menu_item_service.destroy(@menu_item)

    @errors = result[:errors]

    render 'menu_items/show', status: result[:status]
  end

  private

  def menu_item_service
    @menu_item_service ||= MenuItemService.new
  end

  def set_menu_item
    @menu_item = menu_item_service.find(params[:id])
    render json: { error: 'Menu item not found' }, status: :not_found unless @menu_item
  end

  def menu_item_params
    params.require(:menu_item).permit(:name)
  end
end

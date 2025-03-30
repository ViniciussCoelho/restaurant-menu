class Menus::MenuListingsController < ApplicationController
  before_action :set_menu_listing, only: %i[show update destroy]

  def index
    result = menu_listing_service.get_all_data(params[:menu_id])

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_listings/index', status: result[:status]
  end

  def show
    @data = @menu_listing

    render 'menu_listings/show', status: :ok
  end

  def create
    result = menu_listing_service.create(menu_listing_params, params[:menu_id])

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_listings/show', status: result[:status]
  end

  def update
    result = menu_listing_service.update(@menu_listing, menu_listing_params)

    @data = result[:data]
    @errors = result[:errors]

    render 'menu_listings/show', status: result[:status]
  end

  def destroy
    result = menu_listing_service.destroy(@menu_listing)

    render json: { message: result[:message] }, status: result[:status]
  end

  private

  def menu_listing_service
    @menu_listing_service ||= MenuListingService.new
  end

  def set_menu_listing
    @menu_listing = menu_listing_service.find(params[:id])

    return render json: { error: 'Menu item not found' }, status: :not_found unless @menu_listing

    if @menu_listing&.menu_id != params[:menu_id].to_i
      return render json: { error: 'The menu item does not belong to the specified menu' }, status: :not_found
    end
  end

  def menu_listing_params
    params.require(:menu_listing).permit(:description, :price, :menu_item_name)
  end
end

class MenuListingService
  def get_all_data(menu_id)
    menu_listed_items = MenuListing.includes(:menu_item).where(menu_id: menu_id).order(id: :asc)
    { status: :ok, data: menu_listed_items }
  end

  def create(menu_listing_params, menu_id)
    menu_item = find_or_create_menu_item(menu_listing_params[:menu_item_name])

    return { status: :unprocessable_entity, data: nil, errors: ['Name cannot be blank'] } unless menu_item.persisted?

    menu_listing = MenuListing.new(
      menu_id: menu_id,
      menu_item_id: menu_item.id,
      price: menu_listing_params[:price],
      description: menu_listing_params[:description]
    )

    if menu_listing.save
      { status: :created, data: menu_listing, errors: nil }
    else
      { status: :unprocessable_entity, data: nil, errors: menu_listing.errors.full_messages }
    end
  end

  def update(menu_listing, menu_listing_params)
    menu_item = find_or_create_menu_item(menu_listing_params[:menu_item_name])

    return { status: :unprocessable_entity, data: nil, errors: ['Name cannot be blank'] } unless menu_item.persisted?

    if menu_listing.update(
      menu_item_id: menu_item.id,
      price: menu_listing_params[:price],
      description: menu_listing_params[:description]
    )
      { status: :ok, data: menu_listing }
    else
      { status: :unprocessable_entity, data: nil, errors: menu_listing.errors.full_messages }
    end
  end

  def destroy(menu_listing)
    menu_listing.destroy
    { status: :no_content, message: 'Menu item removed from the menu successfully' }
  end

  def find(id)
    MenuListing.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private

  def find_or_create_menu_item(name)
    MenuItem.find_or_create_by(name: name)
  end
end

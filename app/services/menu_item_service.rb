class MenuItemService
  def get_all_data
    menu_items = MenuItem.all
    { status: :ok, data: menu_items }
  end

  def create(menu_item_params)
    menu_item = MenuItem.new(menu_item_params)

    if menu_item.save
      { status: :created, data: menu_item }
    else
      { status: :unprocessable_entity, errors: menu_item.errors.full_messages }
    end
  end

  def update(menu_item, menu_item_params)
    if menu_item.update(menu_item_params)
      { status: :ok, data: menu_item }
    else
      { status: :unprocessable_entity, errors: menu_item.errors.full_messages }
    end
  end

  def destroy(menu_item)
    menu_item.destroy
    { status: :no_content, message: 'Menu item deleted successfully' }
  end

  def find(id)
    MenuItem.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end

class MenuService
  def get_all_data(restaurant_id)
    menus = Menu.where(restaurant_id: restaurant_id).order(id: :asc)
    { status: :ok, data: menus }
  end

  def create(menu_params)
    menu = Menu.new(menu_params)

    if menu.save
      { status: :created, data: menu }
    else
      { status: :unprocessable_entity, errors: menu.errors.full_messages }
    end
  end

  def update(menu, menu_params)
    if menu.update(menu_params)
      { status: :ok, data: menu }
    else
      { status: :unprocessable_entity, errors: menu.errors.full_messages }
    end
  end

  def destroy(menu)
    menu.destroy
    { status: :no_content, message: 'Menu deleted successfully' }
  end

  def find(id)
    Menu.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end

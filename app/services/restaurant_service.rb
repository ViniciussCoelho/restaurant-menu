class RestaurantService
  def get_all_data
    restaurants = Restaurant.order(id: :asc)
    { status: :ok, data: restaurants, errors: nil }
  end

  def create(restaurant_params)
    restaurant = Restaurant.new(restaurant_params)

    if restaurant.save
      { status: :created, data: restaurant, errors: nil }
    else
      { status: :unprocessable_entity, data: nil, errors: restaurant.errors.full_messages }
    end
  end

  def update(restaurant, restaurant_params)
    if restaurant.update(restaurant_params)
      { status: :ok, data: restaurant, errors: nil }
    else
      { status: :unprocessable_entity, data: nil, errors: restaurant.errors.full_messages }
    end
  end

  def destroy(restaurant)
    restaurant.destroy
    { status: :no_content, message: 'Restaurant deleted successfully' }
  end

  def find(id)
    Restaurant.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end

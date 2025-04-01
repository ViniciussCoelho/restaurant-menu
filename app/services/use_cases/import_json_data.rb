module UseCases
  class ImportJsonData
    def initialize(file)
      @file = file
      @results = {
        successful: [],
        failed: []
      }
    end

    def execute
      return { status: :failure, message: "No file provided", results: @results } if @file.blank?

      begin
        file_content = @file.read
        data = Oj.load(file_content)
        process_restaurants(data['restaurants'])

        message = @results[:failed].empty? ?
          "Import completed successfully" :
          "Import completed with some errors"

        { status: :ok, message: message, results: @results }
      rescue StandardError => e
        Rails.logger.error "Error processing file: #{e.message}"
        { status: :failure, message: "Fatal error: #{e.message}", results: @results }
      end
    end

    private

    def process_restaurants(restaurants)
      restaurants.each do |restaurant_data|
        begin
          ActiveRecord::Base.transaction do
            restaurant = find_or_create_restaurant(restaurant_data)
            process_menus(restaurant, restaurant_data['menus'] || [])
          end
        rescue StandardError => e
          record_failure("Restaurant", restaurant_data['name'], e.message)
        end
      end
    end

    def find_or_create_restaurant(restaurant_data)
      restaurant = Restaurant.find_or_initialize_by(name: restaurant_data['name'])

      unless restaurant.save
        errors = restaurant.errors.full_messages.join(', ')
        raise "Failed to save restaurant: #{errors}"
      end

      record_success("Restaurant", restaurant_data['name'])
      restaurant
    end

    def process_menus(restaurant, menus)
      menus.each do |menu_data|
        begin
          ActiveRecord::Base.transaction do
            menu = find_or_create_menu(restaurant, menu_data)

            items_key = menu_data['menu_items'] || menu_data['dishes'] || []
            process_menu_items(menu, items_key)
          end
        rescue StandardError => e
          record_failure("Menu", menu_data['name'], e.message)
        end
      end
    end

    def find_or_create_menu(restaurant, menu_data)
      menu = restaurant.menus.find_or_initialize_by(name: menu_data['name'])

      unless menu.save
        errors = menu.errors.full_messages.join(', ')
        raise "Failed to save menu: #{errors}"
      end

      record_success("Menu", menu_data['name'])
      menu
    end

    def process_menu_items(menu, items)
      items.each do |item_data|
        begin
          MenuItem.transaction do
            create_or_update_menu_item_with_listing(menu, item_data)
          end
        rescue StandardError => e
          record_failure("Menu Item", item_data['name'], e.message)
        end
      end
    end

    def create_or_update_menu_item_with_listing(menu, item_data)
      menu_item = MenuItem.find_or_initialize_by(name: item_data['name'])

      unless menu_item.save
        errors = menu_item.errors.full_messages.join(', ')
        raise "Failed to save menu item: #{errors}"
      end

      menu_listing = MenuListing.find_or_initialize_by(
        menu_id: menu.id,
        menu_item_id: menu_item.id
      )

      menu_listing.price = item_data['price'] if item_data['price']
      menu_listing.description = item_data['description'] if item_data['description']

      unless menu_listing.save
        errors = menu_listing.errors.full_messages.join(', ')
        raise "Failed to save menu listing: #{errors}"
      end

      record_success("Menu Item", item_data['name'])
    end

    def record_success(entity_type, name)
      @results[:successful] << {
        type: entity_type,
        name: name
      }
    end

    def record_failure(entity_type, name, reason)
      @results[:failed] << {
        type: entity_type,
        name: name,
        reason: reason
      }
    end
  end
end

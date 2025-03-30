if @errors.present?
  json.errors @errors do |error|
    json.message error.message
  end
end

if @data.present?
  json.menu_listings @data do |menu_listing|
    json.id menu_listing.id
    json.menu_id menu_listing.menu_id
    json.name menu_listing.menu_item.name
    json.price menu_listing.price
    json.description menu_listing.description
    json.created_at menu_listing.created_at
    json.updated_at menu_listing.updated_at
  end
end

json.errors @errors if @errors.present?

if @data.present?
  json.menu_items @data do |menu_item|
    json.id menu_item.id
    json.name menu_item.name
    json.created_at menu_item.created_at
    json.updated_at menu_item.updated_at
  end
end

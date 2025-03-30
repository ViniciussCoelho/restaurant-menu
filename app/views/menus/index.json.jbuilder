if @errors.present?
  json.errors @errors do |error|
    json.message error
  end
end

if @data.present?
  json.menus @data do |menu|
    json.id menu.id
    json.restaurant_id menu.restaurant_id
    json.name menu.name
    json.created_at menu.created_at
    json.updated_at menu.updated_at
  end
end

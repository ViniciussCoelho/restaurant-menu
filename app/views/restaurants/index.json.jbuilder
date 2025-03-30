if @errors.present?
  json.errors @errors do |error|
    json.message error.message
  end
end

if @data.present?
  json.restaurants @data do |restaurant|
    json.id restaurant.id
    json.name restaurant.name
    json.created_at restaurant.created_at
    json.updated_at restaurant.updated_at
  end
end

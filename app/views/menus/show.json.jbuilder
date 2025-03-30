json.errors @errors if @errors.present?

if @data.present?
  json.menu do
    json.id @data.id
    json.restaurant_id @data.restaurant_id
    json.name @data.name
    json.created_at @data.created_at
    json.updated_at @data.updated_at
  end
end

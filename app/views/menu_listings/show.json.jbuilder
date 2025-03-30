json.errors @errors if @errors.present?

if @data.present?
  json.menu_listing do
    json.id @data.id
    json.menu_id @data.menu_id
    json.name @data.menu_item.name
    json.price @data.price
    json.description @data.description
    json.created_at @data.created_at
    json.updated_at @data.updated_at
  end
end

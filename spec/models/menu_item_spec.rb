# spec/models/menu_item_spec.rb
require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "is valid with a name and belongs to a menu" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    menu_item = create(:menu_item, menu: menu)
    expect(menu_item).to be_valid
  end

  it "is invalid without a name" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    menu_item = build(:menu_item, name: nil, menu: menu)
    expect(menu_item).to_not be_valid
  end

  it "is invalid without a menu" do
    menu_item = build(:menu_item, menu: nil)
    expect(menu_item).to_not be_valid
  end
end

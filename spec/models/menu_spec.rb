require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "has many menu_items" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    menu_item = create(:menu_item, menu: menu)
    expect(menu.menu_items).to include(menu_item)
  end

  it "belongs to a restaurant" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    expect(menu.restaurant).to eq(restaurant)
  end

  it "is invalid without a restaurant" do
    menu = build(:menu, restaurant: nil)
    expect(menu).to_not be_valid
  end

  it "is valid with a name" do
    restaurant = create(:restaurant)
    menu = build(:menu, restaurant: restaurant)
    expect(menu).to be_valid
  end

  it "is invalid without a name" do
    restaurant = create(:restaurant)
    menu = build(:menu, restaurant: restaurant, name: nil)
    expect(menu).to_not be_valid
  end
end

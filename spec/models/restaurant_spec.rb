require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "has many menus" do
    restaurant = create(:restaurant)
    menu = create(:menu, restaurant: restaurant)
    expect(restaurant.menus).to include(menu)
  end

  it "is valid with a name" do
    restaurant = build(:restaurant)
    expect(restaurant).to be_valid
  end

  it "is invalid without a name" do
    restaurant = build(:restaurant, name: nil)
    expect(restaurant).to_not be_valid
  end
end

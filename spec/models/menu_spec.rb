require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "has many menu_items" do
    menu = create(:menu)
    menu_item = create(:menu_item, menu: menu)
    expect(menu.menu_items).to include(menu_item)
  end

  it "is valid with a name" do
    menu = build(:menu)
    expect(menu).to be_valid
  end

  it "is invalid without a name" do
    menu = build(:menu, name: nil)
    expect(menu).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:restaurant) { create(:restaurant) }

  it { should belong_to(:restaurant) }
  it { should have_many(:menu_listings) }
  it { should have_many(:menu_items).through(:menu_listings) }
  it { should validate_presence_of(:name) }

  describe 'uniqueness of name' do
    it 'is valid when the name is unique' do
      menu = create(:menu, name: 'Unique Menu', restaurant: restaurant)
      expect(menu).to be_valid
    end

    it 'is invalid when the name is not unique' do
      create(:menu, name: 'Duplicate Menu', restaurant: restaurant)

      menu = build(:menu, name: 'Duplicate Menu', restaurant: restaurant)
      expect(menu).not_to be_valid
      expect(menu.errors[:name]).to include('has already been taken')
    end
  end
end

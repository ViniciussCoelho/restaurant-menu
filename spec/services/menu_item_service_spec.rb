require 'rails_helper'

RSpec.describe MenuItemService, type: :service do
  let(:valid_attributes) { { name: "Burger" } }
  let(:invalid_attributes) { { name: nil } }
  let(:menu_item) { create(:menu_item) }

  let(:menu_item_service) { MenuItemService.new }

  describe '#create' do
    context 'with valid attributes' do
      it 'creates a new menu item' do
        result = menu_item_service.create(valid_attributes)

        expect(result[:status]).to eq(:created)
        expect(result[:data]).to be_a(MenuItem)
        expect(result[:data].name).to eq("Burger")
      end
    end

    context 'with invalid attributes' do
      it 'does not create the menu item and returns errors' do
        result = menu_item_service.create(invalid_attributes)

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'updates the menu item' do
        result = menu_item_service.update(menu_item, { name: "Updated Burger" })

        expect(result[:status]).to eq(:ok)
        expect(result[:data].name).to eq("Updated Burger")
      end
    end

    context 'with invalid attributes' do
      it 'does not update the menu item and returns errors' do
        result = menu_item_service.update(menu_item, { name: nil })

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#destroy' do
    it 'destroys the menu item' do
      menu_item_to_destroy = create(:menu_item)

      result = menu_item_service.destroy(menu_item_to_destroy)

      expect(result[:status]).to eq(:no_content)
      expect(MenuItem.exists?(menu_item_to_destroy.id)).to be false
    end

    it 'does not destroy if associated menu_listing exists' do
      menu = create(:menu)
      menu_item_to_destroy = create(:menu_item)
      create(:menu_listing, menu: menu, menu_item: menu_item_to_destroy, price: 10.0)
      result = menu_item_service.destroy(menu_item_to_destroy)

      expect(result[:status]).to eq(:unprocessable_entity)
      expect(result[:errors]).to include("Cannot delete record because dependent menu listings exist")
    end
  end

  describe '#find' do
    context 'when the menu item exists' do
      it 'returns the menu item' do
        result = menu_item_service.find(menu_item.id)

        expect(result).to eq(menu_item)
      end
    end

    context 'when the menu item does not exist' do
      it 'returns nil' do
        result = menu_item_service.find(-1)

        expect(result).to be_nil
      end
    end
  end
end

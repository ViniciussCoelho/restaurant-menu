require 'rails_helper'

RSpec.describe MenuService, type: :service do
  let(:valid_attributes) { { name: "Lunch Menu" } }
  let(:invalid_attributes) { { name: nil } }
  let(:menu) { create(:menu) }
  let(:menu_service) { MenuService.new }

  describe '#create' do
    context 'with valid attributes' do
      it 'creates a new menu' do
        result = menu_service.create(valid_attributes)

        expect(result[:status]).to eq(:created)
        expect(result[:data]).to be_a(Menu)
        expect(result[:data].name).to eq("Lunch Menu")
      end
    end

    context 'with invalid attributes' do
      it 'does not create the menu and returns errors' do
        result = menu_service.create(invalid_attributes)

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'updates the menu' do
        result = menu_service.update(menu, { name: "Updated Menu" })

        expect(result[:status]).to eq(:ok)
        expect(result[:data].name).to eq("Updated Menu")
      end
    end

    context 'with invalid attributes' do
      it 'does not update the menu and returns errors' do
        result = menu_service.update(menu, { name: nil })

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#destroy' do
    it 'destroys the menu' do
      menu_to_destroy = create(:menu)

      result = menu_service.destroy(menu_to_destroy)

      expect(result[:status]).to eq(:no_content)
      expect(Menu.exists?(menu_to_destroy.id)).to be false
    end
  end

  describe '#find' do
    context 'when the menu exists' do
      it 'returns the menu' do
        result = menu_service.find(menu.id)

        expect(result).to eq(menu)
      end
    end

    context 'when the menu does not exist' do
      it 'returns nil' do
        result = menu_service.find(-1)

        expect(result).to be_nil
      end
    end
  end
end

require 'rails_helper'

RSpec.describe MenuListingService, type: :service do
  let(:service) { described_class.new }
  let(:menu) { create(:menu) }
  let(:menu_item) { create(:menu_item, name: 'Burger') }
  let(:menu_listing) { create(:menu_listing, menu: menu, menu_item: menu_item) }

  describe '#get_all_data' do
    it 'returns menu listings for a menu' do
      menu_listing1 = service.create({ menu_item_name: 'Pizza', price: 12.99, description: 'Delicious cheese pizza' }, menu.id)[:data]
      menu_listing2 = service.create({ menu_item_name: 'Pasta', price: 14.99, description: 'Classic carbonara pasta' }, menu.id)[:data]

      result = service.get_all_data(menu.id)
      expect(result[:status]).to eq(:ok)
      expect(result[:data]).to contain_exactly(menu_listing1, menu_listing2)
    end

    it 'returns an empty array when no menu listings exist' do
      result = service.get_all_data(menu.id)

      expect(result[:status]).to eq(:ok)
      expect(result[:data]).to eq([])
    end
  end

  describe '#create' do
    it 'creates a menu listing when valid params are provided' do
      params = { menu_item_name: 'Pizza', price: 12.99, description: 'Delicious cheese pizza' }

      result = service.create(params, menu.id)

      expect(result[:status]).to eq(:created)
      expect(result[:data]).to be_persisted
      expect(result[:data].menu_item.name).to eq('Pizza')
    end

    it 'returns error if menu_item_name is blank' do
      params = { menu_item_name: '', price: 10.0, description: 'Test' }

      result = service.create(params, menu.id)

      expect(result[:status]).to eq(:unprocessable_entity)
      expect(result[:errors]).to include('Name cannot be blank')
    end
  end

  describe '#update' do
    it 'updates a menu listing successfully' do
      params = { menu_item_name: 'Sushi', price: 15.50, description: 'Fresh salmon sushi' }

      result = service.update(menu_listing, params)

      expect(result[:status]).to eq(:ok)
      expect(menu_listing.reload.menu_item.name).to eq('Sushi')
      expect(menu_listing.price).to eq(15.50)
      expect(menu_listing.description).to eq('Fresh salmon sushi')
    end

    it 'returns error when menu_item_name is blank' do
      params = { menu_item_name: '', price: 15.50, description: 'Fresh salmon sushi' }

      result = service.update(menu_listing, params)

      expect(result[:status]).to eq(:unprocessable_entity)
      expect(result[:errors]).to include('Name cannot be blank')
    end
  end

  describe '#destroy' do
    it 'removes a menu listing' do
      result = service.destroy(menu_listing)

      expect(result[:status]).to eq(:no_content)
      expect(result[:message]).to eq('Menu item removed from the menu successfully')
      expect(MenuListing.exists?(menu_listing.id)).to be_falsey
    end
  end

  describe '#find' do
    it 'returns a menu listing when found' do
      result = service.find(menu_listing.id)

      expect(result).to eq(menu_listing)
    end

    it 'returns nil when menu listing is not found' do
      result = service.find(-1)

      expect(result).to be_nil
    end
  end
end

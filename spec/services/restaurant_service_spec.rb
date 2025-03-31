require 'rails_helper'

RSpec.describe RestaurantService do
  subject(:service) { described_class.new }

  describe '#get_all_data' do
    it 'retorna todos os restaurantes ordenados por ID' do
      restaurant1 = create(:restaurant, id: 1, name: 'Bistro Gourmet')
      restaurant2 = create(:restaurant, id: 2, name: 'Pizzaria Napoli')

      result = service.get_all_data

      expect(result[:status]).to eq(:ok)
      expect(result[:data]).to match_array([restaurant1, restaurant2])
      expect(result[:errors]).to be_nil
    end

    it 'retorna uma lista vazia se não houver restaurantes' do
      result = service.get_all_data

      expect(result[:status]).to eq(:ok)
      expect(result[:data]).to be_empty
      expect(result[:errors]).to be_nil
    end
  end

  describe '#create' do
    context 'quando os dados são válidos' do
      it 'cria um restaurante' do
        result = service.create(name: 'Novo Restaurante')

        expect(result[:status]).to eq(:created)
        expect(result[:data]).to be_persisted
        expect(result[:data].name).to eq('Novo Restaurante')
        expect(result[:errors]).to be_nil
      end
    end

    context 'quando os dados são inválidos' do
      it 'retorna erro ao tentar criar um restaurante sem nome' do
        result = service.create(name: '')

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:data]).to be_nil
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#update' do
    let!(:restaurant) { create(:restaurant, name: 'Antigo Nome') }

    context 'quando os dados são válidos' do
      it 'atualiza o restaurante' do
        result = service.update(restaurant, name: 'Novo Nome')

        expect(result[:status]).to eq(:ok)
        expect(result[:data].name).to eq('Novo Nome')
        expect(result[:errors]).to be_nil
      end
    end

    context 'quando os dados são inválidos' do
      it 'retorna erro ao tentar atualizar com nome vazio' do
        result = service.update(restaurant, name: '')

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:data]).to be_nil
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe '#destroy' do
    let!(:restaurant) { create(:restaurant) }

    it 'remove o restaurante' do
      expect { service.destroy(restaurant) }.to change(Restaurant, :count).by(-1)

      result = service.destroy(restaurant)

      expect(result[:status]).to eq(:no_content)
      expect(result[:message]).to eq('Restaurant deleted successfully')
    end
  end

  describe '#find' do
    let!(:restaurant) { create(:restaurant) }

    it 'retorna um restaurante existente' do
      result = service.find(restaurant.id)

      expect(result).to eq(restaurant)
    end

    it 'retorna nil se o restaurante não existir' do
      result = service.find(-1)

      expect(result).to be_nil
    end
  end
end

require 'rails_helper'

RSpec.describe UseCases::ImportJsonData, type: :service do
  let(:valid_json) do
    {
      "restaurants" => [
        {
          "name" => "Test Restaurant",
          "menus" => [
            {
              "name" => "Lunch Menu",
              "menu_items" => [
                { "name" => "Burger", "price" => 9.99, "description" => "Delicious beef burger" }
              ]
            }
          ]
        }
      ]
    }.to_json
  end

  let(:invalid_json) { "{" } # JSON malformado

  let(:file) { double('file', read: valid_json, original_filename: 'test.json') }
  let(:invalid_file) { double('file', read: invalid_json, original_filename: 'invalid.json') }
  let(:empty_file) { double('file', read: '', original_filename: 'empty.json') }

  describe '#execute' do
    context 'when no file is provided' do
      it 'returns a failure status' do
        result = described_class.new(nil).execute
        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to eq("No file provided")
      end
    end

    context 'when file is empty' do
      it 'returns a failure status' do
        result = described_class.new(empty_file).execute
        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to include("Fatal error")
      end
    end

    context 'when file contains invalid JSON' do
      it 'returns a failure status' do
        result = described_class.new(invalid_file).execute
        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to include("Fatal error")
      end
    end

    context 'when file contains valid JSON' do
      it 'imports restaurants, menus, and items successfully' do
        expect { described_class.new(file).execute }.to change { Restaurant.count }.by(1)
          .and change { Menu.count }.by(1)
          .and change { MenuItem.count }.by(1)
      end
    end

    context 'when there are validation errors' do
      before do
        allow_any_instance_of(Restaurant).to receive(:save).and_return(false)
        allow_any_instance_of(Restaurant).to receive_message_chain(:errors, :full_messages).and_return(['Name can\'t be blank'])
      end

      it 'records the failure in the results' do
        result = described_class.new(file).execute
        expect(result[:status]).to eq(:ok)
        expect(result[:results][:failed]).not_to be_empty
        expect(result[:results][:failed].first[:reason]).to eq("Failed to save restaurant: Name can't be blank")
      end
    end

    context 'when an unexpected error occurs' do
      before do
        allow(Oj).to receive(:load).and_raise(StandardError.new("Unexpected error"))
      end

      it 'returns a failure status with error message' do
        result = described_class.new(file).execute
        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to include("Fatal error: Unexpected error")
      end
    end
  end
end

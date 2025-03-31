require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:restaurant) { create(:restaurant) }

  it { should belong_to(:restaurant) }
  it { should have_many(:menu_listings) }
  it { should have_many(:menu_items).through(:menu_listings) }
  it { should validate_presence_of(:name) }
end

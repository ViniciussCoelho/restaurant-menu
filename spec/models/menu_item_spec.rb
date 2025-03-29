require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it { should have_many(:menu_listings) }
  it { should have_many(:menus).through(:menu_listings) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end

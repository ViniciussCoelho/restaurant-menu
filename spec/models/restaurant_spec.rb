require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { should have_many(:menus) }
  it { should validate_presence_of(:name) }
end

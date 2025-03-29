require 'rails_helper'

RSpec.describe MenuListing, type: :model do
  it { should belong_to(:menu) }
  it { should belong_to(:menu_item) }
end

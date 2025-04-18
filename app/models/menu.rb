class Menu < ApplicationRecord
  has_many :menu_listings, dependent: :destroy
  has_many :menu_items, through: :menu_listings
  belongs_to :restaurant

  validates :name, presence: true
end

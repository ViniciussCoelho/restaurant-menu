class MenuItem < ApplicationRecord
  has_many :menu_listings
  has_many :menus, through: :menu_listings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

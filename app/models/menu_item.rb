class MenuItem < ApplicationRecord
  has_many :menu_listings, dependent: :restrict_with_error
  has_many :menus, through: :menu_listings

  before_destroy :ensure_no_menu_listings

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def ensure_no_menu_listings
    errors.add(:base, 'Cannot delete menu item with active listings') if menu_listings.exists?
  end
end

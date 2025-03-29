class RemoveDescriptionAndPriceFromMenuItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :menu_items, :description
    remove_column :menu_items, :price
  end
end

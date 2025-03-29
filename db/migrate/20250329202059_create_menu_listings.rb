class CreateMenuListings < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_listings do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :menu_item, null: false, foreign_key: true
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end

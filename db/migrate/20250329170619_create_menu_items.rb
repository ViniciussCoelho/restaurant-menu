class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.belongs_to :menu, null: false, foreign_key: true
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end

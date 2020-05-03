class CreateMenuFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :menus_foods do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.timestamps
    end
  end
end

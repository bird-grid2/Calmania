class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu, null: false
      t.string :foods, array: true, null: false
      t.integer :masses, array: true, null: false
      t.integer :total_protain
      t.integer :total_fat
      t.integer :total_carbohydrate
      t.timestamps
    end
  end
end

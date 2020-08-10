class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu, null: false
      t.integer :foods, array: true, null: false
      t.integer :masses, array: true, null: false
      t.decimal :total_protain, precision: 5, scale: 1
      t.decimal :total_fat, precision: 5, scale: 1
      t.decimal :total_carbohydrate, precision: 5, scale: 1
      t.timestamps
    end
  end
end

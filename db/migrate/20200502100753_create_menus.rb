class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu, null: false
      t.integer :name, null: false
      t.integer :mass, null: false
      t.string :foods, array: true, null: false
      t.string :masses, array: true, null: false
      t.decimal :total_protain, precision: 5, scale: 1
      t.decimal :total_fat, precision: 5, scale: 1
      t.decimal :total_carbohydrate, precision: 5, scale: 1
      t.timestamps
    end
  end
end

class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu,     null: false
      t.decimal :mass,    null: false, precision: 4, scale: 1
      t.integer :total_protain
      t.integer :total_fat
      t.integer :total_carbohydrate
      t.timestamps
    end
  end
end

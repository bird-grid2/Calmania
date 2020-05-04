class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu,     null: false
      t.decimal :mass,    null: false, precision: 4, scale: 1
      t.timestamps
    end
  end
end

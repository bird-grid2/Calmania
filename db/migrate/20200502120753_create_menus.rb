class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu,     null: false
      t.double :mass,     null: false
      t.references :food, null: false, foreign_key: true 
      t.timestamps
    end
  end
end

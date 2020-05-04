class CreateMenuFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_foods do |t|
      t.references :menu,  foreign_key: true
      t.references :food,  foreign_key: true
      t.timestamps
    end
  end
end

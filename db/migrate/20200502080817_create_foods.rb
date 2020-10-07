class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :material,           null: false, index: true
      t.decimal :protain_rate,      null: false, precision: 6, scale: 5
      t.decimal :fat_rate,          null: false, precision: 6, scale: 5
      t.decimal :carbohydrate_rate, null: false, precision: 6, scale: 5
      t.timestamps
    end
  end
end

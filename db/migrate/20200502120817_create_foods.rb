class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :food,              null: false
      t.double :protain_rate,      null: false
      t.double :fat_rate,          null: false
      t.double :carbohydrate_rate, null: false
      t.timestamps
    end
  end
end

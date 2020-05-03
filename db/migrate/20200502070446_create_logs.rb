class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.date :created_at,           null: false, index: true
      t.string :name,               null: false
      t.integer :total_protain
      t.integer :total_fat
      t.integer :total_carbohydrate
      t.references :menu,           null: false, foreign_key: true
      t.timestamps
    end
  end
end

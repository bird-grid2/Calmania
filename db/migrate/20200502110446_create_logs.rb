class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.date :date,        null: false, index: true
      t.decimal :weight,    precision: 4, scale: 1
      t.decimal :bfp,       precision: 3, scale: 1
      t.decimal :total_cal, precision: 5, scale: 1
      t.text :description, index: true
      t.string :menu_numbers,  array: true
      t.references :user, foreign_key: true, on_delete: :cascade
      t.timestamps
    end 
  end
end

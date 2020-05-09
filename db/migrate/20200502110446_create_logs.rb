class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.date :created_at,           null: false, index: true
      t.string :log_name,           null: false
      t.decimal :weight,            precision: 4, scale: 1
      t.integer :total_protain
      t.integer :total_fat
      t.integer :total_carbohydrate
      t.references :user,     foreign_key: true
      t.references :management,     foreign_key: true
      t.references :menu,           foreign_key: true
      t.timestamps
    end
  end
end

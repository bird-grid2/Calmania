class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.date :created_at,       null: false, index: true
      t.decimal :weight,        precision: 4, scale: 1
      t.decimal :bfp,           precision: 4, scale: 3
      t.integer :total_cal
      t.text :description,      index: true         
      t.references :user,       foreign_key: true
      t.references :management, foreign_key: true
      t.references :menu,       foreign_key: true
      t.timestamps
    end
  end
end

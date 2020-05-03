class CreateManegements < ActiveRecord::Migration[5.2]
  def change
    create_table :manegements do |t|
      t.date :create_at,              null:false
      t.decimal :body_mass_index,     precision: 3, scale: 1
      t.decimal :body_fat_parcentage, precision: 4, scale: 3
      t.references :user,             null: false, foreign_key: true
      t.references :log,              null: false, foreign_key: true
      t.timestamps
    end
  end
end

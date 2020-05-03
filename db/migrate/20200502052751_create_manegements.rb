class CreateManegements < ActiveRecord::Migration[5.2]
  def change
    create_table :manegements do |t|
      t.date :create_at,            null:false
      t.dobule :body_mass_index
      t.double :body_fat_parcentage
      t.references :user,           null: false, foreign_key: true
      t.references :log,            null: false, foreign_key: true
      t.timestamps
    end
  end
end

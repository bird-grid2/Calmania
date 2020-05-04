class CreateManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :managements do |t|
      t.date :create_at,              null:false
      t.decimal :body_mass_index,     precision: 3, scale: 1
      t.decimal :body_fat_parcentage, precision: 4, scale: 3
      t.references :user,             foreign_key: true
    end
  end
end

class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.string :line_id, unique: true
      t.references :user
      t.timestamps
    end
  end
end

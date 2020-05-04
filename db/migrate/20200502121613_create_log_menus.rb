class CreateLogMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :log_menus do |t|
      t.references :log,  null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.timestamps
    end
  end
end

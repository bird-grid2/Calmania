class AddIndexMenusMaterial < ActiveRecord::Migration[5.2]
  def change
    add_index :menus, :material
  end
end

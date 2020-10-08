class AddIndexFoodsElement < ActiveRecord::Migration[5.2]
  def change
    add_index :foods, :element
  end
end

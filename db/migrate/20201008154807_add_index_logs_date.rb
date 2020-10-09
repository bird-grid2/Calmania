class AddIndexLogsDate < ActiveRecord::Migration[5.2]
  def change
    add_index :logs, [ :date, :description]
  end
end

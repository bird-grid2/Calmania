class CreateClockWorkEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_work_events do |t|
      t.references :period
      t.time :send_time
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

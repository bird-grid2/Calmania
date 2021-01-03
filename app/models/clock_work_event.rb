class ClockWorkEvent < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  def self.sendtime
      order(:send_time).pluck(:send_time, :period_id, :user_id)
  end

  def frequency
    # user's information send 1minute
    120
  end
end

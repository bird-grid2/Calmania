class ClockWorkEvent < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  def sendtime
    i = 0
    target = ClockWorkEvent.order(:send_time).pluck(:send_time, :period_id)
    times = 0

    target.each do |time|
      times = [ time[i][0].strftime("%H:%M"), time[i][1].to_i]
      times
      i += 1
    end
  end

  def frequency
    # user's information send 1minute
    120
  end
end

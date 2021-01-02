class ClockWorkEvent < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  def sendtime
    i = 0
    target = ClockWorkEvent.order(:send_time).pluck(:id, :send_time)
    times = []
    time_ids = []

    target.each do |time|
      times << time[i][1].strftime("%H:%M")
      time_ids << time[i][0].to_i
      i += 1
    end
    return time_ids, times
  end
  
  def period_frequency
    j = 0
    target = ClockWorkEvent.pluck(:id, :period_id)
    periods = []
    period_ids = []

    target.each do |period|
      periods << time[j][1].to_i
      period_ids << time[j][0].to_i
      j += 1
    end
    return period_ids, periods
  end

  def frequency
    # user's information send 1minute
    120
  end
end

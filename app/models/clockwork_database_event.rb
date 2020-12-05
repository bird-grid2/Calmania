class ClockworkDatabaseEvent < ApplicationRecord
  def if?(time)
    time.day == day && time.month == month
  end

  def period
    User.select('period_id')
  end

  def send_time
    User.select('send_time')
  end  
end

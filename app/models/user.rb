class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :logs, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  validates :nickname, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, numericality: { allow_nil: true }

  def sendtime
    i = 0
    target = User.order(:send_time).pluck(:id, :send_time)
    times = []
    time_ids = []

    target.each do |time|
      times << time[i][1].strftime("%H:%M")
      time_ids << time[i][0].to_i
      i += 1
    end
    return time_ids, times
  end
  
  def period
    j = 0
    target = User.pluck(:id, :period_id)
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

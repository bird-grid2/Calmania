class ClockWorkEvent < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  def frequency
    # user's information send 1week
    604_800
  end
end

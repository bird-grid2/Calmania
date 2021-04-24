class Log < ApplicationRecord

  belongs_to :user
  has_many :menus

  validates :date, :user_id, presence: true
  validates :weight, :bfp, :total_cal, numericality: { allow_nil: true }

  def self.search(search)
    return Log.all unless search
    Log.where("description LIKE(?)", "%#{search}%")
  end

  def self.dsearch(dsearch)
    return Log.all if dsearch == ''
    Log.where(date: dsearch.to_date)
  end

  def frequency
    user.send(user.period_id.pluralize)
  end

end

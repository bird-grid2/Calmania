class Log < ApplicationRecord

  belongs_to :user
  has_many :menus

  validates :date, :user_id, presence: true
  validates :weight, :bfp, :total_cal, numericality: { allow_nil: true }

  def self.search(search)
    return Log.all unless search
    Log.where('date description LIKE ?', "%#{search}%")
  end

end

class Log < ApplicationRecord

  belongs_to :user
  has_many :menus

  validates :weight, :bfp, :total_cal, numericality: { allow_nil: true }

  def self.search(search)
    return Log.all unless search
    Log.where('date LIKE ?', "%#{search}%")
  end

end

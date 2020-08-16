class Log < ApplicationRecord

  belongs_to :user
  has_many :menus

  def self.search(search)
    return Log.all unless search
    Log.where('date LIKE ?', "%#{search}%")
  end

end

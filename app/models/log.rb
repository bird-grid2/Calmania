class Log < ApplicationRecord

  belongs_to :user
  belongs_to :management
  has_many :log_menus
  has_many :menus, thorough: :log_menus

end

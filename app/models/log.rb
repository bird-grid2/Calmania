class Log < ApplicationRecord

  belongs_to :management
  has_many :logs_menus
  has_many :menus, thorough: :logs_menus

end

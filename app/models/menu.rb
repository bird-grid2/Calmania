class Menu < ApplicationRecord

  has_many :log_menus
  has_many :logs, through: :log_menus
  has_many :menu_foods
  has_many :foods, through: :menu_foods

end

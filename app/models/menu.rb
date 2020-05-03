class Menu < ApplicationRecord

  has_many :logs_menus
  has_many :logs, through: :logs_menus
  has_many :menus_foods
  has_many :foods, through: :menus_foods

end

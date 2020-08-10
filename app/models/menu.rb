class Menu < ApplicationRecord

  has_many :log_menus
  has_many :logs, through: :log_menu
  has_many :foods

end

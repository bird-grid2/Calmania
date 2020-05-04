class Food < ApplicationRecord

  has_many :menu_foods
  has_many :menus, through: :menu_foods

end

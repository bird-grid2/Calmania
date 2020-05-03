class Food < ApplicationRecord

  has_many :menus_foods
  has_many :menus, through: :menus_foods

end

class Menu < ApplicationRecord

  has_many :log_menus
  has_many :logs, through: :log_menu
  has_many :foods

  def self.search(search)
    return Menu.all unless search
    Menu.where('menu LIKE ?', "%#{search}%")
  end

end

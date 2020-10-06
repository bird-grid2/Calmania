class Menu < ApplicationRecord

  belongs_to :log, optional: true
  has_many :foods


  def self.search(search)
    return Menu.all unless search
    Menu.where('menu LIKE ?', "%#{search}%")
  end

end

class Menu < ApplicationRecord

  belongs_to :log, optional: true
  has_many :foods

  validates :masses, numericality: true

  def self.search(search)
    return Menu.all unless search
    Menu.where('menu LIKE ?', "%#{search}%")
  end

end

class Menu < ApplicationRecord

  belongs_to :log, optional: true
  has_many :foods

  validates :material, :names, :masses, presence: true

  def self.search(search)
    return Menu.all unless search
    Menu.where('material LIKE ?', "%#{search}%")
  end

end

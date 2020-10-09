class Food < ApplicationRecord
  belongs_to :menu, optional: true
  validates :element, :protain_rate, :fat_rate, :carbohydrate_rate, presence: true
end

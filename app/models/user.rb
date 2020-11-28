class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :logs, dependent: :destroy
  has_one :followers, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :period, optional: true

  validates :nickname, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, numericality: { allow_nil: true }

  def if?(time)
    time.day == day && time.month == month
  end
  
end

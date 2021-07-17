class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :logs, dependent: :destroy
  has_one :clock_work_event, dependent: :destroy
  accepts_nested_attributes_for :clock_work_event, allow_destroy: true

  validates :nickname, :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, numericality: { allow_nil: true }
end

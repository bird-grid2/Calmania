class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_jti
  include UserRepository

  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :logs, dependent: :destroy
  has_one :clock_work_event, dependent: :destroy
  accepts_nested_attributes_for :clock_work_event, allow_destroy: true

  validates :nickname, :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, numericality: { allow_nil: true }

  private

  def jwt_subject
    id
  end

  def set_jti
    self.jti = SecureRandom.uuid # または別の一意な値を生成
  end
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email
  has_many :logs, dependent: :destroy
  has_one :clock_work_event, dependent: :destroy
end

require 'rails_helper'

Rspec.describe Food, type: :model do

  def valid(val)
    val.valid?
    expect(val.errors).to include 'を入力してください'
  end

  context 'validation' do
    it '各項目が空なら登録できない' do
      foods = build(:food, food: nil)
      valid(foods)
      foods = build(:food, protain_rate: nil)
      valid(foods)
      foods = build(:food, fat_rate: nil)
      valid(foods)
      foods = build(:food, carbohydrate_rate: nil)
      valid(foods)
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

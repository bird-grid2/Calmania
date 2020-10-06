require 'rails_helper'

Rspec.describe Food, type: :model do
  context 'validation' do
    it 'food名が空なら登録できない' do
      foods = build(:food, food: nil)
      valid(foods)
    end
    it 'protain_rateが空なら登録できない' do
      foods = build(:food, protain_rate: nil)
      valid(foods)
    end
    it 'fat_rateが空なら登録できない' do
      foods = build(:food, fat_rate: nil)
      valid(foods)
    end
    it 'carbohydrate_rateが空なら登録できない' do
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

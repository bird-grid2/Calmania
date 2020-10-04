require 'rails_helper'

describe Food do
  context 'validation' do
    it 'food名が空なら登録できない' do
      foods = build(:food, food: nil)
      valid(foods, :food)
    end
    it 'protain_rateが空なら登録できない' do
      foods = build(:food, protain_rate: nil)
      valid(foods, :protain_rate)
    end
    it 'fat_rateが空なら登録できない' do
      foods = build(:food, fat_rate: nil)
      valid(foods, :fat_rate)
    end
    it 'carbohydrate_rateが空なら登録できない' do
      foods = build(:food, carbohydrate_rate: nil)
      valid(foods, :carbohydrate_rate)
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

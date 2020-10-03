require 'rails-helper'

describe Food do  
  context 'validation' do
    it 'food名が空なら登録できない' do 
      foods = build(:food, food: nil)
      foods.valid?
      expect(foods.errors[:food]).to include("can't be blank")
    end
    it 'protain_rateが空なら登録できない' do
      foods = build(:food, protain_rate: nil)
      expect(foods.errors[:protain_rate]).to include("can't be blank")
    end
    it 'fat_rateが空なら登録できない' do 
      foods = build(:food, fat_rate: nil)
      foods.valid?
      expect(foods.errors[:fat_rate]).to include("can't be blank")
    end
    it 'carbohydrate_rateが空なら登録できない' do 
      foods = build(:food, carbohydrate_rate: nil)
      foods.valid?
      expect(foods.errors[:carbohydrate_rate]).to include("can't be blank")
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end
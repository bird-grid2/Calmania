require 'rails_helper'

RSpec.describe Food, type: :model do
  context 'validation' do
    it '各項目が空なら登録できない' do
      foods = build(:food, name: nil)
      foods.valid?
      expect(foods.errors[:name]).to include "を入力してください"
      foods = build(:food, protain_rate: nil)
      foods.valid?
      expect(foods.errors[:protain_rate]).to include "を入力してください"
      foods = build(:food, fat_rate: nil)
      foods.valid?
      expect(foods.errors[:fat_rate]).to include "を入力してください"
      foods = build(:food, carbohydrate_rate: nil)
      foods.valid?
      expect(foods.errors[:carbohydrate_rate]).to include "を入力してください"
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

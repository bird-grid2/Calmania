require 'rails_helper'

Rspec.describe Food, type: :model do
  context 'validation' do
    it '各項目が空なら登録できない' do
      test = ['food: nil', 'protain_rate: nil', 'fat_rate: nil', 'carbohydrate_rete: nil']
      test.each do |i|
        foods = build(:food, i)
        foods.valid?
        expect(foods.errors).to include 'を入力してください'
      end
    end
  end
  
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

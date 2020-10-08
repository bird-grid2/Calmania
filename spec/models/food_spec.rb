require 'rails_helper'

RSpec.describe Food, type: :model do
  context 'validation' do
    it '各項目が空なら登録できない' do
      foods = build(:food, material: nil)
      foods.valid?
      expect(foods.errors[:material]).to include("を入力してください")
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

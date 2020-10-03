require 'rails-helper'

describe Food do
  context 'validation' do
    describe '#create' do
      it 'food名が空なら登録できない' do 
        foods = Food.new(food: nil, protain_rate: '0.12345', fat_rate: '0.67890', carbohydrate_rate: '0.12345')
        foods.valid?
        expect(foods.errors[:food]).to incluude("can't be blank")
      end
      it 'protain_rateが空なら登録できない' do
        foods = Food.new(food: 'サンプルA', protain_rate: nil, fat_rate: '0.67890', carbohydrate_rate: '0.12345')
        foods.valid?
        expect(foods.errors[:protain_rate]).to incluude("can't be blank")
      end
    end
  end
end
require 'rails-helper'

describe Food do  
  describe '#create' do
    context 'validation' do
      it 'food名が空なら登録できない' do 
        foods = Food.new(food: nil, protain_rate: '0.12345', fat_rate: '0.67890', carbohydrate_rate: '0.12345')
        foods.valid?
        expect(foods.errors[:food]).to include("can't be blank")
      end
      it 'protain_rateが空なら登録できない' do
        foods = Food.new(food: 'サンプルA', protain_rate: nil, fat_rate: '0.67890', carbohydrate_rate: '0.12345')
        foods.valid?
        expect(foods.errors[:protain_rate]).to include("can't be blank")
      end
      it 'fat_rateが空なら登録できない' do 
        foods = Food.new(food: 'サンプルA', protain_rate: '0.12345', fat_rate: nil, carbohydrate_rate: '0.12345')
        foods.valid?
        expect(foods.errors[:fat_rate]).to include("can't be blank")
      end
      it 'carbohydrate_rateが空なら登録できない' do 
        foods = Food.new(food: 'サンプルA', protain_rate: '0.12345', fat_rate: '0.67890', carbohydrate_rate: nil)
        foods.valid?
        expect(foods.errors[:carbohydrate_rate]).to include("can't be blank")
      end
    end
    context 'submit' do
      it '全てが入力されていると、登録できる' do
          
    end
    end
  end
end
require 'rails_helper'

describe Log do
  context 'validation' do
    it '日付が空なら登録できない' do
      logs = build(:log, date: nil)
      logs.valid?
      expect(logs.errors[:date]).to include("can't be blank")
    end
    it 'weightが数字以外は登録できない' do
      logs = build(:log, weight: 'あ')
      expect(logs.errors[:weight]).to include("can't be blank")
    end
    it 'fat_rateが空なら登録できない' do
      logs = build(:log, fat_rate: nil)
      logs.valid?
      expect(logs.errors[:fat_rate]).to include("can't be blank")
    end
    it 'carbohydrate_rateが空なら登録できない' do
      logs = build(:log, carbohydrate_rate: nil)
      logs.valid?
      expect(logs.errors[:carbohydrate_rate]).to include("can't be blank")
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

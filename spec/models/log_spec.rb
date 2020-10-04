require 'rails_helper'

describe Log do
  context 'validation' do
    it '日付が空なら登録できない' do
      logs = build(:log, date: nil)
      logs.valid?
      expect(logs.errors[:date]).to include("を入力してください")
    end
    it 'weightは全角文字で登録できない' do
      logs = build(:log, weight: 'あ')
      expect(logs.errors[:weight]).to include("は数値で入力してください")
    end
    it 'weightは半角文字で登録できない' do
      logs = build(:log, weight: 'ｱ')
      expect(logs.errors[:weight]).to include("は数値で入力してください")
    end
    it 'weightは半角英字で登録できない' do
      logs = build(:log, weight: 'a')
      expect(logs.errors[:weight]).to include("は数値で入力してください")
    end
    it 'bfpは全角文字で登録できない' do
      logs = build(:log, bfp: 'あ')
      expect(logs.errors[:bfp]).to include("は数値で入力してください")
    end
    it 'bfpは半角文字で登録できない' do
      logs = build(:log, bfp: 'ｱ')
      expect(logs.errors[:bfp]).to include("は数値で入力してください")
    end
    it 'bfpは半角英字で登録できない' do
      logs = build(:log, bfp: 'a')
      expect(logs.errors[:bfp]).to include("は数値で入力してください")
    end
    it 'total_calは全角文字で登録できない' do
      logs = build(:log, total_cal: 'あ')
      expect(logs.errors[:total_cal]).to include("は数値で入力してください")
    end
    it 'total_calは半角文字で登録できない' do
      logs = build(:log, total_cal: 'ｱ')
      expect(logs.errors[:total_cal]).to include("は数値で入力してください")
    end
    it 'total_calは半角英字で登録できない' do
      logs = build(:log, total_cal: 'a')
      expect(logs.errors[:total_cal]).to include("は数値で入力してください")
    end
    it 'user_idは空なら登録できない' do
      logs = build(:log, user_id: nil)
      expect(logs.errors[:user_id]).to include("を入力してください")
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      logs = build(:log)
      expect(logs).to be_valid
    end
    it 'weightが空でも登録できる' do
      logs = build(:log, weight: nil)
      expect(logs).to be_valid
    end
    it 'bfpが空でも登録できる' do
      logs = build(:log, bfp: nil)
      expect(logs).to be_valid
    end
    it 'total_calが空でも登録できる' do
      logs = build(:log, total_cal: nil)
      expect(logs).to be_valid
    end
    it 'descriptionが空でも登録できる' do
      logs = build(:log, description: nil)
      expect(logs).to be_valid
    end
    it 'menu_numbersが空でも登録できる' do
      logs = build(:log, menu_numbers: nil)
      expect(logs).to be_valid
    end
  end
end

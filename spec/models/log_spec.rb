require 'rails_helper'

describe Log do
  context 'validation' do
    target = %w[あ ｱ a １]
    it '日付が空なら登録できない' do
      logs = build(:log, date: nil)
      valid(logs)
    end
    it 'weightは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        logs = build(:log, weight: i)
        number(logs)
      end
    end
    it 'bfpは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        logs = build(:log, bfp: i)
        number(logs)
      end
    end
    it 'total_calは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        logs = build(:log, total_cal: i)
        number(logs)
      end
    end
    it 'user_idは空なら登録できない' do
      logs = build(:log, user_id: nil)
      valid(logs)
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      logs = build(:log)
      expect(logs).to be_valid
    end
    it 'weight,bfpが空でも登録できる' do
      logs = build(:log, weight: nil)
      expect(logs).to be_valid
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

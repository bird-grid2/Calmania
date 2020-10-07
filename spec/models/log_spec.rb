require 'rails_helper'

RSpec.describe Log, type: :model do
  context 'validation' do
    it '日付とuser_idが空なら登録できない' do
        logs = build(:log, date: nil)
        logs.valid?
        expect(logs.errors).to include 'を入力してください'
        logs = build(:log, user_id: nil)
        logs.valid?
        expect(logs.errors).to include 'を入力してください'
    end

    it 'weightとbfpとtotal_calは全角・半角文字と英文字で登録できない' do
      target = %w[あ ｱ a １]
      target.each do |i|
        logs = build(:log, weight: i)
        logs.valid?
        expect(logs.errors[:weight]).to include 'は数値で入力してください'
        logs = build(:log, bfp: i)
        logs.valid?
        expect(logs.errors[:bfp]).to include 'は数値で入力してください'
        logs = build(:log, total_cal: i)
        logs.valid?
        expect(logs.errors[:total_cal]).to include 'は数値で入力してください'
      end
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      logs = build(:log)
      expect(logs).to be_valid
    end
    
    it '１項目が空でも登録できる' do
      logs = build(:log, weight: nil)
      expect(logs).to be_valid
      logs = build(:log, bfp: nil)
      expect(logs).to be_valid
      logs = build(:log, total_cal: nil)
      expect(logs).to be_valid
      logs = build(:log, description: nil)
      expect(logs).to be_valid
      logs = build(:log, menu_numbers: nil)
      expect(logs).to be_valid
    end
  end
end

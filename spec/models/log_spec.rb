require 'rails_helper'

Rspec.describe Log, type: :model do

  def valid(val)
    val.valid?
    expect(val.errors).to include 'を入力してください'
  end

  def number(num)
    num.valid?
    expect(num.errors).to include 'は数値で入力してください'
  end

  context 'validation' do
    target = %w[あ ｱ a １]

    it '日付とuser_idが空なら登録できない' do
      logs = build(:log, date: nil)
      valid(logs)
      logs = build(:log, user_id: nil)
      valid(logs)
    end

    it 'weightとbfpとtotal_calは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        logs = build(:log, weight: i)
        number(logs)
        logs = build(:log, bfp: i)
        number(logs)
        logs = build(:log, total_cal: i)
        number(logs)
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

require 'rails_helper'

describe User do

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
    it { 'nicknameが空なら登録できない' users = build(:user, nickname: nil) valid(users) }
    it { 'emailが空なら登録できない' users = build(:user, email: nil) valid(users) }
    it { 'encrypted_passwordが空なら登録できない' users = build(:user, encrypted_password: nil) valid(users) }
    it 'heightは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        users = build(:user, height: i)
        number(users)
      end
    end
    it 'ideal_protain_rate, ideal_fat_rateは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        users = build(:user, ideal_protain_rate: i)
        number(users)
        users = build(:user, ideal_fat_rate: i)
        number(users)
      end
    end
    it 'ideal_carbohydrate_rate, target_calは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        users = build(:user, ideal_carbohydrate_rate: i)
        number(users)

        users = build(:user, target_cal: i)
        number(users)
      end
    end
  end
  context 'submit' do
    item = %w['height: nil' 'ideal_protain_rate: nil' 'ideal_fat_rate: nil' 'ideal_carbohydrate_rate: nil' 'total_cal: nil']
    it '全てが入力されていると、登録できる' do
      users = build(:user)
      expect(users).to be_valid
    end
    it '任意の項目が空でも登録できる' do
      item.each do |i|
        users = build(:user, i)
        expect(users).to be_valid
      end
    end
  end
end

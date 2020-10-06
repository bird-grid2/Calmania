require 'rails_helper'

Rspec.describe User, type: :model do
  context 'validation' do
    it 'user名、email、encrypted_passwordが空なら登録できない' do 
      test = %w['nickname: nil' 'email: nil' 'encrypted_password: nil']
      
      test.each do |i|
        users = build(:user, i)
        users.valid?
        expect(users.errors).to include 'を入力してください'
      end
    end

    it '全角・半角文字と英文字で登録できない' do
      target = %w[あ ｱ a １]
      target.each do |i|
        users = build(:user, height: i)
        users.valid?
        expect(users.errors[:height]).to include 'は数値で入力してください'
        users = build(:user, ideal_protain_rate: i)
        users.valid?
        expect(users.errors[:ideal_protain_rate]).to include 'は数値で入力してください'
        users = build(:user, ideal_fat_rate: i)
        users.valid?
        expect(users.errors).to include 'は数値で入力してください'
        users = build(:user, ideal_carbohydrate_rate: i)
        users.valid?
        expect(users.errors[:ideal_carbohydrate_rate]).to include 'は数値で入力してください'
        users = build(:user, target_cal: i)
        users.valid?
        expect(users.errors[:total_cal]).to include 'は数値で入力してください'
      end
    end
  end

  context 'submit' do
    it '全てが入力されていると、登録できる' do
      users = build(:user)
      expect(users).to be_valid
    end
    
    it '任意の項目が空でも登録できる' do
      item = %w['height: nil' 'ideal_protain_rate: nil' 'ideal_fat_rate: nil' 'ideal_carbohydrate_rate: nil' 'total_cal: nil']
      item.each do |i|
        users = build(:user, i)
        expect(users).to be_valid
      end
    end
  end
end

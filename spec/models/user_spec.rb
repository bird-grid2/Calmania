require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validation' do
    it 'user名、email、encrypted_passwordが空なら登録できない' do
      users = build(:user, nickname: nil)
      users.valid?
      expect(users.errors[:nickname]).to include('を入力してください')
      users = build(:user, email: nil)
      users.valid?
      expect(users.errors[:email]).to include('を入力してください')
      users = build(:user, password: nil)
      users.valid?
      expect(users.errors[:password]).to include('を入力してください')
    end
    it '全角・半角文字と英文字で登録できない' do
      target = %w[あ ｱ a １]
      users = build(:user)
      target.each do |i|
        users[:height] = i
        users.valid?
        expect(users.errors[:height]).to include 'は数値で入力してください'
        users[:ideal_protain_rate] = i
        users.valid?
        expect(users.errors[:ideal_protain_rate]).to include 'は数値で入力してください'
        users[:ideal_fat_rate] = i
        users.valid?
        expect(users.errors[:ideal_fat_rate]).to include 'は数値で入力してください'
        users[:ideal_carbohydrate_rate] = i
        users.valid?
        expect(users.errors[:ideal_carbohydrate_rate]).to include 'は数値で入力してください'
        users[:target_cal] = i
        users.valid?
        expect(users.errors[:target_cal]).to include 'は数値で入力してください'
      end
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      users = build(:user)
      expect(users).to be_valid
    end
    it '任意の項目が空でも登録できる' do
      item = [:height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal]
      users = build(:user)
      item.each do |i|
        users[i] = nil
        expect(users).to be_valid
      end
    end
  end
end

require "rails_helper"
RSpec.describe User, type: :model do
  context "validation" do
    it "user名、email、encrypted_passwordが空なら登録できない" do
      target = [:nickname, :email, :encrypted_password]
      target.each do |user|
        users = build(:user)
        users[user] = nil
        users.valid?
        expect(users.errors[user]).to include("を入力してください")
      end
    end
    it "全角・半角文字と英文字で登録できない" do
      target = [:height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal]
      font = %w[あ ｱ a １]
      target.each do |user|
        font.each do |i|
          users = build(:user)
          users[user] = i
          users.valid?
          expect(users.errors[user]).to include("は数値で入力してください")
        end
      end
    end
  end
  context "submit" do
    it "全てが入力されていると、登録できる" do
      users = build(:user)
      expect(users).to be_valid
    end
    it "任意の項目が空でも登録できる" do
      item = [:height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal]
      users = build(:user)
      item.each do |i|
        users[i] = nil
        expect(users).to be_valid
      end
    end
  end
end

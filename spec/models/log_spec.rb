require "rails_helper"
RSpec.describe Log, type: :model do
  context "validation" do
    it "日付とuser_idが空なら登録できない" do
      target = [:date, :user_id]
      target.each do |log|
        logs = build(:log)
        logs[log] = nil
        logs.valid?
        expect(logs.errors[log]).to include("を入力してください")
      end
    end
    it "weightとbfpとtotal_calは全角・半角文字と英文字で登録できない" do
      number = %w[あ ｱ a １]
      target = [:weight, :bfp, :total_cal]
      target.each do |log|
        number.each do |i|
          logs = build(:log)
          logs[log] = i
          logs.valid?
          expect(logs.errors[log]).to include("は数値で入力してください")
        end
      end
    end
  end
  context "submit" do
    it "全てが入力されていると、登録できる" do
      logs = build(:log)
      expect(logs).to be_valid
    end
    it "１項目が空でも登録できる" do
      target = [:weight, :bfp, :total_cal, :description, :menu_numbers]
      target.each do |log|
        logs = build(:log)
        logs[log] = nil
        expect(logs).to be_valid
      end
    end
  end
end

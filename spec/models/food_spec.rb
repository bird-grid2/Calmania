require "rails_helper"
RSpec.describe Food, type: :model do
  context "validation" do
    it "各項目が空なら登録できない" do
      target = [:element, :protain_rate, :fat_rate, :carbohydrate_rate]
      target.each do |food|
        foods = build(:food)
        foods[food] = nil
        foods.valid?
        expect(foods.errors[food]).to include("を入力してください")
      end
    end
  end
  context "submit" do
    it "全てが入力されていると、登録できる" do
      foods = build(:food)
      expect(foods).to be_valid
    end
  end
end

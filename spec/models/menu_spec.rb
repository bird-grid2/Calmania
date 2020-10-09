require "rails_helper"
RSpec.describe Menu, type: :model do
  context "validation" do
    it "menu_name、names、massesが空なら登録できない" do
      target = [:material, :names, :masses]
      target.each do |menu|
        menus = build(:menu)
        menus[menu] = nil
        menus.valid?
        expect(menus.errors[menu]).to include("を入力してください")
      end
    end
  end
  context "submit" do
    it "全てが入力されていると、登録できる" do
      menus = build(:menu)
      expect(menus).to be_valid
    end
  end
end

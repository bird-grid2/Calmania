require 'rails_helper'

describe Menu do

  context 'validation' do
    it 'menu名が空なら登録できない' do
      menus = build(:menu, menu: nil)
      valid(menus)
    end
    it 'namesが空なら登録できない' do
      menus = build(:menu, names: nil)
      valid(menus)
    end
    it 'massesが空なら登録できない' do
      menus = build(:menu, masses: nil)
      valid(menus, masses)
    end
    it 'carbohydrate_rateが空なら登録できない' do
      menus = build(:menu, carbohydrate_rate: nil)
      menus.valid?
      expect(menus.errors[:carbohydrate_rate]).to include("を入力してください")
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      menus = build(:menu)
      expect(menus).to be_valid
    end
  end
end

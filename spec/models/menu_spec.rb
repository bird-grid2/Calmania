require 'rails_helper'

RSpec.describe Menu, type: :model do

  context 'validation' do
    it 'menu_name、names、massesが空なら登録できない' do
      menus = build(:menu, menu_name: nil)
      menus.valid?
      expect(menus.errors[:menu_name]).to include 'を入力してください'
      menus = build(:menu, names: nil)
      menus.valid?
      expect(menus.errors[:names]).to include 'を入力してください'
      menus = build(:menu, masses: nil)
      menus.valid?
      expect(menus.errors[:masses]).to include 'を入力してください'
    end
  end

  context 'submit' do
    it '全てが入力されていると、登録できる' do
      menus = build(:menu)
      expect(menus).to be_valid
    end
  end
end

require 'rails_helper'

describe Menu do
  context 'validation' do
    target = %w[あ ｱ a １]
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
      valid(menus)
    end
    it 'massesは全角・半角文字と英文字で登録できない' do
      target.each do |i|
        logs = build(:log, masses: i)
        number(logs)
      end
    end
  end
  context 'submit' do
    it '全てが入力されていると、登録できる' do
      menus = build(:menu)
      expect(menus).to be_valid
    end
  end
end

require 'rails_helper'

Rspec.describe Menu, type: :model do
  context 'validation' do
    it 'menu名、names、massesが空なら登録できない' do
      test = ['menu: nil', 'names: nil', 'masses: nil']
      
      test.each do |i|
        menus = build(:menu, i)
        menus.valid?
        expect(menus.errors).to include 'を入力してください'
      end
    end
    
    it 'massesは全角・半角文字と英文字で登録できない' do
      target = %w[あ ｱ a １]
      target.each do |i|
        logs = build(:log, masses: i)
        logs.valid?
        expect(logs.errors[:masses]).to include 'は数値で入力してください'
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

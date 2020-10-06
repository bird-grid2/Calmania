require 'rails_helper'

Rspec.describe Menu, type: :model do
  
  def valid(val)
    val.valid?
    expect(val.errors).to include 'を入力してください'
  end

  def number(num)
    num.valid?
    expect(num.errors).to include 'は数値で入力してください'
  end
  
  context 'validation' do
    target = %w[あ ｱ a １]

    it 'menu名、names、massesが空なら登録できない' do
      menus = build(:menu, menu: nil)
      valid(menus)
      menus = build(:menu, names: nil)
      valid(menus)
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

class ManagementsController < ApplicationController

  def index
    @logs = Log.all
    @menus = Menu.all
    @user = User.find(current_user.id)
    
    require 'Date'
    require 'bigdecimal'
    date = Date.today
    @cal = Log.where(date: Date.today)
    gon.today = @cal
    total = []
    weight = []
    bfp = []
    p = []
    f = []
    c = []
    @detail = []
    
    # 1ヶ月間の記録
    for i in 0..30 do
      last = Log.where(date: Date.today - i)
      last.each do |d|
        @detail << d
      end
    end 

    # カロリーの計算と表示
    @cal.each do |cal|
      total << cal.total_cal
      weight << cal.weight
      bfp << cal.bfp
      cal.menu_numbers.each do |j|
        p << @menus.find(j).total_protain
        f << @menus.find(j).total_fat
        c << @menus.find(j).total_carbohydrate
      end
    end

    # 過去１ヶ月間の最大体重を表示
    if weight.blank? 
      for j in 1..31 do
        last = Log.where(date: Date.today - j) 
        if last.present?
          last.each do |w|
            weight << w.weight
          end
          break
        end
      end
    end

    # 過去１ヶ月間の最大体脂肪率を表示
    if bfp.blank? 
      for k in 1..31 do
        last = Log.where(date: Date.today - k) 
        if last.present?
          last.each do |b|
            bfp << b.bfp
          end
          break
        end
      end
    end
    @today_cal = total.sum.to_s
    @today_weight = weight.max.to_s
    @today_bfp = bfp.max.to_s
    @today_protain = p.sum.to_s
    @today_fat = f.sum.to_s
    @today_carb = c.sum.to_s
    @BMI = BigDecimal((weight.max / ((@user.height/100) ** 2)).to_s).ceil(1)
    @weight = BigDecimal((((@user.height/100) ** 2) * 22).to_s).ceil(2) 

  end
end

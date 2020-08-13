class ManagementsController < ApplicationController

  def index
    @logs = Log.all
    @menus = Menu.all
    
    require 'Date'
    date = Date.today
    @cal = Log.where(date: Date.today)
    gon.today = @cal
    total = []
    weight = []
    bfp = []
    num = []
    p = []
    f = []
    c = []

    # カロリーの計算と表示
    @cal.each do |cal|
      total << cal.total_cal
      weight << cal.weight
      bfp << cal.bfp
      
      num << cal.menu_numbers
      num.each do |i|
        p << @menu.find[i].total_protain
        f << @menu.find[i].total_fat
        c << @menu.find[i].total_carbohydrate
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
  end
end

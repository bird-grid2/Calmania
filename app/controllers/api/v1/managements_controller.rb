class Api::V1::ManagementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = Log.all.includes(:id).order(date: 'DESC')
    @menus = Menu.all
    @user = User.find(current_user.id)
    
    require 'date'
    require 'bigdecimal'
    date = Date.today
    @cal = Log.where(date: date)
    gon.today = @cal
    total = []
    weight = []
    bfp = []
    p = []
    f = []
    c = []
    @detail = []
    
    # record during 1 month
    for i in 0..30 do
      last = Log.where(date: (date - i))
      last.each do |d|
        @detail << d
      end
    end 

    # calory calculate and view
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

    # max weight during 1 month
    if weight.blank? 
      for j in 1..31 do
        last = Log.where(date: (date - j)) 
        if last.present?
          last.each do |w|
            weight << w.weight
          end
          break
        end
      end
    end

    # max body fat percentage during 1 month
    if bfp.blank? 
      for k in 1..31 do
        last = Log.where(date: (date - k)) 
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
    
    if @user.height.present? && weight.present?
      @body_mass_index = BigDecimal((weight.max / ((@user.height/100) ** 2)).to_s).ceil(1)
      @weight = BigDecimal((((@user.height/100)**2)*22).to_s).ceil(2) 
    end
  end
end

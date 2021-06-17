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
    range = 0..30

    # record during 1 month
    range.each do |i|
      last = Log.where(date: (date - i))
      @detail << last
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

     # max body fat percentage during 1 month
     next unless bfp.blank?
     range.each do |j|
       last = Log.where(date: (date - j))
       next unless last.present?
         bfp << last.bfp
       end
     end
   end

    # max weight during 1 month
    next unless weight.blank?
      range.each do |k|
        last = Log.where(date: (date - k))
        next unless last.present?
          weight << last.weight
        end
      end
    end

    @today_cal = total.sum.to_s
    @today_weight = weight.max.to_s
    @today_bfp = bfp.max.to_s
    @today_protain = p.sum.to_s
    @today_fat = f.sum.to_s
    @today_carb = c.sum.to_s

    next unless @user.height.present? && weight.present?
      @body_mass_index = BigDecimal((weight.max / ((@user.height / 100)**2)).to_s).ceil(1)
      @weight = BigDecimal((((@user.height / 100)**2) * 22).to_s).ceil(2)
    end
  end
end

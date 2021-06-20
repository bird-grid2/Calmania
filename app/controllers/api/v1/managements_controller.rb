class Api::V1::ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parameter, only: [:index]

  def index
    require 'bigdecimal'
    gon.today = @cal
    total = []
    weight = []
    bfp = []
    p = []
    f = []
    c = []

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

  private

  def set_parameter
    require 'time'
    dateTime = Time.current.midnight + 1.day

    @period = Log.where(created_at: (dateTime - 31.days)..dateTime).order(date: 'DESC')
    @cal = Log.where(created_at: (dateTime - 1.day)..dateTime)
    @menus = Menu.all
    @user = User.find(current_user.id)
  end
end

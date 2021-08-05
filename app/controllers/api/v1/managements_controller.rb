class Api::V1::ManagementsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :authenticate_request!, only: [:index]
  before_action :set_parameter, only: [:index]

  def index
    require 'bigdecimal'
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

    if @current_user.height.present? && weight.present?
      @body_mass_index = BigDecimal((weight.max / ((@current_user.height / 100)**2)).to_s).ceil(1)
      @weight = BigDecimal((((@current_user.height / 100)**2) * 22).to_s).ceil(2)
    end

    managementData = {
      totalCal: total.sum.to_s,
      weight: weight.max.to_s,
      bfp: bfp.max.to_s,
      protain: p.sum.to_s,
      fat: f.sum.to_s,
      carboHydrate: c.sum.to_s,
      bmi: @body_mass_index,
      idealWeight: @weight
    }

    render json: { status: "success", data: managementData }
  end

  private

  def set_parameter
    require 'time'
    date_time = Time.current.midnight + 1.day

    @period = Log.where(created_at: (date_time - 31.days)..date_time).order(date: 'DESC')
    @cal = Log.where(created_at: (date_time - 1.day)..date_time)
    @menus = Menu.all
  end
end

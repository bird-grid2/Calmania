class Api::V1::LogsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_log, only: [:edit, :update, :destroy]

  def new
    @log = Log.new
    @menus = Menu.all

    menu = []

    @menus.each_with_index do |log, _|
      menu << log
    end

    gon.menu = menu
  end

  def create
    @log = Log.new(log_params)

    if @log.save
      render json: "create log"
    else
      render json: "not create log"
    end
  end

  def index
    @logs = Log.order(date: 'DESC').where(user_id: auth_token[:user_id])
    
    return if @logs.nil?

    render json: @logs
  end

  def search
    @logs = Log.order(date: 'DESC').search(params[:keyword])

    if @logs.present?
      render json: @logs
    else
      render json: 'nil'
    end
  end

  def dsearch
    @logs = Log.order(date: 'DESC').dsearch(params[:keyword2])

    if @logs.present?
      render json: @logs
    else
      render json: 'nil'
    end
  end

  def edit
    @menus = Menu.all
    menu = []
    num = []

    @menus.each_with_index do |log, _|
      menu << log
    end
    gon.menu = menu

    @log.menu_numbers.each do |log|
      num << log
    end
    gon.edit = num
  end

  def destroy
    if @log.destroy
      redirect_to api_v1_logs_path, notice: 'ログを削除しました'
      render json: { status: 'SUCCESS', data: @log }
    else
      flash.now[:alert] = 'ログ削除を失敗しました'
      render json: { status: 'ERROR', data: @log.errors }
      redirect_back(fallback_location: ap1_v1_root_path)
    end
  end

  def update
    if @log.update(log_params)
      redirect_to api_v1_logs_path, notice: 'ログを更新しました'
      render json: { status: 'SUCCESS', data: @log }
    else
      flash.now[:alert] = 'ログ更新を失敗しました'
      render json: { status: 'ERROR', data: @log.errors }
      redirect_back(fallback_location: ap1_v1_root_path)
    end
  end

  private

  def log_params
    params.require(:log).permit(:date, :weight, :bfp, :description, :total_cal, menu_numbers: []).merge(user_id: auth_token[:user_id])
  end

  def set_log
    @log = Log.find(params[:id])
  end
end

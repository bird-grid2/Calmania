class Api::V1::LogsController < Api::V1::ApplicationController
  before_action :authenticate_request!
  before_action :set_log, only: [:edit, :update, :destroy]

  def new
    @logs = Menu.all.order(:id)
    render json: @logs
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
    @logs = Log.order(date: 'DESC').where(user_id: @current_user.id)

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
    if @log.present?
      render json: @log
    else
      render json: @log.errors
    end
  end

  def destroy
    if @log.destroy
      render json: 'delete log'
    else
      render json: 'not delete log'
    end
  end

  def update
    if @log.update(log_params)
      render json: 'update log'
    else
      render json: 'not update log'
    end
  end

  def menu_data
    @menus = Menu.all.order(:id)
    render json: @menus
  end

  private

  def log_params
    params.require(:log).permit(:date, :weight, :bfp, :description, :total_cal, menu_numbers: []).merge(user_id: @current_user.id)
  end

  def set_log
    @log = Log.find(params[:id])
  end
end

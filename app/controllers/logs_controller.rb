class LogsController < ApplicationController
  before_action :set_log, except: [ :new, :create, :index ]

  def new
    @log = Log.new
    @menus = Menu.all
    
    menu =[]
    
    @menus.each_with_index do |log|
      menu << log
    end
    
    gon.menu = menu 
  end

  def create
    @log = Log.new(log_params)

    if @log.save
      redirect_to logs_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @logs = Log.all
  end

  def edit
  end

  def destroy
    if @log.destroy 
      redirect_to logs_path
    else
      render :logs
    end
  end

  def update
    if @log.update 
      redirect_to logs_path
    else
      render :logs
    end
  end

  private

    def log_params
      params.require(:log).permit( :date, :weight, :bfp, :description, :total_cal, menu_numbers: []).merge(user_id: current_user.id)
    end

    def set_log
      @log = Log.find(params[:id])
    end

end
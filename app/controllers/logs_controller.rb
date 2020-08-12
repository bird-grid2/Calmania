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
    @log.save
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
      params.require(:log)
    end

    def set_log
      @log = Log.find(params[:id])
    end

end
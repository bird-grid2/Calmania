class LogsController < ApplicationController
  before_action :set_log, except: :new, :create, :index 

  def new
    @log = Log.new
    @log.id << params[:id]
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
    if @log.destroy do
      redirect_to logs_path
    else
      render :logs
    end
  end

  def update
    if @log.update do
      redirect_to logs_path
    else
      render :logs
    end
  end

  private

    def log_params
      params.require(:logs)
    end

    def set_log
      @log = Log.find(params[:id])
    end

end

class LogsController < ApplicationController

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
    @log = Log.find(params[:id])
  end

  def destroy
    @log = Log.find(params[:id])
    if @log.destroy do
      redirect_to logs_path
    else
      render :logs
    end
  end

  def update
    @log = Log.find(params[:id])
    if @log.update do
      redirect_to logs_path
    else
      render :logs
    end
  end

end

class LogsController < ApplicationController
  before_action :set_log, except: [ :new, :create, :index ]
  before_action :move_to_index, only: [ :index, :search ]

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
      redirect_to logs_path, notice: 'ログを作成しました'
    else
      flash.now[:alert] = 'ログの作成を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @logs = Log.all.order(date: 'DESC')
  end

  def search
    @logs = Log.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @menus = Menu.all
    menu = []
    num = []

    @menus.each_with_index do |log|
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
      redirect_to logs_path, notice: 'ログを削除しました'
    else
      flash.now[:alert] = 'ログ削除を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @log.update(log_params) 
      redirect_to logs_path, notice: 'ログを更新しました'
    else
      flash.now[:alert] = 'ログ更新を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def log_params
      params.require(:log).permit( :date, :weight, :bfp, :description, :total_cal, menu_numbers: []).merge(user_id: current_user.id)
    end

    def set_log
      @log = Log.find(params[:id])
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

end
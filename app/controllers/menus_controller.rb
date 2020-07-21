class MenusController < ApplicationController
  before_action :set_log

  def new
    @menu = Menu.new
    Menu.id << params[:id]    
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save
  end

  def index
    @menus = Menu.all
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update do
      redirect_to log_menus_path
    else
      render :menus
    end
  end

  private
  def menu_params
    params.require(:menu_param).permit(:menu, :mass, :total_protain, :total_fat, :total_carbohydrate)
  end

  def set_log
    @food = Log.find(params[:log_id])
  end

end

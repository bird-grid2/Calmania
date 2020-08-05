class MenusController < ApplicationController
  before_action :set_menu, except: [ :new, :create]

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
  end

  def update
    if @menu.update
      redirect_to log_menus_path
    else
      render :menus
    end
  end

  private
  def menu_params
    params.require(:menus).permit(:menu, :mass, :total_protain, :total_fat, :total_carbohydrate)
  end

  def set_menu
    binding.pry
    @menu = Menu.find(params[:id])
  end

end

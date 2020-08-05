class MenusController < ApplicationController
  before_action :set_menu, except: [:index, :new, :create]

  def new
    @menu = Menu.new
    @foods = Food.all
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menu_path
    else
      render 'menu'
    end
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
    @menu = Menu.find(params[:id])
  end

end

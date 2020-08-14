class MenusController < ApplicationController
  before_action :set_menu, only: [ :edit, :update, :destroy ]
  before_action :move_to_index, only: [ :index, :search ] 

  def new
    @menu = Menu.new
    @foods = Food.all

    food = []

    @foods.each_with_index do |elem|
      food << elem
    end
    gon.food = food
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menus_path
    else
      render :new
    end
  end

  def index
    @menus = Menu.all
  end

  def search
    @menus = Menu.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
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

  def destroy
  end

  private
  def menu_params
    params.require(:menu).permit(:menu, :total_protain, :total_fat, :total_carbohydrate, names: [], masses:[])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end

class MenusController < ApplicationController
  before_action :set_menu, except: [:index, :new, :create]

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
    binding.pry
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
    params.require(:menu)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

end

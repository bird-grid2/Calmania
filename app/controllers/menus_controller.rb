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
      redirect_to menus_path, notice: 'メニューを作成しました' 
    else
      flash.now[:alert] = 'メニュー作成を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @menus = Menu.all.order(id: 'ASC')
  end

  def search
    @menus = Menu.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @foods = Food.all
    food = []
    menu = []
    mass = []

    @foods.each do |f|
      food << f
    end
    gon.food = food

    @menu.names.each do |m|
      menu << m
    end
    gon.menu = menu

    @menu.masses.each do |m|
      mass << m
    end
    gon.mass = mass
  end

  def update
    if @menu.update(menu_params)
      redirect_to menus_path, notice: 'メニューを更新しました'
    else
      flash.now[:alert] = 'メニュー更新を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @menu.destroy
      redirect_to menus_path, notice: 'メニューを削除しました'
    else
      flash.now[:alert] = 'メニュー削除を失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def menu_params
    params.require(:menu).permit(:element, :total_protain, :total_fat, :total_carbohydrate, names: [], masses: [])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end

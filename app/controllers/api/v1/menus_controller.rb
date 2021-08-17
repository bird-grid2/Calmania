class Api::V1::MenusController < ApplicationController
  before_action :authenticate_request!, except: [ :create ]
  before_action :set_menu, only: [:edit, :update, :destroy]

  def new
    @foods = Food.all
    render json: @foods
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      render json: "create menu"
    else
      render json: "not create menu"
    end
  end

  def index
    @menus = Menu.all.order(id: 'ASC')

    return if @menus.blank?

    render json: @menu
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
      redirect_to api_v1_menus_path, notice: 'メニューを更新しました'
      render json: { status: 'SUCCESS', data: @menu }
    else
      flash.now[:alert] = 'メニュー更新を失敗しました'
      render json: { status: 'ERROR', data: @menu.errors }
      redirect_back(fallback_location: ap1_v1_root_path)
    end
  end

  def destroy
    if @menu.destroy
      redirect_to api_v1_menus_path, notice: 'メニューを削除しました'
    else
      flash.now[:alert] = 'メニュー削除を失敗しました'

      redirect_back(fallback_location: ap1_v1_root_path)
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:material, :total_protain, :total_fat, :total_carbohydrate, names: [], masses: [])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end

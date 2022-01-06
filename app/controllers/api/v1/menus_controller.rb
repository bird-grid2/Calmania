class Api::V1::MenusController < ApplicationController
  before_action :authenticate_request!
  before_action :set_menu, only: [:edit, :update, :destroy]
  before_action :set_food, only: [:food_data]

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

    render json: @menus
  end

  def search
    @menus = Menu.search(params[:keyword])

    if @menus.present?
      render json: @menus
    else
      render json: 'nil'
    end
  end

  def edit
    if @menu.present?
      render json: @menu
    else
      render json: @menu.errors
    end
  end

  def food_data
    if @food.present?
      render json: @food
    else
      render json: @food.errors
    end
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
  
  def set_food
    @food = Food.find(params[:id])
  end
end

class Api::V1::MenusController < Api::V1::ApplicationController
  before_action :authenticate_request!
  before_action :set_menu, only: [:edit, :update, :destroy]
  before_action :set_food, only: [:food_data]

  def new
    @foods = Food.all.order(:id)
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
    @menus = Menu.all.order(:id)

    return if @menus.nil?

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
      render json: "update menu"
    else
      render json: "not update menu"
    end
  end

  def destroy
    if @menu.destroy
      render json: "delete menu"
    else
      render json: "not delete menu"
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

class UsersController < ApplicationController
  before_action :set_user, only: [ :update, :edit, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'ユーザー情報を作成しました'
    else
      flash.now[:alert] = 'ユーザー情報作成に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー情報更新に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @user.destroy 
      redirect_to root_path, notice: 'ユーザー情報を削除しました'
    else
      flash.now[:alert] = 'ユーザー情報削除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def sendtime
    Clockwork.send
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :encrypted_password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

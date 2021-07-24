# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :configure_sign_in_params, only: [:create]

  def new
    @user = User.new(sign_in_params)
    render json: @user
  end
    
  def create
    @user = User&.authenticate(params[:user][:email], params[:user][:nickname], params[:user][:password])

    if @user.present?
      render json: @user
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    add_list = [:nickname, :email, :password]
    devise_parameter_sanitizer.permit(:sign_in, keys: add_list)
  end

  def after_sign_up_path_for(*)
    api_v1_managements_path
  end

  def after_update_path_for(*)
    api_v1_managements_path
  end
end

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_in_params
#   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# end

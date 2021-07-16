# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :configure_sign_in_params, only: [:create]

  def create
    if user = User&.authenticate(sign_in_params[:email], sign_in_params[:nickname], sign_in_params[:password])
      session[:user_id] = user.id
      render 'api/v1/mangements/index'
    else
      render 'shows/index'
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

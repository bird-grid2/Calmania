# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:email], nickname: params[:nickname])

    if resource.valid_password?(params[:password])
      render json: payload(resource)
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

  private

  def payload(user)
    return nil unless user && user&.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id, exp: (Time.now + 2.week).to_i }),
      user: { id: user.id, email: user.email, nickname: user.nickname }
    }
  end
end

# DELETE /resource/sign_out
# def destroy
#   super
# end

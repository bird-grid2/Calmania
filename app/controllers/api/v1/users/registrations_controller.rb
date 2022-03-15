# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_request!, except: [:new, :create]
  before_action :configure_permitted_parameters, only: [:create, :edit, :update]

  def edit
    if @current_user.blank?
      render json: "NG"
    elsif @current_user.valid_password?(params[:password])
      render json: payload(@current_user)
    end
  end

  def create
    @user = User.create(sign_up_params)
    
    if @user.save
      render json: payload(@user)
    else
      render json: 'user not save'
    end
  end

  private

  # If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:height])

    add_list = [:height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, { clock_work_event_attributes: [:period_id, :send_time] }]
    devise_parameter_sanitizer.permit(:account_update, keys: add_list)
  end

  def sign_up_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation, :height)
  end

  def payload(user)
    return nil unless user && user&.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id, exp: (Time.now + 2.week).to_i }),
      user: { id: user.id, email: user.email, nickname: user.nickname }
    }
  end
end

# GET /resource/sign_up
# def new
#   super
# end

# POST /resource
# def create
#   super
# end

# GET /resource/edit
# def edit
#   super
# end

# PUT /resource
# def update
#   super
# end

# DELETE /resource
# def destroy
#   super
# end

# GET /resource/cancel
# Forces the session data which is usually expired after sign
# in to be expired now. This is useful if the user wants to
# cancel oauth signing in/up in the middle of the process,
# removing all OAuth session data.
# def cancel
#   super
# end

# def configure_sign_up_params
#   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
# end

# If you have extra params to permit, append them to the sanitizer.
# def configure_account_update_params
#   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
# end

# The path used after sign up.
# def after_sign_up_path_for(resource)
#   super(resource)
# end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end

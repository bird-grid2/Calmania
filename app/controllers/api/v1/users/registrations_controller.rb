# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_request!, except: [:create, :update]
  before_action :configure_sign_up_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?

  def load_data
    data = JsonWebToken.decode(params[:token])
    binding.pry
    if user_id_in_token?
      render json: editPayload(@current_user, data["password"], params[:token])
    else
      render json: "NG"
    end
  end

  def create
    @user = User.create(sign_up_params)

    if @user.save
      render json: payload(@user, @user.password)
    else
      render json: 'user not save'
    end
  end

  def update
    binding.pry
    resource = User.find_for_database_authentication(params[:user_id])
    if resource.update(account_update_params)
      render json: 'update user info'
    else
      render json: "NG"
    end
  end

  private

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:height])
  end

  def configure_account_update_parameters
    add_list = [:height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, clock_work_event_attributes: [:period_id, :send_time] ]
    devise_parameter_sanitizer.permit(:account_update, keys: add_list)
  end

  def sign_up_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation, :height)
  end

  def account_update_params
    add_list = [ :email, :nickname, :password, :password_confirmation, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, { clock_work_event_attributes: [:period_id, :send_time] }]
    params.require(:user).permit(add_list)
  end


  def payload(user, password)
    return nil unless user && user&.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id, password: password, exp: (Time.now + 2.week).to_i }),
      user: { id: user.id, email: user.email, nickname: user.nickname }
    }
  end

  def editPayload(user, password, token)
    return nil unless user && user&.id

    {
      auth_token: token,
      password: password,
      user: user
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

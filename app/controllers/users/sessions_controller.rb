# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :configure_sign_in_params, only: [:create]

  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :password, :password_confirmation, :period_id, :send_time, :target_cal ]
    devise_parameter_sanitizer.permit(:sign_in, keys: add_list)
  end

  def after_sign_up_path_for(resource)
    managements_path
  end

  def after_update_path_for(resource)
    managements_path
  end

end

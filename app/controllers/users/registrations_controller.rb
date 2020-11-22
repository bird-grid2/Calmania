# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :edit, :update ]

  def update
    redirect_to managements_path(resource)
  end

  protected

  def after_update_path_for(resource)
    managements_path
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :password, :password_confirmation, :period_id, :send_time, :target_cal ]
    devise_parameter_sanitizer.permit(:sign_up, keys: add_list)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :password, :password_confirmation, :period_id, :send_time, :target_cal ]
    devise_parameter_sanitizer.permit(:account_update, keys: add_list)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    managements_path
  end

 

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #  root_path
  # end

end

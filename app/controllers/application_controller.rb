class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource) 
    managements_path(resource)
  end

  protected

  def configure_permitted_parameters
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :password, :password_confirmation, :period_id, :send_time, :target_cal ]
    devise_parameter_sanitizer.permit :sign_up, keys: add_list
    devise_parameter_sanitizer.permit :account_update, keys: add_list
    devise_parameter_sanitizer.permit :sign_in, keys: [:nickname, :email, :password]
  end
  
end

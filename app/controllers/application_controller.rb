class ApplicationController < ActionController::Base
  require 'pycall'
  require 'pycall/import'
  require 'matplotlib/pyplot'
  require 'numpy'
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache_headers

  def after_sign_in_path_for(*)
    managements_path
  end

  def after_sign_out_path_for(*)
    root_path
  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  private
  
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end
  
  protected

  def configure_permitted_parameters
    add_list = [ :nickname, :email, :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, :password, :password_confirmation, { clock_work_event_attributes: [:period_id, :send_time] }]
    devise_parameter_sanitizer.permit :sign_up, keys: [ :nickname, :email, :height, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :account_update, keys: add_list
  end
end

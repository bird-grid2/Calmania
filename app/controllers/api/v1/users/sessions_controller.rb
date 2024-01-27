# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :authenticate_request!, except: [:new, :create]
  skip_before_action :verify_signed_out_user, only: :destroy

  def new; end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:email], nickname: params[:nickname])
    token = payload(resource, params[:password])
    if resource.blank?
       render json: "NG"
    elsif resource.valid_password?(params[:password])
      # render json: payload(resource, params[:password])
      render json: ActiveModelSerializers::SerializableResource.new(resource, serializer: UserSerializer).as_json.deep_merge(user: { token: token })
    end
  end

  # DELETE /resource/sign_out
  def destroy
    binding.pry
    denylist = JwtDenylist.new(jti: auth_token[0]["auth_data"]["jti"], exp: auth_token[0]["auth_data"]["exp"])
    denylist.save
    render json: { message: 'ログアウトしました' }, status: 200
  end



  protected

  # If you have extra params to permit, append them to the sanitizer.

  def after_sign_up_path_for(*)
    api_v1_managements_path
  end

  def after_update_path_for(*)
    api_v1_managements_path
  end

  def set_flash_message!(key, kind, options = {})
    # nothing
  end
end



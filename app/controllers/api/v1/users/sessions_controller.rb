# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  before_action :authenticate_request!, except: [:new, :create]

  def new; end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:email], nickname: params[:nickname])
    if resource.blank?
      render json: "NG"
    elsif resource.valid_password?(params[:password])
      render json: payload(resource, params[:password])
    end
  end

  # DELETE /resource/sign_out
  def destroy
    denylist = JwtDenylist.new(jti: payload['jti'], exp: payload['exp'])
    denylist.save
    rendder json: { message: 'ログアウトしました' }, status: 200
  end



  protected

  # If you have extra params to permit, append them to the sanitizer.

  def after_sign_up_path_for(*)
    api_v1_managements_path
  end

  def after_update_path_for(*)
    api_v1_managements_path
  end

  private

  def payload(user, password)
    return nil unless user && user&.id

    {
      auth_token: JsonWebToken.encode({ user_id: user.id, password: password, exp: (Time.now + 2.week).to_i }),
      user: { id: user.id, email: user.email, nickname: user.nickname }
    }
  end
end



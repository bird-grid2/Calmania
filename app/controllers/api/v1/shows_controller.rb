class Api::V1::ShowsController < ApplicationController
  before_action :response_headers, only: [:index]

  def index
    render json: ""
  end

  private

  def response_headers
    response.headers['Content-Type'] = 'application/json'
    response.headers['X-Requested-With'] = 'XMLHttpRequest'
  end
end


require "#{Rails.root}/app/helpers/redis_helper"
require "#{Rails.root}/app/services/jwt_service"
require "#{Rails.root}/app/middlewares/authorization_middleware"

class Api::V1::Authentication::LogoutController < ApplicationController
  middleware.use AuthorizationMiddleware

  def index
    return processing()
  end

  private
  def processing
    begin
      render json: { code: 200, message: 'OK', data: nil }
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end
end
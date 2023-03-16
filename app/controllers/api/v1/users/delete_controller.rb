require "#{Rails.root}/app/middlewares/authorization_middleware"

class Api::V1::Users::DeleteController < ApplicationController
  middleware.use AuthorizationMiddleware

  def index
    begin
      data = processing()
      render json: { code: 200, message: 'OK', data: data }
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end

  private
  def processing
    user = User.where(id: params[:id]).first
    
    if user
      deleted = user.soft_delete
    end
    
    return deleted
  end
end  
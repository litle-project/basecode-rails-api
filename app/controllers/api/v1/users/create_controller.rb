require 'bcrypt'
require "#{Rails.root}/app/middlewares/authorization_middleware"

class Api::V1::Users::CreateController < ApplicationController
  middleware.use AuthorizationMiddleware

  def index
    return processing()
  end

  private
  def processing
    begin
      created = User.create(
        name: params[:name],
        email: params[:email],
        phone_number: params[:phone],
        password: params[:password]
      )

      if created.valid?
        created.update(password: BCrypt::Password.create(params[:password]))
      end

      if !created.valid?
        render json: { code: 422, message: created.errors.full_messages.first, data: nil }, status: :unprocessable_entity
      else
        render json: { code: 200, message: 'OK', data: nil }
      end
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end
end
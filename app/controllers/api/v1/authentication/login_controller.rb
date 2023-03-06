class Api::V1::Authentication::LoginController < ApplicationController
  include RedisHelper
  require_relative '../../../../services/jwt_service'
  require 'bcrypt'

  def index
    return processing()
  end

  private
  def processing
    begin
      user = User.where(email: params[:email]).first

      if !user
        return render json: { code: 400, message: 'email not found', data: nil }, status: :bad_request
      end

      if !BCrypt::Password.new(user.password).is_password?(params[:password])
        return render json: { code: 400, message: 'incorrect email or password', data: nil }, status: :bad_request
      end

      token = JwtService.encode({ id: user.id, mail: user.email });
      redis_set("token-#{user.id}", token, 86400);
      
      render json: {
        code: 200,
        message: 'OK',
        data: {
          name: user.name,
          email: user.email,
          phone: user.phone_number,
          token: token,
        },
      }

    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end
end
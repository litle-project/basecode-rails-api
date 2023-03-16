require "#{Rails.root}/app/helpers/redis_helper"

class AuthorizationMiddleware
  include RedisHelper
  
  def initialize(app)
    @app = app
  end

  def call(env)
    token = env['HTTP_AUTHORIZATION']&.split&.last
    if token.nil? || !tokenExist?(token) || JwtService.expired?(token)
      return response()
    end

    @app.call(env)
  end

  def tokenExist?(token)
    begin
      user = JwtService.decode(token)
      
      if !user
        return false
      end
      
      token_redis = redis_get("token-#{user['id']}")
      if !token_redis
        return false
      end

      return user
    rescue => exception
      return response()
    end
  end

  def response
    return [
      401,
      {'Content-Type' => 'application/json'},
      [{ code: 401, message: 'Unauthorized', data: nil }.to_json]
    ]
  end
end
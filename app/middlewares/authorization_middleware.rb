class AuthorizationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    token = env['HTTP_AUTHORIZATION']&.split&.last
    if token.nil? || JwtService.expired?(token)
      return response()
    end

    @app.call(env)
  end

  def response
    return [
      401,
      {'Content-Type' => 'application/json'},
      [{ code: 401, message: 'Unauthorized', data: nil }.to_json]
    ]
  end
end
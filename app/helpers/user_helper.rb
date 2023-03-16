
module UserHelper
  def getUser(env)
    token = env['HTTP_AUTHORIZATION']&.split&.last
    user = JwtService.decode(token)
    return User.where(id: user['id']).first || nil
  end
end

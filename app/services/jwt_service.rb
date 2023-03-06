class JwtService
  SECRET_KEY = ENV['JWT_SECRET'] || 'secret'
  EXPIRATION_TIME = 24.hours.to_i

  def self.encode(payload)
    payload[:exp] = Time.now.to_i + EXPIRATION_TIME
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end

  def self.expired?(token)
    payload = decode(token)
    payload && payload[:exp] && Time.at(payload[:exp]) < Time.now
  end
end

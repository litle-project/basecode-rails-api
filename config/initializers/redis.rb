require 'redis'

redis = Redis.new(
  host: ENV['REDIS_HOST'] || '127.0.0.1',
  port: ENV['REDIS_PORT'] || '6379',
  db: 0,
)

Redis.current = redis

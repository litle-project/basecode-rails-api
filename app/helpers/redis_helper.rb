require 'redis'
include ActionView::Helpers::DebugHelper

module RedisHelper
  def redis_set(key, value, expire_seconds = 3600, db = 0)
    # Connect to Redis
    redis = Redis.current

    # Switch to the specified Redis database
    redis.select(db)

    # Set a value with an expiration time
    redis.setex(key, expire_seconds, value)
  end

  def redis_get(key, db = 0)
    # Connect to Redis
    redis = Redis.current

    # Switch to the specified Redis database
    redis.select(db)

    # Get the value from Redis
    redis.get(key)
  end

  def redis_delete(key, db = 0)
    # Connect to Redis
    redis = Redis.current

    # Switch to the specified Redis database
    redis.select(db)

    # Delete the value from Redis
    redis.del(key)
  end
end

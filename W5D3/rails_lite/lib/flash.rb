require 'json'

class Flash
  COOKIE_NAME = '_rails_lite_app_flash'
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    req_cookie = req.cookies[COOKIE_NAME]
    @flash_now = req_cookie ? JSON.parse(req_cookie) : {}
    @flash = {}
  end

  def [](key)
    @flash_now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end

  def now
    @flash_now
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_flash(res)
    cookie_attributes = {}
    cookie_attributes[:path] = '/'
    cookie_attributes[:value] = @flash.to_json
    res.set_cookie(COOKIE_NAME, cookie_attributes)
  end
end

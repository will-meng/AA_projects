require 'json'

class Session
  COOKIE_NAME = '_rails_lite_app'
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    req_cookie = req.cookies[COOKIE_NAME]
    @cookie = req_cookie ? JSON.parse(req_cookie) : {}
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie_attributes = {}
    cookie_attributes[:path] = '/'
    cookie_attributes[:value] = @cookie.to_json
    res.set_cookie(COOKIE_NAME, cookie_attributes)
  end
end

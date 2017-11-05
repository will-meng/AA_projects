class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :cats

  def self.find_by_credential(username, pw)
    user = User.find_by(username: username)
    return nil unless user
    user.matching_password?(pw) ? user : nil
  end

  attr_reader :password

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def ensure_session_token
    self.session_token ||= generate_random_token
  end

  def matching_password?(pw)
    pass_hash = BCrypt::Password.new(self.password_digest)
    pass_hash.is_password?(pw)
  end

  def reset_session_token!
    self.session_token = generate_random_token
    self.save
    self.session_token
  end

  def generate_random_token
    SecureRandom::urlsafe_base64(16)
  end
end

class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :comments
  has_many :goals

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && BCrypt::Password.new(user.password_digest).is_password?(password)
      return user
    end
    nil
  end

end

  # as author
  # has_many :wall_comments,
  #   foreign_key: :author_id,
  #   class_name: :Comment

  # has_many :goal_comments,


  # as commenter
  # has_many :comments_for_user,
  #   foreign_key: :commenter_id
  #
  # has_many :comments_for_users_goal,
  #   foreign_key: :commenter_id

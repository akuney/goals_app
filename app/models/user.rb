class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password


  after_initialize :ensure_session_token
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  has_many(
  :goals,
  foreign_key: :owner_id)

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user.try(:is_password?, password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    #reset session[:session_token]
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end

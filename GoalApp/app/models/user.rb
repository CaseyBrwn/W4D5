class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true

    after_initialize :ensure_session_token

    attr_reader :password

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.session_token
    end

    def self.find_by_credentials(username, password)
        debugger
        user = User.find_by(username: username)
        user && user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        b_crypt = BCrypt::Password.new(self.password_digest)
        b_crypt.is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

end
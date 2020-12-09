class User < ApplicationRecord
    validates :username, presence: true, uniqueness:true
    validates :session_token, presence: true, uniqueness:true
    validates :password_digest, presence: true 

    attr_reader :password

    after_initialize :ensure_session_token

    # FIG VAPER

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            return user
        else
            return nil
        end

    end

    def is_password?(password)
        bcrypt_pass = BCrypt::Password.new(self.password_digest)

        bcrypt_pass.is_password?(password)
    end

    def password=(password)
       @password = password

        self.password_digest = BCrypt::Password.create(password)

    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        
        self.session_token

        # self.session_token = self.class.generate_session_token # class method (self.class or User)
        # self.save! 
    end


    private

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
    
    
end

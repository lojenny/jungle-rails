class User < ActiveRecord::Base   
    has_secure_password
    has_many :reviews

    before_validation :downcase_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :password, length: { minimum: 8 }
    
    validates_uniqueness_of :email, uniqueness: {case_sensitive: false}

    def self.authenticate_with_credentials(email, password)
      email = email.strip.downcase
      user = User.find_by_email(email)
      if user && user.authenticate(password)
        user
      else
        nil
      end
    end

    private
    def downcase_email
        self.email = email.downcase if email.present?
    end


end

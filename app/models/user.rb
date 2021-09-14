class User < ApplicationRecord
    before_save { email.downcase! }

    has_secure_password
    validates :password, length: { minimum: 6 }

    validates :name, presence: true, length: { maximum: 50 }
    # ensures that only email addresses that match the pattern are considered valid
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, 
    # Rails infers that uniqueness should be true as well.
    uniqueness: { case_sensitive: false }

    #returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
end

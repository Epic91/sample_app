class User < ApplicationRecord
    before_save { self.email = email.downcase }

    has_secure_password
    validates :password, length: { minimum: 6 }

    validates :name, presence: true, length: { maximum: 50 }
    # ensures that only email addresses that match the pattern are considered valid
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, 
    # Rails infers that uniqueness should be true as well.
    uniqueness: { case_sensitive: false }
end

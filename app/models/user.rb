class User < ApplicationRecord
    has_many :restaurants
    has_many :cities, through: :restaurants
    has_many :recommendations
    has_secure_password
    #VALID_USERNAME_REGEX = \A[a-z0-9]
    #validates :username, length: {minimum: 8, maximum: 15},  format: { with: VALID_USERNAME_REGEX } presence: true, uniqueness:true
    validates :username, length: {minimum: 8, maximum: 15}, presence: true, uniqueness:true
    #validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    #VALID_EMAIL_REGEX = [A-Z0-9._%+-]+ @[AA.-]+\.[A-Z]{2,}$

end

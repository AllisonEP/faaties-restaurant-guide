class User < ApplicationRecord
    has_many :restaurants
    has_many :cities, through: :restaurants
    has_many :recommendations
    has_secure_password
    validates :username, length: {minimum: 8, maximum: 15}, presence: true, uniqueness:true
    validates_format_of :username, with: /\A[a-zA-Z0-9]+\z/
    validates :email, uniqueness: true, presence: true, unless: -> { email.blank? }
    validates_format_of :email, with: /[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@aa.com/
    #This is not working but would need to actually work to verify their email

end

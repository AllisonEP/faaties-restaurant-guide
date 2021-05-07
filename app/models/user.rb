class User < ApplicationRecord
    has_many :restaurants
    has_many :cities, through: :restaurants
    has_many :recommendations
    has_secure_password


end

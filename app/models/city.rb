class City < ApplicationRecord
    has_many :restaurants
    has_many :users, through: :restaurants
    
end

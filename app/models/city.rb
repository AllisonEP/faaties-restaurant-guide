class City < ApplicationRecord
    has_many :restaurants
    has_many :users, through: :restaurants
    accepts_nested_attributes_for :restaurants
end

class City < ApplicationRecord
    has_many :restaurants
    has_many :users, through: :restaurants
    accepts_nested_attributes_for :restaurants, reject_if: :all_blank
    validates :name, presence: true, uniqueness: true
    validates :state_or_country, length: {minimum: 3, maximum: 25}, allow_blank: true
    validates :airport_code, length: {is: 3}, allow_blank: true
end

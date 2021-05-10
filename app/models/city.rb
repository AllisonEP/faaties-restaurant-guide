class City < ApplicationRecord
    has_many :restaurants
    has_many :users, through: :restaurants, :dependent => :destroy
    accepts_nested_attributes_for :restaurants, reject_if: :all_blank
    validates :name, presence: true, length: {minimum: 3, maximum: 25}, uniqueness: true
    validates :state_or_country, length: {minimum: 3, maximum: 25}, allow_blank: true
    validates :airport_code, length: {is: 3}, allow_blank: true
    validates_associated :restaurants
end

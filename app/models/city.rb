class City < ApplicationRecord
    before_save { self.name = name.capitalize }
    has_many :restaurants
    has_many :users, through: :restaurants, :dependent => :destroy
    accepts_nested_attributes_for :restaurants, reject_if: :all_blank
    validates :name, presence: true, length: {minimum: 3, maximum: 25}
    validates_uniqueness_of :name, :case_sensitive => false
    validates :state_or_country, length: {minimum: 3, maximum: 25}, allow_blank: true
    validates :airport_code, length: {is: 3}, allow_blank: true
end

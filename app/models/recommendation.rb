class Recommendation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant, reject_if: :all_blank
  validates :try, length: {minimum: 3, maximum: 55}, presence: true
  validates :avoid, length: {minimum: 3, maximum: 55}, allow_blank: true

  def restaurant_name
    self.restaurant.id
  end 

  def restaurant_attributes=(attributes)
    if attributes["name"] != ""
      restaurant = Restaurant.find_or_create_by(attributes)
      self.restaurant = restaurant if restaurant.valid? || self.restaurant
    end 
  end

end

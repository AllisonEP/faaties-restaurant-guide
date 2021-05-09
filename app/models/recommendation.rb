class Recommendation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :try, length: {minimum: 3, maximum: 55}, presence: true
  validates :avoid, length: {minimum: 3, maximum: 55}, allow_blank: true

  def restaurant_name
    self.restaurant.name
  end 

end

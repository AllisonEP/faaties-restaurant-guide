class Recommendation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :try, presence: true

  def restaurant_name
    self.restaurant.name
  end 

end

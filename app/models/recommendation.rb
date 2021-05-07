class Recommendation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :try, presence: true, message: "You have to recommend something!"

  def restaurant_name
    self.restaurant.name
  end 

end

class Restaurant < ApplicationRecord
  belongs_to :user
  belongs_to :city
  accepts_nested_attributes_for :city, reject_if: :all_blank
  #validates :city_id, presence: true

  def city_name
    self.try(:city).try(:name)
  end

  def city_attributes=(attributes)
    city = City.find_or_create_by(attributes)
    self.city = city if city.valid? || self.city
  end
end

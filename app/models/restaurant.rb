class Restaurant < ApplicationRecord

  belongs_to :user
  belongs_to :city
  has_many :recommendations, :dependent => :destroy
  accepts_nested_attributes_for :city, reject_if: :all_blank
  validates :name, presence: true
  validates :additional_info, length: {minimum: 5, maximum: 200}, allow_blank: true
  validates_associated :city

  def city_name
    self.try(:city).try(:name)
  end
  
  def city_attributes=(attributes)
    if attributes["name"] != ""
      city = City.find_or_create_by(attributes)
      self.city = city if city.valid? || self.city
    end 
  end
end
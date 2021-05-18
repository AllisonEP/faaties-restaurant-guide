class Recommendation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant, reject_if: :all_blank
  validates :try, length: {minimum: 3, maximum: 55}, presence: true
  validates :avoid, length: {minimum: 3, maximum: 55}, allow_blank: true
end

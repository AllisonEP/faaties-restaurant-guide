class Restaurant < ApplicationRecord
  belongs_to :user
  belongs_to :city
  accepts_nested_attributes_for :city
end

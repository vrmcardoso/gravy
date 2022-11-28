class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :ranks
end

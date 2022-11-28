class Category < ApplicationRecord
  has_many :dishes

  validates :name, presence: true
  validates :name, uniqueness: true
  
end

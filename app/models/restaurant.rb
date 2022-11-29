class Restaurant < ApplicationRecord
  has_many :dishes, dependent: :destroy
  has_many :categories, through: :dishes

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :address, presence: true
end

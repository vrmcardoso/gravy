class Category < ApplicationRecord
  has_many :dishes
  has_one_attached :photo

  validates :name, presence: true
  validates :name, uniqueness: true

end

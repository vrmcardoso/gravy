class Restaurant < ApplicationRecord
  has_many :dishes, dependent: :destroy
  has_many :categories, through: :dishes

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end

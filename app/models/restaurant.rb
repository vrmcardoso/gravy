class Restaurant < ApplicationRecord
  has_many :dishes, dependent: :destroy
  has_many :categories, through: :dishes
  has_many :restaurant_categories
  has_one_attached :photo

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :address, presence: true



  include PgSearch::Model
  pg_search_scope :global_search,
                  against: [:name],
                  # associated_against: {
                  #   category: [:name, :cuisine, :food_type],
                  #   dish: [:name]
                  # },
                  using: {
                    tsearch: { prefix: true }
                  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end

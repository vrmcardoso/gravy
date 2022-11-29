class Restaurant < ApplicationRecord
  has_many :dishes, dependent: :destroy
  has_many :categories, through: :dishes

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
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
end

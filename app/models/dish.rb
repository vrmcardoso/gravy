class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :ranks

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: [:name],
                  associated_against: {
                    category: [:name, :cuisine, :food_type],
                    restaurant: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end

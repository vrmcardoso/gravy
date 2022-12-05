class Rank < ApplicationRecord
  belongs_to :user
  belongs_to :dish

  validates :user, uniqueness: { scope: :dish }
end

class Category < ApplicationRecord
  has_many :dishes
  has_many :ranks, through: :dishes
  has_one_attached :photo

  validates :name, presence: true
  validates :name, uniqueness: true

  def best_ranked
    ranks.order(:ranking).first.dish
  end
end

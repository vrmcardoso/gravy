class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :ranks

  def ranked_dishes
    ranks.map(&:dish)
  end

  def ranked_categories
    ranked_dishes.map(&:category).uniq
  end
end

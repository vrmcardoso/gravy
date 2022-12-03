class AddPointsToRestaurantCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurant_categories, :points, :integer
  end
end

class CategoriesController < ApplicationController

  def top
    @dishes = Dish.all.order("sum_points DESC")
    @restaurants = Restaurant.all
  end

end

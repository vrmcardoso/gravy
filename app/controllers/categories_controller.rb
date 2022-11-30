class CategoriesController < ApplicationController

  def top
    @dishes = Dish.all.order("sum_points DESC")
    @restaurants = Restaurant.all
    #@dishes_bolognese = Dish.all.where(category_id: 6).order("sum_points DESC")
  end
end

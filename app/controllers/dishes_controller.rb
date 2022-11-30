class DishesController < ApplicationController

  def index
    @dishes = Dish.all
    @restaurants = Restaurant.all
    
  end

  def show
    @dish = Dish.find(params[:id])
  end

end

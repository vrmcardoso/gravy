class RestaurantsController < ApplicationController

  def method_name
    @restaurant = Restaurant.find(params[:id])
  end

end

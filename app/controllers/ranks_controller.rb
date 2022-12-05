class RanksController < ApplicationController

  def show
    @dishes = Dish.all
    @categories = Category.all
    @ranks = Rank.all
    @restaurants = Restaurant.all
    @restaurants_categories = RestaurantCategory.all

    target_categories = []
    # categories of a specific restaurant
    target_restaurant_categories = @restaurants_categories.select { |res_cat| res_cat.restaurant_id == 4 }
    # categories id and points of each category of that specific restaurant
    target_restaurant_categories.each do |res_cat|
      target_categories << { category: res_cat.category_id, points: res_cat.points }
    end
    target_categories = target_categories.uniq

    # #all restaurants for a specific category
    # all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == 2 }
    # #  restaurant id and points of each restaurant for a specific category
    # target_restaurants = []
    # all_target_category_restaurants.each do |res_cat|
    #   target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
    # end
    # raise
    # # rank of restaurants
    # target_restaurant_sort = target_restaurants.sort_by { |result| result[:points] }.reverse
    # # display of the restaurants
    # @target_restaurant_sort = target_restaurant_sort.map { |result| Restaurant.find(result[:restaurant]) }
    # # position of a specific restaurant on a specific category
    # @position = @target_restaurant_sort.find_index(Restaurant.find(3)) + 1

    #all positions for a specific restaurant
    @position = []
    target_categories.each do |category|
      all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == category[:category] }
      target_restaurants = []
      all_target_category_restaurants.each do |res_cat|
        target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
      end
      target_restaurant_sort = target_restaurants.sort_by { |result| result[:points] }.reverse
      @target_restaurant_sort = target_restaurant_sort.map { |result| Restaurant.find(result[:restaurant]) }
      @position << { category: category[:category], position: (@target_restaurant_sort.find_index(Restaurant.find(4)) + 1) }
    end
    raise

  end

  def create
    @dish = Dish.find(params[:dish_id])
    @rank = Rank.new(rank_params)
    @rank.user = current_user
    @rank.dish = @dish
    if @rank.save
      @dish.update(sum_points: ranking_converter(@dish.sum_points, rank_params["ranking"].to_i))
      redirect_to @dish
    else
      render "dishes/show", status: :unprocessable_entity
    end
  end

  def update
    @dish = Dish.find(params[:dish_id])
    @rank = current_user.ranks.find_by(dish: @dish)
    old_rank = @rank.ranking.to_i
    new_rank = rank_params["ranking"].to_i
    @rank.update(ranking: new_rank)
    @dish.update(sum_points: ranking_converter(@dish.sum_points, new_rank, old_rank))
    redirect_to @dish
  end

  private

  def rank_params
    params.require(:rank).permit(:ranking)
  end

  def ranking_converter(sum, new_rank, old_rank = 0)
    new_inverted_rank = 10 - new_rank + 1
    if old_rank > 0
      old_inverted_rank = 10 - old_rank + 1
    else
      old_inverted_rank = 0
    end
    output = sum + new_inverted_rank - old_inverted_rank
    return output
  end
end

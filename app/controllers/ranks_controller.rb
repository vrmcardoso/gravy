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

  end

  def create
    @dish = Dish.find(params[:dish_id])
    @rank = Rank.new(rank_params)
    new_rank = rank_params["ranking"].to_i
    @rank.user = current_user
    @rank.dish = @dish
    if @rank.save
      rank_rearrange(@dish, new_rank)
      @dish.update(sum_points: ranking_converter(@dish.sum_points, rank_params["ranking"].to_i))
      restaurant_points_update(Restaurant.find(@dish.restaurant_id))
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
    rank_rearrange(@dish, new_rank, old_rank)
    @rank.update(ranking: new_rank)
    @dish.update(sum_points: ranking_converter(@dish.sum_points, new_rank, old_rank))
    restaurant_points_update(Restaurant.find(@dish.restaurant_id))
    redirect_to @dish
  end

  private

  def rank_params
    params.require(:rank).permit(:ranking)
  end

  def ranking_converter(sum, new_rank, old_rank = 0)
    if new_rank < 11
      new_inverted_rank = 10 - new_rank + 1
    else
      new_inverted_rank = 0
    end
    if old_rank > 0
      old_inverted_rank = 10 - old_rank + 1
    else
      old_inverted_rank = 0
    end
    output = sum + new_inverted_rank - old_inverted_rank
    return output
  end

  def rank_rearrange(dish, new_rank, old_rank=nil)
    @category = Category.find(dish.category_id)
    @dishes = Dish.where("category_id = ?", @category.id)
    @ranks = []
    @dishes.each do |dish|
      if rank = dish.ranks.find_by(user: current_user)
        @ranks << rank
      end
    end
    @ranks.each do |rank|
      if old_rank
        if new_rank < old_rank
          if rank.ranking < old_rank && rank.ranking >= new_rank
            rank_to_update = rank.ranking
            rank.update(ranking: rank.ranking + 1)
            dish = Dish.find(rank.dish_id)
            dish.update(sum_points: ranking_converter(dish.sum_points, rank.ranking, rank_to_update))
          end
        else
          if rank.ranking > old_rank && rank.ranking <= new_rank
            rank_to_update = rank.ranking
            rank.update(ranking: rank.ranking - 1)
            dish = Dish.find(rank.dish_id)
            dish.update(sum_points: ranking_converter(dish.sum_points, rank.ranking, rank_to_update))
          end
        end
      else
        if rank.ranking >= new_rank
          rank_to_update = rank.ranking
          rank.update(ranking: rank.ranking + 1)
          dish = Dish.find(rank.dish_id)
          dish.update(sum_points: ranking_converter(dish.sum_points, rank.ranking, rank_to_update))
        end
      end
    end
  end

  def restaurant_points_update(restaurant)
    @restaurant_categories = RestaurantCategory.where("restaurant_id = ?", restaurant.id)
    sum = 0
    @restaurant_categories.each do |rest_category|
      restaurant.dishes.each do |dish|
        sum += dish.sum_points
      end
      rest_category.update(points: sum)
    end
  end
end

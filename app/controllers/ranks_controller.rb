class RanksController < ApplicationController

  def show
    @dishes = Dish.all
    @categories = Category.all
    @ranks = Rank.all

    # get the current user ranks (i.e ranking >0 and id= current id)
    @user_ranks = @ranks.select { |rank| rank.user_id == current_user.id }


    @relevant_categories = []
    @all_dishes = []
    @all_user_categories_id = []

    @user_ranks.each do |user_rank|
      @dish_id = user_rank.dish_id
      @dish = @dishes.find { |dish| dish.id == @dish_id }
      @all_dishes << @dish
      @category_id = @dish.category_id
      @user_categories = @categories.find { |category| category.id == @category_id }
      @all_user_categories_id << @user_categories.id
      @all_user_categories_id = @all_user_categories_id.uniq
      @relevant_categories << @user_categories.name
      @relevant_categories = @relevant_categories.uniq
    end



    @user_ranked_dishes = @all_dishes.filter { |dish| @relevant_categories.include? dish.category.name }

    #dishes of a specific User_category
    @dishes_category_zero = @user_ranked_dishes.filter { |user_ranked_dish| @all_user_categories_id[0] == user_ranked_dish.category.id }

    #sort dishes by user rank
      #dish id
      @dishes_category_zero[0].id
      #rank of that dish
      @rank = @user_ranks.find { |user_rank| user_rank.dish_id == @dishes_category_zero[0].id }
      #rank "points"
      @rank.ranking

      results = []
      @dishes_category_zero.each do |dish|
        @id = dish.id
        @rank = @user_ranks.find { |user_rank| user_rank.dish_id == @id }
        @rank_ranking = @rank.ranking
        results << { id: @id, rank: @rank_ranking }
      end

      @result = results.sort_by { |result| result[:rank] }.reverse

      @dishes_sorted = @result.map { |result| Dish.find(result[:id])}

      raise
    # @target_category = @categories(params[:id])
    # @user_target_category_dishes = @user_ranked_dishes.filter { |user_ranked_dish| @all_user_categories_id[@target_category] == user_ranked_dish.category.id }
    # @user_target_category_dishes.each do |dish|
    #   @id = dish.id
    #   @rank = @user_ranks.find { |user_rank| user_rank.dish_id == @id }
    #   @rank_ranking = @rank.ranking
    #   results << { id: @id, rank: @rank_ranking }
    # end

    # @result = results.sort_by { |result| result[:rank] }.reverse

    # @dishes_sorted = @result.map { |result| Dish.find(result[:id])}

raise
  end
end

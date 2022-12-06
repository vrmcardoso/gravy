class UsersController < ApplicationController

  def show
    @user = current_user
    @ranks = Rank.where("user_id = ?", @user.id)
    @dishes = []
    @ranks.each do |rank|
      @dishes << Dish.find(rank.dish_id)
    end
    @restaurants = []
    @dishes.each do |dish|
      @restaurants << Restaurant.find(dish.restaurant_id)
    end

    rank
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :photo)
  end

  def rank
    @dishes = Dish.all
    @categories = Category.all
    @ranks = Rank.all

    # get the current user ranks (i.e ranking >0 and id= current id)
    @user_ranks = @ranks.select { |rank| rank.user_id == current_user.id }

    @relevant_categories = []
    @all_dishes = []
    @all_user_categories_id = []

    @total_user_categories = []
    @user_ranks.each do |user_rank|
      @dish_id = user_rank.dish_id
      @dish = @dishes.find { |dish| dish.id == @dish_id }
      @all_dishes << @dish
      @category_id = @dish.category_id

      @user_category = @categories.find { |category| category.id == @category_id }
      @total_user_categories << @user_category

      @all_user_categories_id << @user_category.id
      @all_user_categories_id = @all_user_categories_id.uniq
      @relevant_categories << @user_category.name
      @relevant_categories = @relevant_categories.uniq
    end

    @total_user_categories = @total_user_categories.uniq
    @user_ranked_dishes = @all_dishes.filter { |dish| @relevant_categories.include? dish.category.name }
    @results = []

    if params[:query].present?
      @target_category = @categories.find(params[:query])
      @user_target_category_dishes = @user_ranked_dishes.filter { |user_ranked_dish| @all_user_categories_id[@target_category.id] == user_ranked_dish.category.id }

      @user_target_category_dishes.each do |dish|
        @id = dish.id
        @rank = @user_ranks.find { |user_rank| user_rank.dish_id == @id }
        @rank_ranking = @rank.ranking
        @results << { id: @id, rank: @rank_ranking }
      end

      @result = @results.sort_by { |result| result[:rank] }.reverse
      @dishes_sorted = @result.map { |result| Dish.find(result[:id]) }


    else
      @dishes_sorted = []
    end

  end
end

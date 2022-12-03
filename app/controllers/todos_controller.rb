class TodosController < ApplicationController
  before_action :set_todo, only: %i[ move]

  def move
    @todo.insert_ad(params[:position].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:description, :position)
    end
end

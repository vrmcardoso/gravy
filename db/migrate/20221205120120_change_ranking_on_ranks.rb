class ChangeRankingOnRanks < ActiveRecord::Migration[7.0]
  def change
    change_column :ranks, :ranking, :integer, default: 0
  end
end

class AddPriceToDishes < ActiveRecord::Migration[7.0]
  def change
    add_column :dishes, :price, :integer
  end
end

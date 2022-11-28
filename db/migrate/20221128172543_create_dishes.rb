class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :recipe
      t.integer :sum_points
      t.boolean :milk
      t.boolean :eggs
      t.boolean :peanuts
      t.boolean :shellfish
      t.boolean :wheat
      t.boolean :soy
      t.references :restaurant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
